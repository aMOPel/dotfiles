local g = require 'globals'
local add = require 'utils'.addTable

add(g.lsp.fts, {
  'vue',
})

add(g.lsp.servers, {
  'volar',
})

add(g.ts.ensure_installed, {
  'vue',
})

return function(use) end
