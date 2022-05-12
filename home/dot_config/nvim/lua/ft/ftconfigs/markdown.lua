local g = require 'globals'
local add = require 'utils'.addTable

local ft = 'markdown'

add(g.lsp.fts, {
  ft,
})

add(g.lsp.servers.lsp_installer, {
  prosemd_lsp = 'default',
})

-- add(g.treesitter.ensure_installed, {
--   ft,
-- })

local configs = {}

configs[ft] = function()
  local optl = vim.opt_local
  -- " setl spelllang=en,de
  -- " setl spell
  -- " setl textwidth=80
  --
  -- " setl linebreak
  -- " setl showbreak="> "
  -- " setl breakindent
  -- " setl formatoptions+=wa

  optl.foldenable = false
  optl.foldcolumn = '0'

  local noremap = require 'utils'.noremap_buffer
  -- noremap('n', '<leader>n', ':exec "FloatermNew --autoclose=2 --disposable --width=0.95 --height=0.95 glow -w 200 "<CR>')
end

vim.api.nvim_create_autocmd(
  {'Filetype'},
  {
    group = 'MyFt',
    pattern = { ft, },
    callback = configs[ft],
  }
)
