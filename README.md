# My Dotfiles

This repository is a collection of dotfiles managed using [chezmoi](https://www.chezmoi.io/). By using chezmoi, you can easily synchronize and manage settings across multiple machines.

---

## Prerequire

- [chezmoi](https://www.chezmoi.io/)
- Git
- [age](https://age-encryption.org/)

---

## Installing chezmoi

To install chezmoi, run the following command:

```bash
# Download and install the latest version
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
```
## bitwarden cli

### install

```bash
sh -c "$(https://gist.githubusercontent.com/holly/e080372da4e8ca9aad7259540acd9077/raw/bitwarden_install.sh)" -- install
```

### login

```bash
# normal login
bw login

# login by apikey
bw login --apikey
```

### unlock

#### bash, zsh

```bash
export BW_SESSION=$(bw unlock --raw)
```
#### fish

```fish
set -x BW_SESSION (bw unlock --raw)
```

## Initialize

```bash
# clone this repository, initialize and apply the settings
chezmoi init --apply $GITHUB_USER
```

After running the above command, the following processes will be executed automatically:

- OS detection (RHEL/CentOS/Fedora or Debian/Ubuntu)
- Package installations according to the detected OS:
  - Development tools
  - Docker and related packages
  - Utilities (age, ripgrep, bat, glow, fd-find, duf, shellcheck, etc.)
- Adding user to docker group
- Installing various tools:
  - Root-required tools (AWS CLI, Fish shell, Neovim, etc.)
  - User-level tools (shfmt, LuaLS, etc.)
- Installing runtime management tools (Claude CLI, Bun, uv, mise, zvm)
- Installing Node.js and Zig programming languages
- Setting up Fish shell plugin manager (Fisher) and plugins
- Installing Neovim plugin development tools

## Managed Configuration Files

The main configuration files managed in this repository are as follows:

- .vimrc: Vim configuration file
- .gitconfig: Git global configuration file
- .bash_profile: Bash profile configuration
- .czrc: Commitizen configuration file
- .tmux.conf: Tmux configuration file
- .ripgreprc: Ripgrep configuration file
- .ssh/config: SSH client configuration file
- .env/*: Environment variable files
- nvim/: Neovim configuration directory
- fish/: Fish shell configuration directory
- cz-git/: Commitizen git configuration directory

## Neovim Configuration

This repository includes a comprehensive Neovim configuration with the following plugins and LSP servers:

### Plugins:
- blink.cmp: Completion engine
- nvim-treesitter: Syntax highlighting and code parsing
- telescope.nvim: Fuzzy finder
- conform.nvim: Code formatter
- nvim-lualine: Status line
- mini.align: Alignment tool
- hlchunk: Visual code block highlighting
- coderunner: Code execution

### LSP Servers:
- bashls: Bash/Shell script support
- pyright: Python language support
- vtsls: TypeScript/JavaScript language support
- lua_ls: Lua language support
- zls: Zig language support

## License

This repository is provided under the [MIT License](https://opensource.org/license/mit)

### Notes:

- Replace `$GITHUB_USERNAME` with your actual GitHub username or repository URL.
- You can add more files or sections as needed by following the same format.
