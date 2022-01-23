set runtimepath^=$XDG_CACHE_HOME/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('$XDG_CACHE_HOME/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('https://github.com/folke/which-key.nvim', { 'hook_post_source': 'lua require("which-key").setup{ marks = false, spelling = {enabled = true, suggestions = 20,}, }' })

call dein#end()

autocmd VimEnter * call dein#call_hook('post_source')

filetype plugin indent on
syntax enable

if dein#check_install()
	call dein#install()
endif

nnoremap <leader>pu <esc>:<c-u>call dein#update()<CR>:silent! helptags ALL<CR>
nnoremap <leader>pr <esc>:<c-u>call dein#recache_runtimepath()<CR>:silent! helptags ALL<CR>
nnoremap <leader>pi <esc>:<c-u>call dein#install()<CR>:silent! helptags ALL<CR>

set spell
set spelllang=de,en

