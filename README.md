# Minimal Effective Neovim Configuration

This repository contains my personal Neovim configuration, designed to be minimal yet effective for various programming tasks.

## Features

- Relative line numbers
- Auto-closing brackets
- Auto-indentation
- LSP support for multiple languages
- Syntax highlighting using Treesitter
- File tree with icons
- File and word search capabilities
- Horizontal terminal support
- Format on save
- Completion with scrollable suggestions (Tab and Shift-Tab)

## Supported Languages

- Python
- C/C++
- JavaScript / React / Typescript
- CSS
- HTML
- Markdown
- Lua
- JSON

## Prerequisites

- `neovim` (>= 0.5.0)
- `git`
- `node`
- `ripgrep`
- Nerd font of your choice

## Installation

1. Backup your existing Neovim configuration if you have one:

   ```
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. Clone this repository:

   ```
   git clone git@github.com:dan10ish/dotfiles.git ~/.config/nvim
   ```

3. Install Packer (plugin manager):

   ```
   git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
   ```

4. Open Neovim and install plugins:

   ```
   nvim +PackerSync
   ```

5. Install language servers:

   - For Python: `npm install -g pyright`
   - For JavaScript/TypeScript: `npm install -g typescript typescript-language-server`
   - For HTML/CSS: `npm install -g vscode-langservers-extracted`
   - For C/C++: Install `clangd` using your system's package manager, in mac - `brew install llvm`

6. Install Treesitter parsers:
   ```
   :TSInstall python cpp c lua vim javascript typescript html css json markdown tsx
   ```

## Usage

- File Explorer: `<Space>e`
- Find Files: `<Space>ff`
- Live Grep (search in files): `<Space>fg`
- Open horizontal terminal: `<Space>t`

## Adding Language Support

To add support for a new language:

1. Install the appropriate language server.
2. Add the server to the `servers` table in `init.lua`:
   ```lua
   local servers = { 'pyright', 'clangd', 'tsserver', 'html', 'cssls', 'your_new_server' }
   ```
3. Install the Treesitter parser:
   ```
   :TSInstall your_new_language
   ```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).
