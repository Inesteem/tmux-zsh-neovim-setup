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

## Dependencies

You should have make, python3, neovim, tmux, clangd, zsh and oh-my-zsh installed on your system.

Setup a virtual python3 env in ~/env (see https://docs.python.org/3/library/venv.html).
In your python3 environment, install isort, black, neovim and pynvim.

Also, nerd fonts should be downloaded and setup in iterm to be used as default font.
Some symbols might be weird otherwise.

sudo npm i -g vscode-json-languageserver

sudo npm i -g bash-language-server


## Getting Started
1. Clone the repository into your home directory.
2. Launch Neovim — Lazy.nvim will take care of plugin installation.
3. Adjust `options.lua`, `keymaps.lua`, or add your own plugins as needed for further customization.
4. Install some system dependencies I for sure forgot to mention here (:checkhealth and :Lazy D to the rescue!)
5. Enjoy a state-of-the-art coding environment for Python and C++ development!

---

## Highlights

- Modular Lua configuration for maintainable, extensible Neovim setups.
- Best-in-class plugins and tooling for coding productivity.
- Ready for cross-platform use: macOS and Linux compatible.
- Includes dotfiles for a cohesive shell and terminal workflow.

---

> Explore, customize, and enjoy a high-performance Neovim coding environment tailored for developers!
