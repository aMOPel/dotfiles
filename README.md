
# My Dotfiles

managed by [chezmoi](https://www.chezmoi.io/)

## Install in a Distrobox
Install docker, distrobox and start a distrobox

```shell
# install docker
sudo apt install -y ca-certificates lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
sudo groupadd docker
sudo usermod -aG docker $USER
echo "restart now"

sudo apt install -y docker-compose-plugin
```

```shell
# install distrobox 1.4.2
curl -s https://raw.githubusercontent.com/89luca89/distrobox/1.4.2/install | sudo sh
```

```shell
# create distrobox
BOX_HOME=/home/devenv

sudo rm -rf $BOX_HOME
sudo mkdir $BOX_HOME
sudo chown "$USER":"$USER" $BOX_HOME

distrobox create -i ubuntu:22.04 -n devenv -H $BOX_HOME
```

```shell
# enter distrobox (takes a little while)
distrobox enter devenv
```

```shell
# setup XDG vars
echo "cd ~"
cd ~

# make sure environment is not polluted
if [ -n "$SHSH_ROOT" ]; then
  echo '$SHSH_ROOT defined'; exit 1
fi
case "$PATH" in
  *fzf*)
    echo 'FZF already in $PATH'; exit 1
  ;;
esac

echo "setup XDG vars"
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
```

__WARNING:__ this will not just clone but also apply these dotfiles to your home directory!
```shell
cd ~
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply aMOPel
exit
```

It'll open neovim in the end to install plugins. After it's done:
1. close neovim (`:q` or `ZZ`)
1. exit the box (`$ exit`)
1. enter the box again
1. open neovim
1. generate packer cache (`:PackerCompile` or `<space>pr`)

```shell
# link host's docker
sudo ln -s /usr/bin/distrobox-host-exec /usr/bin/docker
```

```shell
# make host's app available in box
TARGET_APP=<some app>
echo "#! /bin/bash
distrobox-host-exec $TARGET_APP \$@" > ~/.local/bin/$TARGET_APP
chmod +x ~/.local/bin/$TARGET_APP
```

```shell
# make box's app available in host
TARGET_APP=brave-browser
distrobox-export --bin "$(which $TARGET_APP)" --export-path $DISTROBOX_HOST_HOME/.local/bin
TARGET_APP=kitty
distrobox-export --bin "$(which $TARGET_APP)" --export-path $DISTROBOX_HOST_HOME/.local/bin
```

## Install Dotfiles Without Distrobox
__WARNING:__ this will not just clone but also apply these dotfiles to your home directory!
```shell
cd ~
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
