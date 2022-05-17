" -------------------------------------------------------------------
" mappings
" inoremap jk <ESC>

" reload vimrc
nnoremap <leader>rc :source $MYVIMRC<CR>
" faster line movement
nnoremap L g$
nnoremap H g^

"jump to alternative last edited
nnoremap <leader><leader> :b#<CR>

" yank until end of line
" nnoremap Y y$

" . mapping in visual
vnoremap . :norm.<CR>

"very magic regex
" noremap / /\v

"ZZ to close all
noremap ZZ :qa<CR>

" insert left and right
inoremap <c-l> <right>
inoremap <c-h> <left>

" Navigation in command line
" cnoremap <C-j> <Home>
" cnoremap <C-k> <End>
" cnoremap <C-l> <Right>
" cnoremap <C-h> <Left>

" Focus the current fold by closing all others
" nnoremap zz zA
" nnoremap zl zMzvzt

" Re-select blocks after indenting in visual/select mode
xnoremap < <gv
xnoremap > >gv|

" Indent and jump to first non-blank character linewise
nnoremap >>  >>_
nnoremap <<  <<_

" Change current word in a repeatable manner
nnoremap <Leader>cn *``cgn
nnoremap <Leader>cN *``cgN

" Change selected word in a repeatable manner
vnoremap <expr> <Leader>cn "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgn"
vnoremap <expr> <Leader>cN "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgN"

" Use backspace key for matching parens
nmap <BS> %
xmap <BS> %

" Select last paste
" nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

" Quick substitute within selected area
xnoremap <leader>sg :s//g<Left><Left>

" Open file under the cursor in a vsplit
nnoremap gf :vertical wincmd f<CR>

" Fast saving from all modes
nnoremap <C-s> :<C-u>write<CR>
xnoremap <C-s> :<C-u>write<CR>
cnoremap <C-s> <C-u>write<CR>

" Yank buffer's relative/absolute path to clipboard
" nnoremap <Leader>y :let @+=expand("%:~:.")<CR>:echo 'Yanked relative path'<CR>
" nnoremap <Leader>Y :let @+=expand("%:p")<CR>:echo 'Yanked absolute path'<CR>

" make
nnoremap <leader>m :make<CR>

" close all temp windows
nnoremap <silent> <c-w>a :cclose<CR>:pclose<CR>:helpclose<CR>:lclose<CR>
nnoremap <silent> <c-w><c-a> :cclose<CR>:pclose<CR>:helpclose<CR>:lclose<CR>

"tab control
nnoremap <C-t>n :tabnew<cr>
nnoremap <C-t>o :tabonly<cr>
nnoremap <C-t>c :tabclose<cr>
nnoremap <C-t>l :tabnext<cr>
nnoremap <C-t>t :tabnext<cr>
nnoremap <C-t>h :tabprevious<cr>
nnoremap <C-t>L :tabmove +1<cr>
nnoremap <C-t>H :tabmove -1<cr>

nnoremap <C-t><c-n> :tabnew<cr>
nnoremap <C-t><c-o> :tabonly<cr>
nnoremap <C-t><c-c> :tabclose<cr>
nnoremap <C-t><c-l> :tabnext<cr>
nnoremap <C-t><c-t> :tabnext<cr>
nnoremap <C-t><c-h> :tabprevious<cr>

"buffer control
command! BufOnly execute '%bdelete|edit #|normal `"'

nnoremap <C-b>l :bnext<CR>
nnoremap <C-b>h :bprevious<CR>
nnoremap <C-b>c :bdelete<CR>
nnoremap <C-b>o :BufOnly<CR>

nnoremap <C-b><C-l> :bnext<CR>
nnoremap <C-b><C-h> :bprevious<CR>
nnoremap <C-b><C-c> :bdelete<CR>
nnoremap <C-b><C-o> :BufOnly<CR>

" stolen from vim-sensible,
" adds the insertmode c-u and c-w to the undo hist
if empty(mapcheck('<C-U>', 'i'))
  inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
  inoremap <C-W> <C-G>u<C-W>
endif
"clears highlighting
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
" delete whitespace, clear highlighting and keep position using marks
nnoremap <silent> <leader>ws mb:%s/\s*$//<cr>:nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>g'bzz

