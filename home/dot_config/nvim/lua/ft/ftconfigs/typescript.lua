local g = require 'globals'
local add = require 'utils'.addTable

local ft = 'typescript'

add(g.lsp.fts, {
  ft,
  'javascript',
})

add(g.lsp.servers.lsp_installer, {
  tsserver = "default",
})

add(g.lsp.servers.special_setup, {
  tsserver = function(server_config)
    require("typescript").setup({
      disable_commands = false, -- prevent the plugin from creating Vim commands
      debug = false, -- enable debug logging for commands
      go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
      },
      server = server_config,
    })
  end,
})

add(g.treesitter.ensure_installed, {
  ft,
  'javascript',
})

add(g.linter.filetype, {
  [ft] = {"eslint"},
  javascript = {"eslint"},
})

add(g.formatter.ensure_installed, {
  "prettierd",
})

add(g.formatter.filetype, {
	[ft] = {
    -- function() pcall(
    --   function(arg) vim.cmd(arg) end,
    --   'TypescriptOrganizeImports'
    -- ) end,
    require("formatter.filetypes")[ft].prettierd,
	},
})


local configs = {}

configs[ft] = function()
	local optl = vim.opt_local
	local noremap = require("utils").noremap_buffer
  noremap("n", "gq", [[
:TypescriptAddMissingImports<cr>
:sleep 300m<cr>
:TypescriptOrganizeImports<cr>
:sleep 300m<cr>
:update<cr>
:FormatWrite<cr>]]
)
end

vim.api.nvim_create_autocmd({ "Filetype" }, {
	group = "MyFt",
	pattern = { ft },
	callback = configs[ft],
})

-- add(g.formatter.on_save, {
-- 	"*." .. ft,
-- })
