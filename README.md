# 🍺 Homebrew Tap 🍺

The homebrew tap for various tools.

## 🚀 Usage

First, tap the repository:

```bash
brew tap nicholaswilde/homebrew-tap
```

Then, install a formula:

```bash
brew install <formula>
```

## 📦 Available Formulas

- `adguardhome-mcp-rs`: 🛡️ A Rust implementation of an AdGuard Home MCP server 🤖
- `aria2-mcp-rs`: 🦀 A rust implementation of an aria2 MCP server. 🤖
- `changedetection-mcp-rs`: 🔄 A Rust implementation of a ChangeDetection.io MCP server 🤖
- `cook-docs`: A tool for automatically generating markdown documentation for cooklang recipes.
- `gatus-mcp-rs`: 🦀 A Rust implementation of a Gatus MCP server 🤖
- `proxmox-mcp-rs`: 🦀 A rust implementation of a proxmox MCP server. 🤖
- `qbittorrent-mcp-rs`: 🧲 A qBittorrent MCP server written in Rust 🤖
- `recipes-mcp-rs`: 🍳 An MCP server that imports recipes 🤖
- `rescue-groups-mcp`: 🐶 An MCP server to interface with Rescue Groups written in Rust 🤖
- `side-eye-host`: USB Stat Monitor for Linux rig.
- `syncthing-mcp-rs`: 🔄 An MCP server written in Rust for controlling SyncThing 🤖

## 🛠️ Development

This project uses [Task](https://taskfile.dev/) for common development tasks.

### Auditing Formulas

Audit all formulas:
```bash
task audit
```

Audit a specific formula:
```bash
task audit:qbittorrent-mcp-rs
```

### Testing Formulas

Test all formulas:
```bash
task test
```

## :robot: Automation

This repository is configured to automatically audit, test, and update formulas. It utilizes custom Gemini commands to streamline maintenance:
- `add-formula`: Automates the creation of new formulas by fetching metadata and calculating checksums from GitHub.
- `update-formula`: Autonomously scans upstream repositories for new releases and updates formula versions and checksums.

## :balance_scale: License

​[Apache License 2.0](LICENSE)

## :writing_hand: Author

​This project was started in 2022 by [Nicholas Wilde][2].

[2]: <https://github.com/nicholaswilde/>
