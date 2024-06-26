local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd([[qa]])
end

local utils = require("utils")
local p = utils.p

-- vim.cmd [[packadd packer.nvim]]
require("packer").startup({
	function(use)
		local core_prefix = "plugins/core/"
		local misc_prefix = "plugins/misc/"

		local function useCore(script_name)
			require(core_prefix .. script_name)(use)
		end

		local function useDir(prefix)
			for _, s in pairs(utils.getPluginScripts(prefix)) do
				require(prefix .. s)(use)
			end
		end

		vim.cmd([[
augroup MyPlugins
  autocmd!
augroup END
]])

		use({ p("https://github.com/wbthomason/packer.nvim") })

		-- importing in order
		useCore("filetypes")
		useCore("lsp")
		useCore("treesitter")
		useCore("visuals")
		useCore("cmp")
		useCore("basics")

		-- importing all misc scripts
		useDir(misc_prefix)
	end,
	-- loading maintained snapshot named 'base'
	config = {
		snapshot = "base1",
		snapshot_path = vim.fn.expand(
			"$XDG_DATA_HOME/chezmoi/home/dot_config/nvim/packer-snapshots"
		),
	},
})

local noremap = utils.noremap
noremap("n", "<leader>pu", ":PackerSync<cr>")
noremap("n", "<leader>pi", ":PackerInstall<cr>")
noremap("n", "<leader>pc", ":PackerClean<cr>")
noremap("n", "<leader>pr", ":PackerCompile<cr>")
noremap("n", "<leader>ps", ":PackerStatus<cr>")
