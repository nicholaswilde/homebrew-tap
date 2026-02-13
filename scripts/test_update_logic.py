import unittest
import re

def update_formula_content(content, new_version, new_sha256_map):
    # Update version
    content = re.sub(r'version "([^"]+)"', f'version "{new_version}"', content)
    
    # Update sha256 (this is more complex because there are multiple)
    def replace_sha(match):
        return f'sha256 "{new_sha256_map.get("default", match.group(1))}"'
    
    content = re.sub(r'sha256 "([^"]+)"', replace_sha, content)
    return content

class TestUpdateLogic(unittest.TestCase):
    def test_version_update(self):
        content = '  version "0.8.0"\n  sha256 "old-hash"'
        updated = update_formula_content(content, "0.9.0", {"default": "new-hash"})
        self.assertIn('version "0.9.0"', updated)
        self.assertIn('sha256 "new-hash"', updated)

if __name__ == "__main__":
    unittest.main()
