local configs = {}


configs['vim-vsnip'] = function()
  local map = require 'utils'.map
  vim.g.vsnip_snippet_dir = vim.fn.expand("$XDG_CONFIG_HOME/nvim/snippets")

  map('i', '<Tab>', 'vsnip#available(1)  ? "<Plug>(vsnip-expand-or-jump)" : "<Tab>"', { silent = true, expr = true })
  map('s', '<Tab>', 'vsnip#available(1)  ? "<Plug>(vsnip-expand-or-jump)" : "<Tab>"', { silent = true, expr = true })
  map('i', '<S-Tab>', 'vsnip#jumpable(-1)  ? "<Plug>(vsnip-jump-prev)"      : "<S-Tab>"', { silent = true, expr = true })
  map('s', '<S-Tab>', 'vsnip#jumpable(-1)  ? "<Plug>(vsnip-jump-prev)"      : "<S-Tab>"', { silent = true, expr = true })
end

configs['cmp-zsh'] = function()
  require 'cmp_zsh'.setup {
    filetypes = { 'sh', 'zsh' }
  }
end

configs['cmp-git'] = function()
  require 'cmp_git'.setup {
    filetypes = { 'gitcommit' },
    trigger_actions = {
      {
        debug_name = "git_commits",
        trigger_character = "&",
        action = function(sources, trigger_char, callback, params, git_info)
          return sources.git:get_commits(callback, params, trigger_char)
        end,
      },
    }
  }
end

configs['cmp-tabnine'] = function()
  local tabnine = require('cmp_tabnine.config')
  tabnine:setup({
    max_lines = 1000;
    max_num_results = 20;
    sort = true;
    run_on_every_keystroke = true;
    snippet_placeholder = '..';
  })
end

configs['cmp-cmdline'] = function()
  local map = require 'utils'.map
  map('c', '<tab>', '')
  map('c', '<s-tab>', '')
  vim.opt.wildmenu = false
end

configs['nvim-cmp'] = function()
  vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
  vim.opt.complete = {}

  local cmp = require 'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-g>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-q>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm(),
      ['<C-n>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { 'i', 's', 'c' }),
      ['<C-p>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s", "c" })
    },
    sources = {
      { name = 'cmp_tabnine', priority = 1000, max_item_count = 20 },
      { name = 'vsnip', priority = 900, max_item_count = 10 },
      -- { name = 'fuzzy_path', priority=900, max_item_count=10  },
      { name = 'nvim_lsp', priority = 500, max_item_count = 20 },
      { name = 'nvim_lsp_signature_help' },
      { name = 'nvim_lua', priority = 500, max_item_count = 20 },
      -- { name = 'buffer', priority=100, keyword_length=3, max_item_count=5  },
      { name = 'emoji' },
      { name = 'zsh' },
      { name = 'git' },
      { name = 'rg', priority = 500, keyword_length = 3, max_item_count = 10 },
      { name = 'calc', priority = 100 },
      -- { name = 'spell', priority=100 },
      -- { name = 'neorg' },
    },
    formatting = {
      format = require('lspkind').cmp_format({
        with_text = true,
        maxwidth = 50,
        menu = {
          cmp_tabnine = '[T9]',
          vsnip = '[VSNIP]',
          fuzzy_path = '[PATH]',
          nvim_lsp = '[LSP]',
          nvim_lua = '[LUA]',
          buffer = '[BUF]',
          rg = '[RG]',
          cmdline = '[CMD]',
          calc = '[CLC]',
          zsh = '[ZSH]',
          git = '[GIT]',
        },
      })
    },
    experimental = {
      native_menu = false,
      ghost_text = true,
    }
  })
  cmp.setup.cmdline('?', {
    sources = {
      { name = 'buffer', max_item_count = 30, }
    }
  })
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer', max_item_count = 30, }
    }
  })
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'fuzzy_path', max_item_count = 20 }
    }, {
      { name = 'cmdline', max_item_count = 30, }
    }),
  })
end

local p = require 'utils'.p

local M = function(use)
  use {
    p 'https://github.com/hrsh7th/nvim-cmp',
    config = configs['nvim-cmp'],
    event = { 'InsertEnter', 'CmdlineEnter' },
    requires = {
      {
        p 'https://github.com/hrsh7th/vim-vsnip',
        config = configs['vim-vsnip'],
        requires = {
          { p 'https://github.com/hrsh7th/vim-vsnip-integ', },
          { p 'https://github.com/rafamadriz/friendly-snippets', },
        },
      },
      { p 'https://github.com/hrsh7th/cmp-calc', after = 'nvim-cmp', },
      { p 'https://github.com/hrsh7th/cmp-vsnip', after = 'nvim-cmp', },
      { p 'https://github.com/hrsh7th/cmp-emoji', after = 'nvim-cmp', },
      { p 'https://github.com/hrsh7th/cmp-buffer', after = 'nvim-cmp', },
      { p 'https://github.com/hrsh7th/cmp-nvim-lua', after = 'nvim-cmp', },
      { p 'https://github.com/hrsh7th/cmp-path', after = 'nvim-cmp', },
      { p 'https://github.com/lukas-reineke/cmp-rg', after = 'nvim-cmp', },
      { p 'https://github.com/f3fora/cmp-spell', after = 'nvim-cmp', },
      { p 'https://github.com/hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp', },
      {
        p 'https://github.com/petertriho/cmp-git',
        config = configs['cmp-git'],
        after = 'nvim-cmp',
        requires = 'nvim-lua/plenary.nvim',
      },
      {
        p 'https://github.com/tamago324/cmp-zsh',
        config = configs['cmp-zsh'],
        after = 'nvim-cmp',
      },
      { p 'https://github.com/onsails/lspkind-nvim', },
      {
        p 'https://github.com/tzachar/cmp-fuzzy-path',
        requires = { 'fuzzy.nvim', 'telescope-fzf-native.nvim', },
        after = 'nvim-cmp',
      },
      {
        p 'https://github.com/tzachar/cmp-tabnine',
        config = configs['cmp-tabnine'],
        run = function()
          vim.pretty_print(
            vim.fn.system(
              vim.fn.stdpath('data') .. '/site/pack/packer/opt/cmp-tabnine/install.sh'
            )
          )
        end,
        after = 'nvim-cmp',
      },
      {
        p 'https://github.com/hrsh7th/cmp-cmdline',
        config = configs['cmp-cmdline'],
        after = 'nvim-cmp',
      },
    },
  }

  use { p 'https://github.com/hrsh7th/cmp-nvim-lsp', }
end
return M