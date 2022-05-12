local g = require 'globals'
local add = require 'utils'.addTable

local ft = 'gdscript'

add(g.lsp.fts, {
  ft,
})

add(g.lsp.servers.other, {
  gdscript = 'default',
})

add(g.treesitter.ensure_installed, {
  ft,
  'godot_resource',
})

add(g.treesitter.indent.disable, {
  ft,
})

local configs = {}

configs[ft] = function()
  local optl = vim.opt_local
  local noremap = require 'utils'.noremap_buffer
  optl.tabstop = 2
  optl.shiftwidth = 2
  optl.expandtab = false

  noremap('n', '<leader>lf', ':exec "!gdformat -l 80 "  .  resolve(expand("%:p"))<cr>')
end

vim.api.nvim_create_autocmd(
  {'Filetype'},
  {
    group = 'MyFt',
    pattern = { ft, },
    callback = configs[ft],
  }
)
