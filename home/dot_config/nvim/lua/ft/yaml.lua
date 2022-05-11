local g = require 'globals'
local add = require 'utils'.addTable

add(g.lsp.fts, {
  'yaml',
})

add(g.lsp.servers, {
  'yamlls',
})

add(g.ts.ensure_installed, {
  'yaml',
})

return function(use) end
