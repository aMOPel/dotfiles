local configs = {}

configs['vim-markdown'] = function()
  vim.g.vim_markdown_folding_disabled = 1
end

configs['vim-typescript'] = function()
  vim.g.typescript_compiler_options = '--outDir out'
end

configs['vim-godot'] = function()
--   nnoremap <F4> :GodotRunLast<CR>
--   nnoremap <leader>n :GodotRun<CR>
--   nnoremap <F6> :GodotRunCurrent<CR>
--   nnoremap <F7> :GodotRunFZF<CR>
end

local p = require 'utils'.p

local M = function(use)
  use { p 'https://github.com/zah/nim.vim', }
  use { p 'https://github.com/fladson/vim-kitty', }
  use { p 'https://github.com/posva/vim-vue', }
  use {
    p 'https://github.com/preservim/vim-markdown',
    config = configs['vim-markdown'] ,
  }
  use {
    p 'https://github.com/leafgarland/typescript-vim',
    config = configs['vim-typescript'] ,
  }
  use {
    p 'https://github.com/habamax/vim-godot',
    config = configs['vim-godot'] ,
  }
end
return M

-- [[plugins]]
-- repo = 'https://github.com/jbyuki/nabla.nvim'
-- on_ft = ['markdown', 'txt']
-- hook_post_source = '''
--   nnoremap <F5> :lua require("nabla").action()<CR>
-- '''
--
-- # [[plugins]]
-- # repo = 'https://github.com/brymer-meneses/grammar-guard.nvim'
-- # on_ft = ['markdown', 'tex', 'latex', 'bib']
-- # depends = 'lspconfig'
-- # hook_post_source = '''
-- # lua <<EOF
-- # require("grammar-guard").init()
-- #
-- # local on_attach = function(client, bufnr)
-- #   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
-- #
-- #   local opts = { noremap=true, silent=true }
-- #   if client.resolved_capabilities.code_action then
-- #     buf_set_keymap("n", "<space>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
-- #   end
-- # end
-- #
-- # local Dictionary_file = {
-- #     ["en"] = {vim.fn.resolve(vim.fn.expand("$XDG_CONFIG_HOME/nvim/spell/dictionary.txt"))}
-- # }
-- # local DisabledRules_file = {
-- #     ["en"] = {vim.fn.resolve(vim.fn.expand("$XDG_CONFIG_HOME/nvim/spell/disable.txt"))}
-- # }
-- # local FalsePositives_file = {
-- #     ["en"] = {vim.fn.resolve(vim.fn.expand("$XDG_CONFIG_HOME/nvim/spell/false.txt"))}
-- # }
-- #
-- # require("lspconfig").grammar_guard.setup({
-- #   on_attach = on_attach,
-- #   flags = {
-- #     debounce_text_changes = 150,
-- #   },
-- #   settings = {
-- #     ltex = {
-- #       enabled = { "latex", "tex", "bib", "markdown" },
-- #       language = "en",
-- #       diagnosticSeverity = "information",
-- #       setenceCacheSize = 2000,
-- #       additionalRules = {
-- #         enablePickyRules = true,
-- #         motherTongue = "en",
-- #       },
-- #       trace = { server = "verbose" },
-- #       dictionary = {
-- #           ["en"] = {":" .. vim.fn.resolve(vim.fn.expand("$XDG_CONFIG_HOME/nvim/spell/dictionary.txt"))}
-- #       };
-- #       disabledRules = {
-- #           ["en"] = {":" .. vim.fn.resolve(vim.fn.expand("$XDG_CONFIG_HOME/nvim/spell/disable.txt"))}
-- #       };
-- #       hiddenFalsePositives = {
-- #           ["en"] = {":" .. vim.fn.resolve(vim.fn.expand("$XDG_CONFIG_HOME/nvim/spell/false.txt"))}
-- #       };
-- #     },
-- #   },
-- # })
-- # EOF
-- # '''
--
--
-- [[plugins]]
-- repo = 'https://github.com/mattn/emmet-vim'
-- on_ft = [ 'html', 'css' , 'vue']
-- hook_add = '''
--     let g:user_emmet_leader_key='<C-t>'
--     let g:user_emmet_mode='in'
-- '''
--
-- [[plugins]]
-- repo = 'https://github.com/norcalli/nvim-colorizer.lua'
-- if = 'has("nvim")'
-- on_ft = [ 'kitty', 'yaml', 'html', 'css', 'javascript' ]
-- hook_post_source = '''
-- lua <<EOF
-- require 'colorizer'.setup {
--   'css';
--   'javascript';
--   'yaml';
--   'kitty';
--   html = {
--     mode = 'foreground';
--   }
-- }
-- EOF
-- '''
--
--
-- # for xmlattr
-- [[plugins]]
-- repo = 'https://github.com/kana/vim-textobj-user'
-- name = 'vim-textobj-user'
--
-- [[plugins]]
-- repo = 'https://github.com/whatyouhide/vim-textobj-xmlattr'
-- depends = 'vim-textobj-user'
-- on_ft = [ 'html', 'vue' ]
--
--
-- # for package-info
-- [[plugins]]
-- repo = 'https://github.com/MunifTanjim/nui.nvim'
-- name = 'nui'
--
-- [[plugins]]
-- repo = 'https://github.com/vuki656/package-info.nvim'
-- depends = 'nui'
-- on_path = 'package.json'
-- hook_post_source = '''
-- lua <<EOF
-- require('package-info').setup()
--
-- vim.api.nvim_set_keymap("n", "<leader>js", ":lua require('package-info').show()<CR>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>jh", ":lua require('package-info').hide()<CR>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>ju", ":lua require('package-info').update()<CR>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>jd", ":lua require('package-info').delete()<CR>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>ji", ":lua require('package-info').install()<CR>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>jr", ":lua require('package-info').reinstall()<CR>", { silent = true, noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>jp", ":lua require('package-info').change_version()<CR>", { silent = true, noremap = true })
--
-- EOF
-- '''
