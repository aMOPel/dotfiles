local plugins = require("globals").plugins

-- table.insert(plugins, {
-- 	name = "delaytrain.nvim",
-- 	setup = function()
-- 	end,
-- 	config = function()
--     require('delaytrain').setup {
--         delay_ms = 1000,  -- How long repeated usage of a key should be prevented
--         grace_period = 2, -- How many repeated keypresses are allowed
--         keys = {          -- Which keys (in which modes) should be delayed
--             ['nv'] = {'w', 'W', 'b', 'B', 'e', 'E', 'h', 'j', 'k', 'l'},
--             ['i'] = {'<Left>', '<Down>', '<Up>', '<Right>'},
--             -- ['n'] = {'<c-d>', '<c-u>'},
--         },
--     }
--   end,
-- })

table.insert(plugins, {
	name = "neogen",
	setup = function() end,
	config = function()
		require("neogen").setup({ snippet_engine = "vsnip" })
	end,
})

table.insert(plugins, {
	name = "rest.nvim",
	setup = function()
		local map = require("utils").map
		vim.api.nvim_create_autocmd({ "FileType" }, {
			pattern = "http",
			group = "MyAutoCmd",
			callback = function()
				map("n", "<leader>rr", "<Plug>RestNvim", { buffer = true })
			end,
		})
		map("n", "<leader>rr", "<Plug>RestNvimLast")
		-- map('n', '<leader>rp', '<Plug>RestNvimPreview')
	end,
	config = function()
		require("rest-nvim").setup({
			-- -- Open request results in a horizontal split
			-- result_split_horizontal = false,
			-- -- Keep the http file buffer above|left when split horizontal|vertical
			-- result_split_in_place = false,
			-- -- Skip SSL verification, useful for unknown certificates
			-- skip_ssl_verification = false,
			-- -- Encode URL before making request
			-- encode_url = true,
			-- -- Highlight request on run
			-- highlight = {
			--   enabled = true,
			--   timeout = 150,
			-- },
			-- result = {
			--   -- toggle showing URL, HTTP info, headers at top the of result window
			--   show_url = true,
			--   show_http_info = true,
			--   show_headers = true,
			--   -- executables or functions for formatting response body [optional]
			--   -- set them to false if you want to disable them
			--   formatters = {
			--     json = "jq",
			--     html = function(body)
			--       return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
			--     end
			--   },
			-- },
			-- -- Jump to request line on run
			-- jump_to_request = false,
			-- env_file = '.env',
			-- custom_dynamic_variables = {},
			-- yank_dry_run = true,
		})
	end,
})

table.insert(plugins, {
	name = "numb.nvim",
	setup = function() end,
	config = function()
		require("numb").setup({
			show_numbers = true, -- Enable 'number' for the window while peeking
			show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
			number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
			centered_peeking = true, -- Peeked line will be centered relative to window
		})
	end,
})

table.insert(plugins, {
	name = "neotest",
	setup = function()
		local noremap = require("utils").noremap
		noremap(
			"n",
			"<leader>tt",
			"<cmd>lua require('neotest').run.run()<cr>",
			{}
		)
		noremap(
			"n",
			"<leader>tc",
			"<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
			{}
		)
		noremap(
			"n",
			"<leader>to",
			'<cmd>lua require("neotest").output_panel.toggle()<cr>',
			{}
		)
	end,
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-jest")({
					jestCommand = "npx jest",
					jestConfigFile = "package.json",
					-- env = { CI = true },
					cwd = function(path)
						return vim.fn.getcwd()
					end,
				}),
				-- require("neotest-vim-test")({ allow_file_types = { "javascript", "typescript" } }),
			},
		})
	end,
})

local p = require("utils").p

