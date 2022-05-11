local g = require 'globals'
local add = require 'utils'.addTable

add(g.lsp.fts, {
  'tex',
  'latex',
  'bib',
  'markdown',
})

add(g.lsp.servers, {
  'texlab',
  'ltex',
})

add(g.ts.ensure_installed, {
  'latex',
  'bibtex',
})

return function(use) end
