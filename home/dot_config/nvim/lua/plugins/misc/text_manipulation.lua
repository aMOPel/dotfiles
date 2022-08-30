local plugins = require("globals").plugins

table.insert(plugins, {
	name = "vim-sandwich",
	setup = function()
		vim.cmd([[runtime vimscript/vim-sandwich/surround.vim]])

		local map = require("utils").map
		map("x", "is", "<Plug>(textobj-sandwich-query-i)")
		map("x", "as", "<Plug>(textobj-sandwich-query-a)")
		map("o", "is", "<Plug>(textobj-sandwich-query-i)")
		map("o", "as", "<Plug>(textobj-sandwich-query-a)")
		map("x", "iss", "<Plug>(textobj-sandwich-auto-i)")
		map("x", "ass", "<Plug>(textobj-sandwich-auto-a)")
		map("o", "iss", "<Plug>(textobj-sandwich-auto-i)")
		map("o", "ass", "<Plug>(textobj-sandwich-auto-a)")
		--   " example: dim( in 'outer(in|ner())' would delete 'inner', not 'inner()'
		-- 	" xmap im <Plug>(textobj-sandwich-literal-query-i)
		-- 	" xmap am <Plug>(textobj-sandwich-literal-query-a)
		-- 	" omap im <Plug>(textobj-sandwich-literal-query-i)
		-- 	" omap am <Plug>(textobj-sandwich-literal-query-a)
	end,
	config = function() end,
})

table.insert(plugins, {
	name = "Comment.nvim",
	setup = function() end,
	config = function()
		require("Comment").setup({
      padding = true,
      sticky = true,
			mappings = {
				basic = true,
				extra = true,
				extended = false,
			},
			toggler = {
				line = "gcc",
				block = '<nop>',
			},
			opleader = {
				line = "gc",
				block = '<nop>',
			},
			pre_hook = function(ctx)
				local u = require("Comment.utils")
				if
					ctx.ctype == u.ctype.line
					or ctx.cmotion == u.cmotion.line
				then
					return require("ts_context_commentstring.internal").calculate_commentstring()
				end
			end,
		})
	end,
})

table.insert(plugins, {
	name = "vim-surround-funk",
	setup = function()
		vim.g.surround_funk_create_mappings = 0
		local map = require("utils").map
		map("n", "dsf", "<Plug>(DeleteSurroundingFunction)")
		map("n", "dsF", "<Plug>(DeleteSurroundingFUNCTION)")
		map("n", "csf", "<Plug>(ChangeSurroundingFunction)")
		map("n", "csF", "<Plug>(ChangeSurroundingFUNCTION)")
		map("n", "ysf", "<Plug>(YankSurroundingFunction)")
		map("n", "ysF", "<Plug>(YankSurroundingFUNCTION)")
		map("x", "af", "<Plug>(SelectWholeFunction)")
		map("o", "af", "<Plug>(SelectWholeFunction)")
		map("x", "aF", "<Plug>(SelectWholeFUNCTION)")
		map("o", "aF", "<Plug>(SelectWholeFUNCTION)")
		map("x", "if", "<Plug>(SelectWholeFunction)")
		map("o", "if", "<Plug>(SelectWholeFunction)")
		map("x", "iF", "<Plug>(SelectWholeFUNCTION)")
		map("o", "iF", "<Plug>(SelectWholeFUNCTION)")
		map("x", "an", "<Plug>(SelectFunctionName)")
		map("o", "an", "<Plug>(SelectFunctionName)")
		map("x", "aN", "<Plug>(SelectFunctionNAME)")
		map("o", "aN", "<Plug>(SelectFunctionNAME)")
		map("x", "in", "<Plug>(SelectFunctionName)")
		map("o", "in", "<Plug>(SelectFunctionName)")
		map("x", "iN", "<Plug>(SelectFunctionNAME)")
		map("o", "iN", "<Plug>(SelectFunctionNAME)")
		-- map('n', 'gpf', '<Plug>(GripSurroundObject)')
		-- map('v', 'gpf', '<Plug>(GripSurroundObject)')
		-- nmap <silent> gS <Plug>(GripSurroundObjectNoPaste)
		-- vmap <silent> gS <Plug>(GripSurroundObjectNoPaste)
  end,
	config = function()
	end,
})

