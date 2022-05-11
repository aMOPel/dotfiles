local M = {
  lsp = {
    fts = {
      -- 'tex', 'latex', 'bib', 'markdown',
      -- 'html', 'css', 'javascript', 'typescript', 'vue',
      -- 'gdscript',
      -- 'python',
      -- 'nim',
      -- 'lua',
      -- 'cpp',
      -- 'cmake',
      -- 'json',
      -- 'yaml',
      -- 'toml',
      -- 'sh',
    },
    servers = {
      -- 'bashls',
      -- 'clangd',
      -- 'eslint',
      -- 'jsonls',
      -- 'ltex',
      -- 'pylsp',
      -- 'sumneko_lua',
      -- 'tailwindcss',
      -- 'texlab',
      -- 'tsserver',
      -- 'volar',
      -- 'yamlls',
      -- 'nimls'
    },
  },
  ts = {
    ensure_installed = {
      -- 'viml',
      -- 'http',
      -- 'norg',
      -- 'latex',

      -- 'html',
      -- 'css',
      -- 'javascript',
      -- 'typescript',
      -- 'vue',

      -- 'gdscript',
      -- 'godot_resource',

      -- 'python',

      -- 'lua',

      -- 'cpp',
      -- 'cmake',

      -- 'json',
      -- 'toml',
      -- 'yaml',

      -- 'bash',
      'regex',
      'comment',
      -- 'dockerfile',
    },
    highlight = {
      disable = {}
    },
    incremental_selection = {
      disable = {}
    },
    indent = {
      disable = {
        -- 'gdscript',
        -- 'python',
      }
    },
  },
}

return M