local M = function(use)
	-- use { p "https://github.com/ja-ford/delaytrain.nvim" }

	use({
		p("https://github.com/nvim-neotest/neotest"),
		requires = {
			p("https://github.com/nvim-lua/plenary.nvim"),
			p("https://github.com/antoinemadec/FixCursorHold.nvim"),
			{
				p("https://github.com/nvim-neotest/neotest-jest"),
				commit = "3853b842b5d4850a2d5495f75802dabb3cda246c",
			},
			-- p 'https://github.com/nvim-neotest/neotest-vim-test',
			-- p 'https://github.com/vim-test/vim-test',
		},
	})
	use({ p("https://github.com/nacro90/numb.nvim") })
	use({ p("https://github.com/tpope/vim-dadbod") })
	use({ p("https://github.com/kristijanhusak/vim-dadbod-ui") })
	use({
		p("https://github.com/rest-nvim/rest.nvim"),
		requires = { p("https://github.com/nvim-lua/plenary.nvim") },
	})

	use({ p("https://github.com/danymat/neogen") })

	use({
		p("https://github.com/mikesmithgh/kitty-scrollback.nvim"),
		disable = false,
		opt = true,
		cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
		event = { "User KittyScrollbackLaunch" },
		-- tag = '*', -- latest stable version, may have breaking changes if major version changed
		-- tag = 'v2.0.0', -- pin specific tag
		config = function()
			require("kitty-scrollback").setup()
		end,
	})

	-- TODO: look into gitsigns:
	-- https://github.com/lewis6991/gitsigns.nvim
	-- https://github.com/airblade/vim-gitgutter
	-- https://github.com/mhinz/vim-signify
	-- https://github.com/rhysd/git-messenger.vim
	-- https://github.com/f-person/git-blame.nvim
	-- https://github.com/APZelos/blamer.nvim
	-- https://github.com/tveskag/nvim-blame-line
	-- TODO: look into fugitive alternatives:
	-- https://github.com/jreybert/vimagit
	-- https://github.com/TimUntersberger/neogit
	-- https://github.com/tanvirtin/vgit.nvim
	-- https://github.com/akinsho/git-conflict.nvim
	-- https://github.com/sindrets/diffview.nvim
	-- TODO: look into gh plugins:
	-- https://github.com/tpope/vim-rhubarb
	-- https://github.com/pwntester/octo.nvim
	-- https://github.com/ldelossa/gh.nvim
	-- TODO: research: put dispatch results not always in qflist
	-- TODO: fix black git text
	-- TODO: incorporate PackerUpdate --preview
	-- TODO: test framework
	-- TODO: notes framework
	-- TODO: which-key
	-- TODO: hydra
	-- TODO: code runner framework
	-- TODO: buffer switcher?
	-- TODO: easy motion?
	-- TODO: work with marks?
	-- TODO: work with registers?
	-- TODO: work with folds?
	-- TODO: some regex plugin?
