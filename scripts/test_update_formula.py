import io
import json
import unittest
from unittest.mock import patch
from urllib.error import HTTPError

from update_formula import get_latest_release


def _http_error(url, code):
    return HTTPError(url, code, f"HTTP {code}", {}, None)


def _json_response(payload):
    return io.BytesIO(json.dumps(payload).encode("utf-8"))


class TestGetLatestRelease(unittest.TestCase):
    @patch("update_formula.urlopen")
    def test_fetches_v_prefixed_tag(self, mock_urlopen):
        mock_urlopen.return_value = _json_response({"tag_name": "v0.1.16", "assets": [{"name": "a.tar.gz"}]})
        version, assets = get_latest_release("nicholaswilde/enstow", version="0.1.16", retries=0)
        self.assertEqual(version, "0.1.16")
        self.assertEqual(len(assets), 1)
        self.assertEqual(
            mock_urlopen.call_args[0][0].full_url,
            "https://api.github.com/repos/nicholaswilde/enstow/releases/tags/v0.1.16",
        )

    @patch("update_formula.urlopen")
    def test_falls_back_to_unprefixed_tag_on_404(self, mock_urlopen):
        mock_urlopen.side_effect = [
            _http_error("https://api.github.com/repos/o/r/releases/tags/v1.2.3", 404),
            _json_response({"tag_name": "1.2.3", "assets": []}),
        ]
        version, assets = get_latest_release("o/r", version="1.2.3", retries=0)
        self.assertEqual(version, "1.2.3")
        self.assertEqual(assets, [])
        self.assertEqual(mock_urlopen.call_count, 2)

    @patch("update_formula.time.sleep")
    @patch("update_formula.urlopen")
    def test_retries_transient_404_then_succeeds(self, mock_urlopen, mock_sleep):
        mock_urlopen.side_effect = [
            _http_error("https://api.github.com/repos/o/r/releases/tags/v0.1.16", 404),
            _http_error("https://api.github.com/repos/o/r/releases/tags/0.1.16", 404),
            _json_response({"tag_name": "v0.1.16", "assets": []}),
        ]
        version, _ = get_latest_release("o/r", version="0.1.16", retries=2, retry_delay=1)
        self.assertEqual(version, "0.1.16")
        mock_sleep.assert_called_once_with(1)

    @patch("update_formula.time.sleep")
    @patch("update_formula.urlopen")
    def test_persistent_404_mentions_draft_release(self, mock_urlopen, mock_sleep):
        mock_urlopen.side_effect = _http_error("https://api.github.com/repos/o/r/releases/tags/v0.1.16", 404)
        with self.assertRaises(RuntimeError) as ctx:
            get_latest_release("o/r", version="0.1.16", retries=1, retry_delay=1)
        self.assertIn("draft releases return 404", str(ctx.exception))
        mock_sleep.assert_called_once_with(1)

    @patch("update_formula.time.sleep")
    @patch("update_formula.urlopen")
    def test_non_404_error_fails_fast(self, mock_urlopen, mock_sleep):
        mock_urlopen.side_effect = _http_error("https://api.github.com/repos/o/r/releases/tags/v0.1.16", 403)
        with self.assertRaises(HTTPError) as ctx:
            get_latest_release("o/r", version="0.1.16", retries=2, retry_delay=1)
        self.assertEqual(ctx.exception.code, 403)
        self.assertEqual(mock_urlopen.call_count, 1)
        mock_sleep.assert_not_called()


if __name__ == "__main__":
    unittest.main()
