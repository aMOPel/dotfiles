local g = require 'globals'
local add = require 'utils'.addTable

local ft = 'filetype_name'

add(g.lsp.fts, {
  ft,
})

add(g.lsp.servers.lsp_installer, {
  server_name = function(on_attach, capabilities)
  end,
})

add(g.treesitter.ensure_installed, {
  ft,
})

local configs = {}

configs[ft] = function()
  local optl = vim.opt_local
  local noremap = require 'utils'.noremap_buffer
end

vim.api.nvim_create_autocmd(
  {'Filetype'},
  {
    group = 'MyFt',
    pattern = { ft, },
    callback = configs[ft],
  }
)
