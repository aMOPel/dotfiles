# Setup fzf
# ---------
# if [[ ! "$PATH" == *$HOME/.local/fzf/bin* ]]; then
#   export PATH="${PATH:+${PATH}:}$HOME/.local/fzf/bin"
# fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.local/ghq/github.com/junegunn/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.local/ghq/github.com/junegunn/fzf/shell/key-bindings.zsh"

# %%base16_template: fzf##default %%
# Base16 OneDark
# Author: Lalit Magant (http://github.com/tilal6991)

_gen_fzf_default_opts() {

local color00='#282c34'
local color01='#353b45'
local color02='#3e4451'
local color03='#545862'
local color04='#565c64'
local color05='#abb2bf'
local color06='#b6bdca'
local color07='#c8ccd4'
local color08='#e06c75'
local color09='#d19a66'
local color0A='#e5c07b'
local color0B='#98c379'
local color0C='#56b6c2'
local color0D='#61afef'
local color0E='#c678dd'
local color0F='#be5046'

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D"\
" --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C"\
" --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

}

_gen_fzf_default_opts

# %%base16_template_end%%