" -------------------------------------------------------------------
" wordobjects
" ie = inner entire buffer
" onoremap ie :exec "normal! ggVG"<cr>
" vnoremap ie :normal ggVG<cr>

" -------------------------------------------------------------------
" command and autocommands

" :command to compare current file to original before changes
" command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
"  \ | wincmd p | diffthis
" -------------------------------------------------------------------
"  test

" nnoremap y "+y
" nnoremap yy "+yy
" nnoremap Y "+y$
"
" nnoremap p "+p
" nnoremap P "+P
"
" vnoremap y "+y
"
" vnoremap p "+p
" vnoremap P "+P

nnoremap <C-e> :e ./
nnoremap <C-q> :b

nmap <leader>id O<esc>v:!date --date='TZ="Berlin" now'<cr>

tnoremap <F11> <C-\><C-n>

" let s:HEX_CHARS = [
"   \ '0', '1', '2', '3', '4', '5', '6', '7',
"   \ '8', '9', 'A', 'B', 'C', 'D', 'E', 'F']
"
" function! s:AddDecValue(hex_array, value, source_base, target_base)
"   let carryover = a:value
"   let tmp = 0
"   let i = len(a:hex_array) - 1
"   while (i >= 0)
"     let tmp = (index(s:HEX_CHARS, a:hex_array[i]) * a:source_base) + carryover
"     let a:hex_array[i] = s:HEX_CHARS[tmp % a:target_base]
"     let carryover = tmp / a:target_base
"     let i = i -1
"   endwhile
" endfunction
"
" function! s:Convert(string, source_base, target_base)
"   let input = split(toupper(a:string), '.\zs')
"   let output = repeat(['0'], len(input) * 4)
"   for digit in input
"     let idx = index(s:HEX_CHARS, digit)
"     if idx == -1
"       echo 'Error converting base - unknown digit: ' . digit
"       return ''
"     end
"     call s:AddDecValue(output, idx, a:source_base, a:target_base)
"   endfor
"   while len(output) > 1 && output[0] == '0'
"     let output = output[1:]
"   endwhile
"   return join(output, '')
" endfunction
"
" command! -nargs=? -range HD call s:Hex2Dec(<line1>, <line2>)
" function! s:Hex2Dec(line1, line2) range
"   let cmd = 's/0x\(\x\+\)/\=printf("%s",s:Convert(submatch(1), 16, 10))/g'
"   try
"     execute a:line1 . ',' . a:line2 . cmd
"   catch
"     " echo 'No hex number starting with "0x" found'
"   endtry
" endfunction

" custom abbreviation db mapping
" vsplit the file
nnoremap <leader>av :exec "vsplit " . resolve(expand('$XDG_CONFIG_HOME/nvim/abbreviations.txt'))<cr>
" grep the file for the visual selection
vnoremap <leader>af "zy:echo system(['grep', '-i', 'z', resolve(expand('$XDG_CONFIG_HOME/nvim/abbreviations.txt'))])<cr>
" append the visual selection to the file
vnoremap <leader>aa "zy:call g:AddAbbreviation('z')<cr>

func g:AddAbbreviation(selection)
  let meaning = input('Meaning of ' . a:selection . ': ')
  call writefile([a:selection . " : " . meaning], resolve(expand('$XDG_CONFIG_HOME/nvim/abbreviations.txt')), "a")
endfunc

autocmd CustomFileType BufEnter *dot_zshenv,*dot_zshrc,*dot_zshaliasrc,*dot_profile set ft=zsh
autocmd CustomFileType BufEnter *kitty*.conf set ft=kitty
autocmd MyAutoCmd FileType qf nnoremap <buffer> s :<c-u>cdo s/// \| update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" ChezmoiPost calls PackerCompile in plugins.lua
autocmd MyAutoCmd BufEnter $XDG_DATA_HOME/chezmoi/home/* nnoremap <silent>  :<c-u>write<cr>:!chezmoi apply --source-path "%"<cr>:doautocmd User ChezmoiPost<cr>


command! DiagnosticEnable lua vim.diagnostic.enable()
command! DiagnosticDisable lua vim.diagnostic.disable()
