
local g = require 'globals'
local add = require 'utils'.addTable

add(g.lsp.fts, {
  'javascript',
  'typescript',
})

add(g.lsp.servers, {
  'tsserver',
  'eslint',
})

add(g.ts.ensure_installed, {
  'javascript',
  'typescript',
})

return function(use) end
