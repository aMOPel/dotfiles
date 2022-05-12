local g = require 'globals'
local add = require 'utils'.addTable

local ft = 'nim'

add(g.lsp.fts, {
  ft,
  -- 'nims',
})

add(g.lsp.servers.lsp_installer, {
  nimls = 'default',
})

-- add(g.treesitter.ensure_installed, {
-- })

local configs = {}

configs[ft] = function()
  local optl = vim.opt_local
  local noremap = require 'utils'.noremap_buffer
  -- noremap('n', '<leader>m', ':exec "FloatermNew --autoclose=0 --disposable nim c " . resolve(expand("%:p")) <CR>')
  noremap('n', '<leader>n', ':exec "FloatermNew --autoclose=0 --disposable nim r " . resolve(expand("%:p")) <CR>')
  noremap('n', '<leader>lf',':exec "!nimpretty " . resolve(expand("%:p")) <CR>')
end

vim.api.nvim_create_autocmd(
  {'Filetype'},
  {
    group = 'MyFt',
    pattern = { ft, },
    callback = configs[ft],
  }
)
