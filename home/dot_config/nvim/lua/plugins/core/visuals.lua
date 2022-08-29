local plugins = require("globals").plugins

table.insert(plugins, {
	name = "nvim-web-devicons",
	setup = function() end,
	config = function()
		require("nvim-web-devicons").setup({
			override = {
				nim = {
					icon = "👑",
					name = "nim",
				},
			},
		})
	end,
})

table.insert(plugins, {
	name = "onedark.nvim",
	setup = function() end,
	config = function()
		require("onedark").load()
	end,
})

table.insert(plugins, {
	name = "nvim-gps",
	setup = function() end,
	config = function()
		require("nvim-gps").setup()
	end,
})

table.insert(plugins, {
	name = "lualine.nvim",
	setup = function() end,
	config = function()
		local gps = require("nvim-gps")

		local function ObsessionStatusMod()
			return vim.fn.ObsessionStatus("Session", "")
		end

		require("lualine").setup({
			options = {
				theme = "onedark",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "diff" },
				lualine_c = {
					{ gps.get_location, cond = gps.is_available },
				},
				lualine_x = {
					{
						"diagnostics",
						padding = 2,
						sources = { "nvim_diagnostic" },
						sections = { "error", "warn", "info", "hint" },
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = " ",
						},
						update_in_insert = false,
					},
				},
				lualine_y = {},
				lualine_z = {
					{
						"filetype",
						colored = false,
						icon_only = true,
					},
					{
						"filename",
						file_status = true,
						path = 0,
						shorting_target = 70,
					},
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {
					{
						"filetype",
						colored = false,
						icon_only = true,
					},
					{
						"filename",
						file_status = true,
						path = 1,
						shorting_target = 40,
					},
				},
			},
			tabline = {
				lualine_a = { "tabs" },
				lualine_b = { "branch" },
				lualine_c = {},
				lualine_x = { ObsessionStatusMod },
				lualine_y = { "encoding", "fileformat", "filetype" },
				lualine_z = {},
			},
			extensions = {
				"quickfix",
				"fugitive",
				"man",
				"nvim-dap-ui",
				"mundo",
			},
		})
	end,
})

local p = require("utils").p

local M = function(use)
	use({ p("https://github.com/kyazdani42/nvim-web-devicons") })

	use({
		p("https://github.com/nvim-lualine/lualine.nvim"),
		after = "nvim-treesitter",
		requires = {
			{ p("https://github.com/navarasu/onedark.nvim") },
			{
				p("https://github.com/SmiteshP/nvim-gps"),
				-- after = 'nvim-treesitter',
			},
		},
	})
end
return M
