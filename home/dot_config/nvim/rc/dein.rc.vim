let g:dein#auto_recache = v:true
let g:dein#lazy_rplugins = v:true
let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = v:true
let g:dein#inline_vimrcs = ['options.vim', 'mappings.vim', 'unix.rc.vim']
if has('nvim')
 call add(g:dein#inline_vimrcs, 'neovim.rc.vim')
endif
call map(g:dein#inline_vimrcs, "resolve(expand('$XDG_CONFIG_HOME/nvim/rc/' . v:val))")

let s:dein_tomls = ['dein.toml', 'deinlazy.toml', 'deinft.toml']
call map(s:dein_tomls, "resolve(expand('$XDG_CONFIG_HOME/nvim/rc/' . v:val))")

let s:path = expand('$XDG_CACHE_HOME/dein')
if !dein#load_state(s:path)
  finish
endif

set rtp^=~/.local/fzf
call dein#begin(s:path, [
      \ expand('<sfile>'), s:dein_tomls[0], s:dein_tomls[1], s:dein_tomls[2],
      \ ])

call dein#load_toml(s:dein_tomls[0], {'lazy' : 0})
call dein#load_toml(s:dein_tomls[1], {'lazy' : 1})
call dein#load_toml(s:dein_tomls[2])

call dein#end()
call dein#save_state()

if !has('vim_starting') && dein#check_install()
  " Installation check.
  call dein#install()
endif

