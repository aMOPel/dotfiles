
# My Dotfiles

managed by [chezmoi](https://www.chezmoi.io/)

__WARNING:__ this will not just clone but also apply these dotfiles to your home directory!
```shell
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply aMOPel
```

## Features:

### config for:
  * __kitty__
  * __zsh__
  * __nvim__ (large focus on nvim)
  * __ranger__
  * bat
  * cvim
  * git
  * gitui
  * zathura

### dependencies / programs I use:
  * kovidgoyal/kitty
  * neovim/neovim/nvim
  * x-motemen/ghq
  * extrawurst/gitui
  * tree-sitter/tree-sitter
  * charmbracelet/glow
  * karan/joe
  * ajeetdsouza/zoxide
  * burntsushi/ripgrep
  * sharkdp/fd
  * godotengine/godot
  * junegunn/fzf
  * twpayne/chezmoi

These are installed as binaries from github using a custom script. (to ensure latest version, regardless of os version)
Also many dependencies are installed with `apt` assuming you are on a debian based distro.
Otherwise things will break unless you provide the dependencies.

### font: 
(already embedded in the repo)
  * FiraCode NerdFont (https://www.nerdfonts.com/font-downloads)

### colorscheme:
(already embedded in the repo)
  * in kitty and nvim: onedark
      (https://github.com/navarasu/onedark.nvim)
      (https://github.com/kdrag0n/base16-kitty)
