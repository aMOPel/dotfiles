local configs = {}

configs['editorconfig.vim'] = function()
  vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*' }
  vim.g.EditorConfig_max_line_indicator = "line"
  vim.g.EditorConfig_preserve_formatoptions = 1

  vim.cmd[[au MyPlugins FileType qf,gitcommit let b:EditorConfig_disable = 1]]
  -- vim.api.nvim_create_autocmd(
  --   { 'FileType' },
  --   {
  --   pattern = {
  --     'gitcommit',
  --     'qf',
  --   },
  --   group = 'MyAutoCmd',
  --   callback = function() vim.b.EditorConfig_disable = 1 end,
  -- })
end

local p = require 'utils'.p

local M = function(use)
  use {
    p 'https://github.com/editorconfig/editorconfig-vim',
    config = configs['editorconfig.vim']
  }
end
return M
-- https://github.com/tpope/vim-dotenv
