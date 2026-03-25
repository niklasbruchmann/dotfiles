# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites

- `stow`
- `zsh`
- `neovim`
- `ghostty`
- `starship`
- `BlexMono Nerd Font`

### Install prereqs

macOS (Homebrew):

```sh
brew install stow neovim starship zsh-syntax-highlighting
brew tap homebrew/cask-fonts
brew install --cask font-blex-mono-nerd-font
```

Arch (pacman & yay):

```sh
sudo pacman -S --needed stow neovim starship zsh
yay -S --needed ttf-blex-nerd-font
```

Debian (apt):

```sh
sudo apt update
sudo apt install -y stow zsh neovim starship
```

### Neovim (Kickstart.nvim) deps

- `git`, `make`, `unzip`, C compiler (`gcc`/`clang`)
- `ripgrep`, `fd`
- `tree-sitter` CLI
- clipboard tool (Linux: `xclip`/`xsel`)
- optional: Nerd Font, language tooling (`npm`, `go`, …)

macOS (Homebrew):

```sh
brew install ripgrep fd tree-sitter make
```

Arch (pacman):

```sh
sudo pacman -S --needed ripgrep fd tree-sitter make gcc unzip
```

Debian(apt):

```sh
sudo apt update
sudo apt install -y git make unzip gcc ripgrep fd-find tree-sitter-cli xclip
```

## Install

```sh
./install.sh
```

`install.sh` stows all non-hidden top-level directories (`*/`).

## Uninstall

```sh
./uninstall.sh
```

`uninstall.sh` unstows all packages.