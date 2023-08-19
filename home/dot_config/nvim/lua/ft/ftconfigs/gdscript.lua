local g = require("globals")
local add = require("utils").addTable

local ft = "gdscript"

add(g.lsp.fts, {
	ft,
})

add(g.lsp.servers.other, {
	gdscript = "default",
})

add(g.treesitter.ensure_installed, {
	ft,
	"godot_resource",
})

add(g.treesitter.indent.disable, {
	ft,
})

add(g.formatter.ensure_installed, {
	"gdtoolkit",
})

add(g.formatter.filetype, {
	[ft] = {
		function()
			return {
				exe = "gdformat",
				args = {
					"--line-length=80",
				},
			}
		end,
	},
})

add(g.linter.filetype, {
	[ft] = { "gdlint" },
})

local pattern = [[(%S+):(%d+):%s(%a+):%s(.*)]]
local groups = {
	"file",
	"lnum",
	"severity",
	"message",
}
local severity_map = {
	["Error"] = vim.diagnostic.severity.WARN,
}

add(g.linter.custom_linter, {
	gdlint = {
		cmd = "gdlint",
		stdin = false, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
		append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
		args = {}, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
		stream = "stderr", -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
		ignore_exitcode = true, -- set this to true if the linter exits with a code != 0 and that's considered normal.
		env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
		parser = require("lint.parser").from_pattern(
			pattern,
			groups,
			severity_map,
			{ ["source"] = "gdlint" }
		),
	},
})

add(g.dap.filetype, {
  [ft] = function()
    local dap = require('dap')
    dap.adapters.godot = {
      type = "server",
      host = '127.0.0.1',
      port = 6006,
    }
    dap.configurations.gdscript = {
      {
        type = "godot",
        request = "launch",
        name = "Launch scene",
        project = "${workspaceFolder}",
        launch_scene = true,
      }
    }
  end
})

local configs = {}

configs[ft] = function()
	local optl = vim.opt_local
	local noremap = require("utils").noremap_buffer

  -- gdscript styleguide
	optl.fileformat = "unix"
	optl.fixendofline = true
	optl.fileencoding = "utf-8"
	optl.expandtab = false

	optl.tabstop = 2
	optl.shiftwidth = 2
	-- noremap('n', '<leader>lf', ':exec "!gdformat -l 80 "  .  resolve(expand("%:p"))<cr>')
end

vim.api.nvim_create_autocmd({ "Filetype" }, {
	group = "MyFt",
	pattern = { ft },
	callback = configs[ft],
})