table.insert(plugins, {
	name = "CamelCaseMotion",
	setup = function()
		-- vim.g.camelcasemotion_key = ','
		local map = require("utils").map
		map("", "gw", "<Plug>CamelCaseMotion_w")
		map("", "gb", "<Plug>CamelCaseMotion_b")
		map("", "ge", "<Plug>CamelCaseMotion_e")
		-- map("", "ge", "<Plug>CamelCaseMotion_ge")
    -- vim.cmd[[
    -- sunmap w
    -- sunmap b
    -- sunmap e
    -- ]]
    -- sunmap ge
  end,
	config = function()
	end,
})

table.insert(plugins, {
	name = "vim-log-print",
	setup = function()
		vim.g["log_print#default_mappings"] = 0

		vim.g["log_print#languages"] = {
			gdscript = { pre = "print(", post = ")" },
			typescript = { pre = "console.log(", post = ")" },
			sh = { pre = "echo " },
			nim = { pre = "print " },
		}

		local map = require("utils").map
		map("n", "gl", "<Plug>LogPrintToggle")
		map("n", "[g", "<Plug>LogPrintAbove")
		map("n", "]g", "<Plug>LogPrintBelow")
	end,
	config = function() end,
})

table.insert(plugins, {
	name = "vim-argwrap",
	setup = function()
		local noremap = require("utils").noremap
		noremap("n", "gJ", ":ArgWrap<CR>")
		vim.g.argwrap_tail_comma_braces = "[{"
	end,
	config = function() end,
})

table.insert(plugins, {
	name = "textobj-word-column.vim",
	setup = function() end,
	config = function()
		vim.g.textobj_wordcolumn_no_default_key_mappings = 1

		vim.fn["textobj#user#map"]("wordcolumn", {
			word = {
				["select-i"] = "ic",
				["select-a"] = "ac",
			},
			WORD = {
				["select-i"] = "iC",
				["select-a"] = "aC",
			},
		})
	end,
})

-- table.insert(plugins, {
--   name = 'textobj-pastedtext.vim',
--   setup = function()
--     vim.g.pastedtext_select_key = 'gp'
--   end,
--   config = function()
--   end,
-- })

table.insert(plugins, {
	name = "targets.vim",
	setup = function() end,
	config = function()
		vim.g.targets_aiAI = { "a", "i", " ", " " }
		vim.g.targets_nl = { " ", " " }
		vim.g.targets_seekRanges =
			"cc cr cb cB lc ac Ac lr rr ll lb ar ab lB Ar aB Ab AB rb rB al Al"
		vim.cmd([[
autocmd MyPlugins User targets#mappings#user call targets#mappings#extend({
    \ 'a': {'argument': [{'o': '[{([]', 'c': '[])}]', 's': ','}]},
    \ })
]])

		-- vim.api.nvim_create_autocmd(
		--   { 'User' },
		--   {
		--   pattern = 'targets#mappings#user',
		--   group = 'MyAutoCmd',
		--   callback = function()
		--     vim.fn['targets#mappings#extend']({
		--       a = {},
		--     })
		--   end,
		--   once = true,
		-- })
	end,
})

table.insert(plugins, {
	name = "vim-ReplaceWithRegister",
	setup = function()
		local map = require("utils").map
		map("n", "<c-p>", "<Plug>ReplaceWithRegisterOperator")
		map("n", "<c-p><c-p>", "<Plug>ReplaceWithRegisterLine")
		map("x", "<c-p>", "<Plug>ReplaceWithRegisterVisual")
	end,
	config = function() end,
})

