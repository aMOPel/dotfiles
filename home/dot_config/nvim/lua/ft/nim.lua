local g = require 'globals'
local add = require 'utils'.addTable

add(g.lsp.fts, {
  'nim',
  -- 'nims',
})

add(g.lsp.servers, {
  'nimls',
})

-- add(g.ts.ensure_installed, {
-- })

return function(use) end
