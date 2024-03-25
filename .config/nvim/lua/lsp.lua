local function lsp_setup()
  local lspconfig = require('lspconfig')

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[LSP] Go to definition' })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = '[LSP] Go to implementation' })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = '[LSP] Go to references' })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[LSP] Go to declaration' })
  vim.keymap.set('n', 'ge', vim.diagnostic.setloclist, { desc = '[LSP] List diagnostics' })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = '[LSP] Documentation' })

  local servers = {
    clangd = {},
    gopls = {},
    pyright = {},
    lua_ls = require('langs.lua').lsp
  }

  for k, v in pairs(servers) do
    lspconfig[k].setup(v)
  end
end

return lsp_setup