table.insert(plugins, {
	name = "text-case.nvim",
	setup = function()
		local noremap = require("utils").noremap
    noremap("n", "gaU", ':lua require("textcase").lsp_rename("to_upper_case")<cr>')
    noremap("n", "gaL", ':lua require("textcase").lsp_rename("to_lower_case")<cr>')
    noremap("n", "gaS", ':lua require("textcase").lsp_rename("to_snake_case")<cr>')
    noremap("n", "gaD", ':lua require("textcase").lsp_rename("to_dash_case")<cr>')
    noremap("n", "gaN", ':lua require("textcase").lsp_rename("to_constant_case")<cr>')
    noremap("n", "gaD", ':lua require("textcase").lsp_rename("to_dot_case")<cr>')
    noremap("n", "gaA", ':lua require("textcase").lsp_rename("to_phrase_case")<cr>')
    noremap("n", "gaC", ':lua require("textcase").lsp_rename("to_camel_case")<cr>')
    noremap("n", "gaP", ':lua require("textcase").lsp_rename("to_pascal_case")<cr>')
    noremap("n", "gaT", ':lua require("textcase").lsp_rename("to_title_case")<cr>')
    noremap("n", "gaF", ':lua require("textcase").lsp_rename("to_path_case")<cr>')

    noremap("n", "gau", ':lua require("textcase").current_word("to_upper_case")<cr>')
    noremap("n", "gal", ':lua require("textcase").current_word("to_lower_case")<cr>')
    noremap("n", "gas", ':lua require("textcase").current_word("to_snake_case")<cr>')
    noremap("n", "gad", ':lua require("textcase").current_word("to_dash_case")<cr>')
    noremap("n", "gan", ':lua require("textcase").current_word("to_constant_case")<cr>')
    noremap("n", "gad", ':lua require("textcase").current_word("to_dot_case")<cr>')
    noremap("n", "gaa", ':lua require("textcase").current_word("to_phrase_case")<cr>')
    noremap("n", "gac", ':lua require("textcase").current_word("to_camel_case")<cr>')
    noremap("n", "gap", ':lua require("textcase").current_word("to_pascal_case")<cr>')
    noremap("n", "gat", ':lua require("textcase").current_word("to_title_case")<cr>')
    noremap("n", "gaf", ':lua require("textcase").current_word("to_path_case")<cr>')
	end,
	config = function() end,
})

table.insert(plugins, {
  name = 'vim-columnmove',
  setup = function()
    vim.g.columnmove_no_default_key_mappings = 1
    vim.cmd[[
for s:x in split('ftFT;,wbeWBE', '\zs') + ['ge', 'gE']
  call columnmove#utility#map('nxo', s:x, ',' . s:x, 'block')
endfor
unlet s:x
]]
  end,
  config = function()
    vim.cmd[[highlight ColumnmoveCandidates cterm=bold ctermfg=9 gui=bold guifg=red]]
  end,
})

local p = require("utils").p

local M = function(use)
	use { p "https://github.com/machakann/vim-sandwich" }
	use { p "https://github.com/tommcdo/vim-exchange" }
	use { p "https://github.com/numToStr/Comment.nvim" }
	use { p "https://github.com/Matt-A-Bennett/vim-surround-funk" }
	use { p "https://github.com/bkad/CamelCaseMotion" }
	-- use { p 'https://github.com/AndrewRadev/deleft.vim', }
	use { p "https://github.com/FooSoft/vim-argwrap" }
	use { p "https://github.com/wellle/targets.vim" }
	use { p "https://github.com/inkarkat/vim-ReplaceWithRegister" }
	use {
		p "https://github.com/aMOPel/vim-log-print",
		requires = { p "https://github.com/Shougo/context_filetype.vim" },
	}
	use {
		p "https://github.com/kana/vim-textobj-user",
		requires = {
			{
				p "https://github.com/kana/vim-textobj-indent",
				after = "vim-textobj-user",
			},
			{
				p "https://github.com/kana/vim-textobj-entire",
				after = "vim-textobj-user",
			},
			-- { p 'https://github.com/Chun-Yang/vim-textobj-chunk', after = 'vim-textobj-user', },
			-- { p 'https://github.com/saaguero/vim-textobj-pastedtext', after = 'vim-textobj-user', },
			{
				p "https://github.com/idbrii/textobj-word-column.vim",
				after = "vim-textobj-user",
			},
		},
	}
	use { p "https://github.com/johmsalas/text-case.nvim" }
  use { p 'https://github.com/machakann/vim-columnmove' }
end
return M
