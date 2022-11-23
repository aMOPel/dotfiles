local plugins = require 'globals'.plugins

table.insert(plugins, {
  name = 'vim-markdown',
  setup = function()
  end,
  config = function()
    vim.g.vim_markdown_folding_disabled = 1
  end,
})

table.insert(plugins, {
  name = 'vim-typescript',
  setup = function()
  end,
  config = function()
    vim.g.typescript_compiler_options = '--outDir out'
  end,
})

table.insert(plugins, {
  name = 'fzf-gitignore',
  setup = function()
    vim.g.fzf_gitignore_no_maps = 1
  end,
  config = function()
  end,
})

-- table.insert(plugins, {
--   name = 'vim-godot',
--   setup = function()
--   end,
--   config = function()
--       nnoremap <F4> :GodotRunLast<CR>
--       nnoremap <leader>n :GodotRun<CR>
--       nnoremap <F6> :GodotRunCurrent<CR>
--       nnoremap <F7> :GodotRunFZF<CR>
--   end,
-- })

local p = require 'utils'.p

local M = function(use)
  use { p 'https://github.com/alaviss/nim.nvim', }
  -- use { p 'https://github.com/zah/nim.vim', }
  use { p 'https://github.com/fladson/vim-kitty', }
  use { p 'https://github.com/posva/vim-vue', }
  use { p 'https://github.com/preservim/vim-markdown', }
  use { p 'https://github.com/leafgarland/typescript-vim', }
  use { p 'https://github.com/habamax/vim-godot', }
  use { p 'https://github.com/ekalinin/Dockerfile.vim', }
  use { p 'https://github.com/raimon49/requirements.txt.vim', }
  use { p 'https://github.com/SirJson/fzf-gitignore', }
  use { p 'https://github.com/aliev/vim-compiler-python', }
end
return M
