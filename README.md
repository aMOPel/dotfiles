
# My Dotfiles

managed by [chezmoi](https://www.chezmoi.io/)

__WARNING:__ this will not just clone but also apply these dotfiles to your home directory!
```shell
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply aMOPel
```

## Features:

### Config For:
  * __Kitty__
  * __Bash__
  * __NeoVim__ (large focus on nvim)
  * __Ranger__
  * bat
  * git
  * LazyGit
  * Zathura

### Dependencies / Programs I Use:
  * kovidgoyal/kitty
  * neovim/neovim/nvim
  * x-motemen/ghq
  * tree-sitter/tree-sitter
  * karan/joe
  * ajeetdsouza/zoxide
  * burntsushi/ripgrep
  * sharkdp/fd
  * junegunn/fzf
  * twpayne/chezmoi

These are installed as binaries from GitHub using a custom script, to ensure a certain version, regardless of os version.
Also many dependencies are installed with `apt` assuming you are on a debian based distro.
Otherwise things will break unless you provide the dependencies.

### Font 
(already embedded in the repo)
  * FiraCode NerdFont (https://www.nerdfonts.com/font-downloads)

### Colorscheme
(already embedded in the repo)
  * in kitty and nvim: onedark
      (https://github.com/navarasu/onedark.nvim)
      (https://github.com/kdrag0n/base16-kitty)
