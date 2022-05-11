local g = require 'globals'
local add = require 'utils'.addTable

add(g.lsp.fts, {
  'html',
})

-- add(g.lsp.servers, {
-- })

add(g.ts.ensure_installed, {
  'html',
})