end
return M
-- # [[plugins]]
-- # repo = 'https://github.com/NTBBloodbath/rest.nvim'
-- # if = 'has("nvim")'
-- # depends = 'plenary'
-- # hook_add = '''
-- #   nmap <silent> <leader>cc <Plug>RestNvim
-- #   nmap <silent> <leader>cp <Plug>RestNvimPreview
-- #   nmap <silent> <leader>cr <Plug>RestNvimLast
-- # '''
-- # hook_post_source = '''
-- # lua <<EOF
-- # require("rest-nvim").setup({
-- #     -- Open request results in a horizontal split
-- #     result_split_horizontal = false,
-- #     -- Skip SSL verification, useful for unknown certificates
-- #     skip_ssl_verification = false,
-- #     -- Highlight request on run
-- #     highlight = {
-- #       enabled = true,
-- #       timeout = 150,
-- #     },
-- #     -- Jump to request line on run
-- #     jump_to_request = false,
-- #   })
-- # EOF
-- # '''
--
-- # [[plugins]]
-- # repo = 'https://github.com/nvim-neorg/neorg'
-- # depends = 'plenary'
-- # hook_post_source = '''
-- # lua << EOF
-- #   require('neorg').setup {
-- #       -- Tell Neorg what modules to load
-- #       load = {
-- #           ["core.defaults"] = {}, -- Load all the default modules
-- #           ["core.norg.concealer"] = {}, -- Allows for use of icons
-- #           ["core.norg.dirman"] = { -- Manage your directories with Neorg
-- #               config = {
-- #                   workspaces = {
-- #                       my_workspace = "~/neorg"
-- #                   }
-- #               }
-- #           },
-- #           ["core.keybinds"] = { -- Configure core.keybinds
-- #               config = {
-- #                   default_keybinds = true, -- Generate the default keybinds
-- #                   neorg_leader = "<Leader>o" -- This is the default if unspecified
-- #               }
-- #           },
-- #           ["core.norg.completion"] = {
-- #             config = {
-- #               engine = "nvim-cmp",
-- #             },
-- #           },
-- #       },
-- #   }
-- # EOF
-- # '''
--
--
-- # for harpoon
-- # [[plugins]]
-- # repo = 'nvim-lua/popup.nvim'
-- # if = 'has("nvim")'
-- # name = 'popup'
--
-- # [[plugins]]
-- # repo = 'ThePrimeagen/harpoon'
-- # if = 'has("nvim")'
-- # on_lua = 'harpoon'
-- # depends = ['popup', 'plenary']
-- # hook_add = '''
-- #   nnoremap <leader>hh :lua require("harpoon.ui").toggle_quick_menu()<cr>
-- #   nnoremap <leader>ha :lua require("harpoon.mark").add_file()<CR>
-- #   nnoremap <C-m> :lua require("harpoon.ui").nav_file(1)<CR>
-- #   nnoremap <C-n> :lua require("harpoon.ui").nav_file(2)<CR>
-- #   nnoremap <C-h> :lua require("harpoon.ui").nav_file(3)<CR>
-- #   nnoremap <C-y> :lua require("harpoon.ui").nav_file(4)<CR>
-- #   autocmd MyAutoCmd FileType harpoon nnoremap <buffer> <esc> :wq<cr>
-- # '''
-- # hook_post_source = '''
-- # lua <<EOF
-- # require("harpoon").setup({
-- #   global_settings = {
-- #       save_on_toggle = false,
-- #       save_on_change = true,
-- #   },
-- # })
-- # EOF
-- # '''
--
-- # -------------------------------------------------------------------
-- # test
--
-- [[plugins]]
-- repo = 'https://github.com/folke/which-key.nvim'
-- hook_post_source = '''
-- lua <<EOF
-- require("which-key").setup{
--   plugins = {
--     marks = false,
--     spelling = {
--       enabled = true,
--       suggestions = 20,
--     },
--   },
-- }
-- EOF
-- '''
--
-- # -------------------------------------------------------------------
-- # bigger frameworks or functions
--
-- [[plugins]]
-- repo = 'https://github.com/tpope/vim-speeddating'
-- on_cmd = 'SpeedDatingFormat'
-- on_map = { n = ['<c-a>', '<c-x>'] }
-- hook_post_source = '''
-- 1SpeedDatingFormat %-d-%-m-%y
-- '''
--
-- [[plugins]]
-- repo = 'https://github.com/MattesGroeger/vim-bookmarks'
-- on_map = '<Plug>Bookmark'
-- hook_add = '''
--   let g:bookmark_sign = '📘'
--   let g:bookmark_annotation_sign = '📗'
--   let g:bookmark_no_default_key_mappings = 1
--   let g:bookmark_auto_save_file = stdpath('data') . '/bookmarks'
--
--   nmap <Leader>bb <Plug>BookmarkToggle
--   nmap <Leader>bi <Plug>BookmarkAnnotate
--   nmap <Leader>ba <Plug>BookmarkShowAll
--   nmap <Leader>bn <Plug>BookmarkNext
--   nmap <Leader>bp <Plug>BookmarkPrev
--   nmap <Leader>bc <Plug>BookmarkClear
--   nmap <Leader>bx <Plug>BookmarkClearAll
--   nmap <Leader>bk <Plug>BookmarkMoveUp
--   nmap <Leader>bj <Plug>BookmarkMoveDown
--   nmap <Leader>bg <Plug>BookmarkMoveToLine
-- '''
--
-- # [[pluglns]]
-- # repo = 'https://github.com/AndrewRadev/splitjoin.vim'
-- # on_map = { n = [' J', ' j'] }
-- # hook_source = '''
-- #   let g:splitjoin_split_mapping = ''
-- #   let g:splitjoin_join_mapping = ''
-- #
-- #   nmap <Leader>J :SplitjoinJoin<cr>
-- #   nmap <Leader>j :SplitjoinSplit<cr>
-- # '''
-- # # only has clever definitions for these fts
-- # on_ft = [
-- #   'c',
-- #   'coffee',
-- #   'css',
-- #   'elixir',
-- #   'elm',
-- #   'eruby',
-- #   'go',
-- #   'haml',
-- #   'handlebars',
-- #   'html',
-- #   'java',
-- #   'javascript',
-- #   'json',
-- #   'jsx',
-- #   'tsx',
-- #   'lua',
-- #   'perl',
-- #   'php',
-- #   'python',
-- #   'r',
-- #   'ruby',
-- #   'rust',
-- #   'scss',
-- #   'less',
-- #   'shell',
-- #   'tex',
-- #   'vimscript',
-- #   'yaml',
-- # ]
--
-- # [[plugins]]
-- # repo = 'tversteeg/registers.nvim'
-- # if = 'has("nvim")'
-- # on_cmd = 'Registers'
-- # on_map = {
-- #   i = '<c-r>',
-- #   n = '"',
-- #   v = '"',
-- # }
--

-- https://github.com/tpope/vim-projectionist
-- use projectionist instead of altr
--
-- # [[plugins]]
-- # repo = 'kana/vim-altr'
-- # on_map = '<Plug>'
-- # hook_add = '''
-- #   nmap <leader>a <Plug>(altr-back)
-- #   nmap <leader>A <Plug>(altr-forward)
-- # '''
-- # hook_source = '''
-- #   " call altr#remove_all()
-- #   call altr#define('%/src/%.cpp', '%/src/%.h*', '%/include/%.h*')
-- #   call altr#define('%.gd', 'test/unit/test_%.gd')
-- #   call altr#define('addons/*/%.gd', 'test/unit/test_%.gd')
-- # '''
--
