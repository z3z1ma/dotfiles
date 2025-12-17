# CLAUDE.md

**Note**: This project uses [bd (beads)](https://github.com/steveyegge/beads) for issue tracking. Use `bd` commands instead of markdown TODOs. See @AGENTS.md for workflow details.

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **chezmoi dotfiles repository** for managing personal configuration files across different machines. Chezmoi is a dotfile manager that handles templating, encryption, and cross-platform compatibility.

### Key Structure

- `dot_config/` - Configuration files that map to `~/.config/` (chezmoi naming convention)
- `dot_config/nvim/` - Neovim configuration (detailed below)
- Scripts and templates for automated setup on macOS
- Encrypted sensitive files (`.asc` extension)

## Neovim Configuration Architecture

The Neovim setup is located in `dot_config/nvim/` and follows a custom structure around the `zezima` namespace:

### Core Architecture

- **Entry Point**: `init.lua` - Sets leader keys, imports core modules, enables LSPs, configures diagnostics
- **Namespace**: All custom code lives under `lua/zezima/`
- **Plugin System**: Uses modern Neovim native package manager (`vim.pack.add`)
- **LSP Configuration**: Individual LSP configs in `lsp/` directory
- **Theme**: Catppuccin colorscheme

### Key Directories

- `lua/zezima/config/` - Core configuration (autocmds, keymaps, options)
- `lua/zezima/plugins/` - Individual plugin configurations (~30+ plugins)
- `lsp/` - Language server configurations for 10+ languages
- `plugin/` - Custom Vim plugins (watchman, tmux clipboard, user commands)
- `after/` - After-load configurations
- `snippets/` - Code snippets

### LSP Languages Supported

The configuration supports these LSPs (enabled in `init.lua:41-52`):
- `bashls`, `clangd`, `clojure_lsp`, `cmake`, `copilot`
- `lua_ls`, `nil_ls`, `ruff`, `rust_analyzer`, `ty`

### Notable Plugins & Features

- **Claude Code Integration**: Full keybinding setup in `lua/zezima/plugins/claude.lua`
- **Completion**: Uses `blink.cmp` for completion engine
- **File Navigation**: Harpoon for quick file switching
- **Fuzzy Finding**: Snacks picker for LSP symbols, files, etc.
- **Git Integration**: Fugitive + Gitsigns
- **Formatting**: Conform.nvim with language-specific formatters

## Development Commands

### Lua Formatting
```bash
stylua . --config-path stylua.toml
```

### Chezmoi Commands
```bash
# Apply dotfiles
chezmoi apply

# Check for differences
chezmoi diff

# Edit a file (opens in $EDITOR)
chezmoi edit ~/.config/nvim/init.lua

# Re-run scripts
chezmoi state delete-bucket --bucket=entryState
```

### Package Management
Package definitions are in `.chezmoidata/packages.yaml` and installed via:
```bash
# Run brew bundle installation
chezmoi apply --include=scripts
```

## Important Configuration Details

### Neovim Keybinding Patterns

- **Leader Key**: `<space>`
- **Local Leader**: `\`
- **Claude Code Prefix**: `<leader>a` (all Claude commands start here)
- **Search Prefix**: `<leader>s` (LSP symbols, workspace symbols)
- **Code Actions**: `<leader>c` (rename, code actions)

### File Naming Conventions

- `dot_*` files map to `.*` in home directory
- Template files end in `.tmpl` (processed by chezmoi)
- Encrypted files end in `.asc`
- `run_once_*` scripts execute once per machine
- `run_onchange_*` scripts run when file changes

### LSP Configuration Pattern

Each LSP has its own file in `lsp/` directory following pattern:
```lua
vim.lsp.config[name] = {
  -- configuration here
}
```

## Code Style Guidelines

- **Lua**: 2-space indentation, double quotes preferred (see `stylua.toml`)
- **Line Width**: 120 characters max
- **Requires**: Alphabetically sorted when practical
- **Comments**: Minimal commenting style preferred
