
" -------------------------------------------------------------------
"  vimrc
if &compatible
  set nocompatible
endif

function! s:source_rc(path) abort
  let abspath = resolve(expand('$XDG_CONFIG_HOME/nvim/rc/' . a:path))
  execute 'source' fnameescape(abspath)
endfunction

function! ArgAdd(...) abort
  for i in a:000
    let files = split(expand(i))
    for f in files
      if filereadable(f)
        execute('argadd ' . f)
      endif
    endfor
  endfor
endfunction
" -------------------------------------------------------------------
" function! s:on_filetype() abort
"   if execute('filetype') =~# 'OFF'
"     " Lazy loading
"     silent! filetype plugin indent on
"     syntax enable
"     filetype detect
"   endif
" endfunction

" make sure for every buffer filetype is on
augroup MyAutoCmd
  autocmd!
  " autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *?
  "      \ call s:on_filetype()
  " autocmd CursorHold *.toml syntax sync minlines=0
augroup END

augroup MyColors
  autocmd!
augroup END

augroup MyAddArgs
  autocmd!
  autocmd VimEnter *.vim,*.toml call ArgAdd('init.vim', 'rc/*')
  autocmd VimEnter *.cpp,*.hpp,*.h,*.c call ArgAdd('src/*', 'include/*')
  autocmd ExitPre * argdelete *
augroup END

augroup CustomFileType
  " godot filetypes
  au BufRead,BufNewFile *.tscn,*.tres,*.import,*.godot set filetype=dosini
augroup END

" -------------------------------------------------------------------
" set once before plugins
if has('vim_starting')

  " Use <Leader> in global plugin.
  let g:mapleader = ' '
  " Use <LocalLeader> in filetype plugin.
  let g:maplocalleader = '\'

  " Release keymappings for plug-in.
  nnoremap <space> <Nop>
  nnoremap \  <Nop>

  if &runtimepath !~# '/dein.vim'
    set runtimepath^=$XDG_CACHE_HOME/dein/repos/github.com/Shougo/dein.vim
  endif

  " Disable menu.vim
  if has('gui_running')
    set guioptions=Mc
  endif

  set packpath=
  let g:loaded_2html_plugin      = 1
  let g:loaded_logiPat           = 1
  let g:loaded_getscriptPlugin   = 1
  let g:loaded_gzip              = 1
  " let g:loaded_man               = 1
  let g:loaded_matchit           = 1
  let g:loaded_matchparen        = 1
  let g:loaded_netrwFileHandlers = 1
  let g:loaded_netrwPlugin       = 1
  let g:loaded_netrwSettings     = 1
  let g:loaded_rrhelper          = 1
  let g:loaded_shada_plugin      = 1
  let g:loaded_spellfile_plugin  = 1
  let g:loaded_tarPlugin         = 1
  let g:loaded_tutor_mode_plugin = 1
  let g:loaded_vimballPlugin     = 1
  let g:loaded_zipPlugin         = 1
endif

" -------------------------------------------------------------------
" source plugins
call s:source_rc('dein.rc.vim')

" turn on and detect filetype syntax etc
if has('vim_starting') 
  silent! filetype plugin indent on
  syntax enable
endif

autocmd MyAutoCmd VimEnter * call dein#call_hook('post_source')
" call dein hooks if vim isnt starting, ie vimrc is sourced
if !has('vim_starting')
  call dein#call_hook('source')
  call dein#call_hook('post_source')
  " silent! helptags ALL
endif
" -------------------------------------------------------------------
