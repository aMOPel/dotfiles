local configs = {}

configs['nvim-lspconfig'] = function()
  -- mappings
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- for k, v in pairs(client.resolved_capabilities) do
    --   print(k,v)
    -- end
    -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }
    if client.resolved_capabilities.declaration then
      buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    end
    if client.resolved_capabilities.goto_definition then
      buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    end
    if client.resolved_capabilities.implementation then
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    end
    -- if client.resolved_capabilities.find_references then
    --   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- end
    if client.resolved_capabilities.hover then
      buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    end
    if client.resolved_capabilities.signature_help then
      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      buf_set_keymap('i', '<C-k>', '<c-o><cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    end
    if client.resolved_capabilities.type_definition then
      buf_set_keymap('n', '<space>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    end
    if client.resolved_capabilities.rename then
      buf_set_keymap('n', '<space>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    end
    if client.resolved_capabilities.code_action then
      buf_set_keymap('n', '<space>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    end
    if client.resolved_capabilities.workspace_symbol then
      buf_set_keymap('n', '<space>lS', '<cmd>lua vim.lsp.buf.workspace_symbol("")<CR>', opts)
    end
    if client.resolved_capabilities.document_symbol then
      buf_set_keymap('n', '<space>ls', '<cmd>lua vim.lsp.buf.document_symbol("")<CR>', opts)
    end
    if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end
    -- if client.resolved_capabilities.document_range_formatting then
    --   buf_set_keymap("v", "<space>lf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    -- end

    -- TODO add move to quickfix after document_symbol
    -- TODO change codeAction to work with completion menu, and to autoselect, if theres only one choice
    -- vim.lsp.handlers["textDocument/codeAction"] = my_custom_default_definition

    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>le', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>lq', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)


    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_exec([[
      hi LspReferenceRead  cterm=underline term=underline gui=underline
      hi LspReferenceText  cterm=underline term=underline gui=underline
      hi LspReferenceWrite cterm=underline term=underline gui=underline
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]] , false)
    end
  end

  -------------------------------------------------------------------
  -- snippets

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true;
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }

  -------------------------------------------------------------------
  -- setup servers

  local g = require 'globals'
  local lsp_installer_servers = g.lsp.servers.lsp_installer
  local other_servers = g.lsp.servers.other

  require 'nvim-lsp-installer'.setup {
    ensure_installed = lsp_installer_servers
  }

  local lspconfig = require('lspconfig')

  function default_config(on_attach, capabilities)
    return {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end

  function setup_server(server_name, server_config)
    local config = {}

    if server_config == 'default' then
      config = default_config(on_attach, capabilities)
    elseif type(server_config) == 'function' then
      config = server_config(on_attach, capabilities)
    else
      print('error with '..server_name)
    end

    if (config["capabilities"] ~= nil) then
      config.capabilities = require('cmp_nvim_lsp').update_capabilities(config.capabilities)
    else
      config.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    end
    lspconfig[server_name].setup(config)
    -- vim.cmd [[ do User LspAttachBuffers ]]
  end

  for server_name, server_config in pairs(lsp_installer_servers) do
    setup_server(server_name, server_config)
  end

  for server_name, server_config in pairs(other_servers) do
    setup_server(server_name, server_config)
  end
end

local g = require 'globals'
local p = require 'utils'.p

local M = function(use)
  use {
    p 'https://github.com/neovim/nvim-lspconfig',
    requires = {
      { 'cmp-nvim-lsp' },
      { p 'https://github.com/williamboman/nvim-lsp-installer' },
      {
        p 'https://gitlab.com/yorickpeterse/nvim-dd',
        -- config = function() require('dd').setup { timeout = 1000, } end
      },
      { p 'https://github.com/j-hui/fidget.nvim' },
      { p 'https://github.com/b0o/SchemaStore.nvim' },
    },
    config = configs['nvim-lspconfig'],
    ft = g.lsp.fts,
  }

end
return M
