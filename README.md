# Danish's Dotfiles

This repository contains my personal dotfiles for various applications.

## Index

- [Neovim](#neovim)
- [Ghostty](#ghostty)

## Neovim

### Prerequisites

- [Neovim](https://neovim.io/) (latest stable or nightly)
- [Git](https://git-scm.com/)
- A Nerd Font (for icons, e.g., [Liga SFMono Nerd Font](https://www.nerdfonts.com/font-downloads))
- **Language Servers**:
    -   Python: `npm install -g pyright`
    -   JavaScript/TypeScript: `npm install -g typescript typescript-language-server`
    -   HTML/CSS: `npm install -g vscode-langservers-extracted`
    -   C/C++: Install `clangd` (e.g., on macOS: `brew install llvm`)
- **Tree-sitter Parsers**:
    -   These are managed by `nvim-treesitter` and typically installed automatically or can be installed manually within Neovim using commands like `:TSInstall python cpp c lua vim javascript typescript html css json markdown tsx`. The configuration in `init.lua` ensures these are installed.

### Installation

1.  **Backup your existing Neovim configuration** (if any):
    ```bash
    mv ~/.config/nvim ~/.config/nvim.bak
    mv ~/.local/share/nvim ~/.local/share/nvim.bak
    mv ~/.local/state/nvim ~/.local/state/nvim.bak
    mv ~/.cache/nvim ~/.cache/nvim.bak
    ```
2.  Clone this repository:
    ```bash
    git clone https://github.com/dan10ish/dotfiles ~/dotfiles
    ```
3.  Create a symbolic link for the Neovim configuration:
    ```bash
    ln -s ~/dotfiles/nvim ~/.config/nvim
    ```
4.  Open Neovim. [Packer.nvim](https://github.com/wbthomason/packer.nvim) will automatically install itself and the configured plugins. If it's a fresh install, it will run `:PackerSync`. You can also run it manually if needed.

### Features

-   **Plugin Manager**: [Packer.nvim](https://github.com/wbthomason/packer.nvim) for managing plugins.
-   **LSP Configuration**: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) for language server protocol support.
    -   Configured for: Python (`pyright`), C/C++ (`clangd`), TypeScript (`ts_ls`), HTML (`html`), CSS (`cssls`).
-   **Autocompletion**: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) with sources from LSP and LuaSnip.
-   **Snippets**: [LuaSnip](https://github.com/L3MON4D3/LuaSnip).
-   **File Explorer**: [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) for a tree-like file explorer.
-   **Icons**: [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) for file and folder icons.
-   **Color Scheme**: [nvim-solarized-lua](https://github.com/ishan9299/nvim-solarized-lua).
-   **Fuzzy Finder**: [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for finding files, live grep, buffers, and help tags.
-   **Auto Pairs**: [nvim-autopairs](https://github.com/windwp/nvim-autopairs) for automatic insertion of closing pairs.
-   **Formatting and Linting**: [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim) with Prettier for formatting. Formatting on save is enabled.
-   **Syntax Highlighting**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for improved syntax highlighting and indentation.
    -   Parsers installed for: Python, C++, C, Lua, Vim, JavaScript, TypeScript, TSX, HTML, CSS, JSON, Markdown, Go, Rust, Bash.
-   **Commenting**: [Comment.nvim](https://github.com/numToStr/Comment.nvim) for easy commenting.
-   **Git Integration**: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) for Git decorations in the sign column.
-   **Keybinding Helper**: [which-key.nvim](https://github.com/folke/which-key.nvim) to display available keybindings.
-   **Basic Editor Settings**:
    -   Line numbers (relative and absolute).
    -   Auto-indent.
    -   Tabstop and shiftwidth set to 2 spaces.
    -   Expand tabs to spaces.
    -   System clipboard integration (`unnamedplus`).
    -   Smooth scrolling (`scrolloff = 8`).
    -   Mouse support enabled.
    -   Transparent background.
-   **Leader Key**: Space (` `)

### Key Mappings

| Key             | Action                         | Description                |
|-----------------|--------------------------------|----------------------------|
| `<leader>e`     | `:NvimTreeToggle<CR>`          | Explorer: Toggle           |
| `<leader>ff`    | `:Telescope find_files<CR>`    | Find: Files                |
| `<leader>fg`    | `:Telescope live_grep<CR>`     | Find: Live Grep            |
| `<leader>fb`    | `:Telescope buffers<CR>`       | Find: Buffers              |
| `<leader>fh`    | `:Telescope help_tags<CR>`     | Find: Help Tags            |
| `<leader>t`     | `:split \| terminal<CR>`      | Terminal: Horizontal Split |
| `<leader>vt`    | `:vsplit \| terminal<CR>`     | Terminal: Vertical Split   |
| `<C-h>`         | `<C-w>h`                       | Window: Focus Left         |
| `<C-j>`         | `<C-w>j`                       | Window: Focus Down         |
| `<C-k>`         | `<C-w>k`                       | Window: Focus Up           |
| `<C-l>`         | `<C-w>l`                       | Window: Focus Right        |
| `<C-S-c>`       | `:close<CR>`                   | Window: Close Current      |
| `<C-Tab>`       | `:bnext<CR>`                   | Buffer: Next               |
| `<C-S-Tab>`     | `:bprevious<CR>`               | Buffer: Previous           |
| `<leader>/`     | `<Plug>(comment_toggle_linewise_current)` | Comment: Toggle Line       |

**Completion Key Mappings (Insert Mode):**

| Key         | Action                      |
|-------------|-----------------------------|
| `<C-k>`     | Select previous completion  |
| `<C-j>`     | Select next completion      |
| `<Tab>`     | Select next completion      |
| `<S-Tab>`   | Select previous completion  |
| `<CR>`      | Confirm completion          |
| `<C-Space>` | Trigger completion          |


## Ghostty

### Installation

1.  Install [Ghostty terminal](https://ghostty.io/).
2.  Open Ghostty and access its configuration. This is often done by pressing `Command + ,` (on macOS) or a similar shortcut, then selecting an option like "Open Config File" or "Edit Configuration". This will open a `config.txt` file.
3.  **Backup your existing Ghostty configuration** (if any) by copying the content of the opened `config.txt` to a safe place.
4.  Replace the entire content of your Ghostty `config.txt` with the content from `ghostty/config.txt` in this repository.
    Alternatively, you can create a symbolic link if you prefer, but ensure Ghostty correctly loads it. The typical paths for the config file are:
    -   macOS: `~/Library/Application Support/ghostty/config.txt`
    -   Linux: `~/.config/ghostty/config.txt`
    -   Windows: `%APPDATA%\ghostty\config.txt`
    If using a symbolic link (example for macOS):
    ```bash
    # Ensure Ghostty is closed before running this
    # Backup existing config first:
    # mv ~/Library/Application\ Support/ghostty/config.txt ~/Library/Application\ Support/ghostty/config.txt.bak
    ln -s ~/dotfiles/ghostty/config.txt ~/Library/Application\ Support/ghostty/config.txt
    ```
    Adjust the path according to your operating system and clone location.

### Features & Configuration

-   **Font**:
    -   Family: "Liga SFMono Nerd Font"
    -   Size: 14
    -   Features: "calt", "ss01", "zero" (ligatures, stylistic sets, slashed zero)
-   **Appearance**:
    -   Window Padding: X=15, Y=15
    -   Window Theme: "dark"
    -   Window Decoration: Enabled
    -   Theme: "nord"
    -   Background Opacity: 0.98
    -   Cursor Style: Bar, blinking
    -   Minimum Contrast: 1.15
    -   Unfocused Split Opacity: 0.95
    -   macOS Titlebar Style: "transparent"
    -   Empty title for a cleaner look.
-   **Behavior**:
    -   Window state saved: "always"
    -   Inherit working directory for new windows/tabs.
    -   Hide mouse while typing.
    -   Copy on select.
    -   Scrollback Limit: 10000 lines
    -   Confirm before closing surface: Disabled
    -   Shell Integration: "detect" (features: cursor, sudo)
    -   Clipboard Read/Write: Allowed
    -   Bold is Bright: Enabled
    -   VSync: Enabled
    -   macOS Secure Input Indication: Enabled
    -   Inherit font size for new windows.
    -   Quit after last window closed.
    -   macOS Option key acts as Alt.
    -   GTK Single Instance: Enabled
    -   GTK Tabs Location: "top"

### Key Mappings

| Key               | Action                  | Description               |
|-------------------|-------------------------|---------------------------|
| `Ctrl+Shift+C`    | `copy_to_clipboard`     | Copy to clipboard         |
| `Ctrl+Shift+V`    | `paste_from_clipboard`  | Paste from clipboard      |
| `Ctrl+Shift+N`    | `new_window`            | New Window                |
| `Ctrl+Shift+T`    | `new_tab`               | New Tab                   |
| `Ctrl+Shift+W`    | `close_surface`         | Close Tab/Window          |
| `Ctrl+Shift+F`    | `toggle_fullscreen`     | Toggle Fullscreen         |
| `Ctrl+Shift+0`    | `reset_font_size`       | Reset Font Size           |
| `Ctrl+Shift+K`    | `scroll_to_top`         | Scroll to Top             |
| `Ctrl+Shift+J`    | `scroll_to_bottom`      | Scroll to Bottom          |
| `Ctrl+A` then `C` | `clear_screen`          | Clear Screen              |
| `Ctrl+A` then `R` | `reload_config`         | Reload Configuration File |
| `Ctrl+A` then `Q` | `close_surface`         | Close Tab/Window          |

---