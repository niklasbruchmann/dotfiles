# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites

- `stow`
- `zsh`
- `neovim`
- `ghostty`
- `starship`
- `BlexMono Nerd Font`

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