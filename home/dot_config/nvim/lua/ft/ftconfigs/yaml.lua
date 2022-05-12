local g = require 'globals'
local add = require 'utils'.addTable

local ft = 'yaml'

add(g.lsp.fts, {
  ft,
})

add(g.lsp.servers.lsp_installer, {
  yamlls = 'default',
})

add(g.treesitter.ensure_installed, {
  ft,
})
