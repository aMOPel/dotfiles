local g = require 'globals'
local add = require 'utils'.addTable

local ft = 'css'

add(g.lsp.fts, {
  ft,
})

add(g.lsp.servers.lsp_installer, {
  tailwindcss = function(on_attach, capabilities)
    local add_on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      on_attach(client, bufnr)
    end

    return {
      filetypes = { 'html', 'vue', 'css' },
      capabilities = capabilities,
      on_attach = add_on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end,
  cssls = function(on_attach, capabilities)
    local add_on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      on_attach(client, bufnr)
    end

    return {
      filetypes = { 'css' },
      capabilities = capabilities,
      on_attach = add_on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end,
})

add(g.treesitter.ensure_installed, {
  ft,
})
