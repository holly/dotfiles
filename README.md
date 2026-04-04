# My Dotfiles

This repository is a collection of dotfiles managed using [chezmoi](https://www.chezmoi.io/). By using chezmoi, you can easily synchronize and manage settings across multiple machines.

---

## Prerequisites

- [chezmoi](https://www.chezmoi.io/) must be installed.
- Git must be installed.

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
# clone this repository, initialize and appy the settings
chezmoi init --apply $GITHUB_USER
```

## Managed Configuration Files

The main configuration files managed in this repository are as follows:

- .vimrc: Vim configuration file
- .gitconfig: 
- (Add other files here as needed)

## License

This repository is provided under the [MIT License](https://opensource.org/license/mit)

### Notes:

- Replace `$GITHUB_USERNAME` with your actual GitHub username or repository URL.
- You can add more files or sections as needed by following the same format.
