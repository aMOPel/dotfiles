local g = require 'globals'
local add = require 'utils'.addTable

add(g.lsp.fts, {
  'markdown',
})

add(g.lsp.servers, {
  'prosemd-lsp',
})

-- add(g.ts.ensure_installed, {
--   'markdown',
-- })

local configs = {}

configs['markdown'] = function()
  local optl = vim.opt_local
  -- " setl spelllang=en,de
  -- " setl spell
  -- " setl textwidth=80
  --
  -- " setl linebreak
  -- " setl showbreak="> "
  -- " setl breakindent
  -- " setl formatoptions+=wa

  optl.foldenable = false
  optl.foldcolumn = '0'

  local noremap = require 'utils'.noremap_buffer
  -- noremap('n', '<leader>n', ':exec "FloatermNew --autoclose=2 --disposable --width=0.95 --height=0.95 glow -w 200 "<CR>')
end

local p = require 'utils'.p
-- TODO: this doesn't work
local M = function(use)
  use {
    vim.fn.stdpath('config') .. '/dummy_plugin/',
    config = configs['markdown'],
    ft = { 'markdown' },
  }
end
return M

