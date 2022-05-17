local configs = {}

configs['vim-markdown'] = function()
  vim.g.vim_markdown_folding_disabled = 1
end

configs['vim-typescript'] = function()
  vim.g.typescript_compiler_options = '--outDir out'
end

configs['fzf-gitignore'] = function()
  vim.g.fzf_gitignore_no_maps = 1
end

configs['vim-godot'] = function()
  --   nnoremap <F4> :GodotRunLast<CR>
  --   nnoremap <leader>n :GodotRun<CR>
  --   nnoremap <F6> :GodotRunCurrent<CR>
  --   nnoremap <F7> :GodotRunFZF<CR>
end

local p = require 'utils'.p

local M = function(use)
  use { p 'https://github.com/zah/nim.vim', }
  use { p 'https://github.com/fladson/vim-kitty', }
  use { p 'https://github.com/posva/vim-vue', }
  use {
    p 'https://github.com/preservim/vim-markdown',
    config = configs['vim-markdown'],
  }
  use {
    p 'https://github.com/leafgarland/typescript-vim',
    config = configs['vim-typescript'],
  }
  use {
    p 'https://github.com/habamax/vim-godot',
    config = configs['vim-godot'],
  }
  use { p 'https://github.com/ekalinin/Dockerfile.vim', }
  use { p 'https://github.com/raimon49/requirements.txt.vim', }
  use {
    p 'https://github.com/SirJson/fzf-gitignore',
    config = configs['fzf-gitignore'],
  }
end
return M
