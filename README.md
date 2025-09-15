# Structured Neovim Lua Configuration for Coders (Python & C++)

This repository provides a modular, efficient, and maintainable Neovim configuration built in Lua with [Lazy.nvim](https://github.com/folke/lazy.nvim).
It is tailored for developers—especially those working in **Python** and **C++**—offering comprehensive LSP support, modern productivity plugins, and a clean workflow.
Intended to be copied to your HOME folder.

## Features

- **Structured Lua Setup**  
  All configuration files are separated for easy maintainability and extension (`options.lua`, `keymaps.lua`, `plugins/`).

- **Lazy.nvim Plugin Management**  
  Lightning-fast startup with fully lazy-loaded plugins housed under `lua/plugins/`.

- **Intelligent Coding Features**  
  - **LSP Support**: Python (`pyright`), C++ (`clangd`) language servers configured.
  - **Autocomplete**: `nvim-cmp`, `LuaSnip`, and `friendly-snippets` for smart, context-aware code completion and snippets.
  - **Syntax Highlighting**: `nvim-treesitter` and `rainbow-delimiters` for enhanced code readability.

- **Productivity & Navigation**
  - **Telescope.nvim**: Fuzzy finder for files, buffers, and text.
  - **nvim-tree.lua**: Sidebar file explorer.
  - **Gitsigns.nvim**: Inline git status integration.
  - **Trouble.nvim**: Visual diagnostics, errors, and warnings management.
  - **todo-comments.nvim**: Highlight and search TODO, FIXME notes.
  - **Markdown Preview**: Live markdown preview.

- **Formatting & Autopairs**  
  - `conform.nvim` for on-save code formatting.
  - `.clang-format` for C++ code style.
  - `nvim-autopairs` for automatic insertion of brackets and quotes.

- **Shell and Terminal Productivity**
  - `.zshrc`, per-directory history, custom zsh configs.
  - `.tmux.conf` for a powerful terminal workflow.


## Getting Started

1. Clone the repository.
2. Symlink or copy `.config/nvim` into your home directory.
3. Launch Neovim—Lazy.nvim will take care of plugin installation.
4. Adjust `options.lua`, `keymaps.lua`, or add your own plugins as needed for further customization.
5. Enjoy a state-of-the-art coding environment for Python and C++ development!

---

## Highlights

- Modular Lua configuration for maintainable, extensible Neovim setups.
- Best-in-class plugins and tooling for coding productivity.
- Ready for cross-platform use: macOS and Linux compatible.
- Includes dotfiles for a cohesive shell and terminal workflow.

---

> Explore, customize, and enjoy a high-performance Neovim coding environment tailored for developers!
