local diagnostics_is_hidden = false
local function toggle_diagnostics()
  if diagnostics_is_hidden then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end

  diagnostics_is_hidden = not diagnostics_is_hidden
end

-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--      local bufnr = args.buf
--      local client = vim.lsp.get_client_by_id(args.data.client_id)
--      if client.server_capabilities.inlayHintProvider then
--        vim.lsp.inlay_hint.enable(bufnr, true)
--      end
--   end,
-- })

local function lsp_setup()
  local lspconfig = require('lspconfig')

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[LSP] Go to definition' })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = '[LSP] Go to implementation' })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = '[LSP] Go to references' })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[LSP] Go to declaration' })
  vim.keymap.set('n', 'ge', vim.diagnostic.open_float, { desc = '[LSP] List diagnostics' })
  vim.keymap.set('n', 'gE', vim.diagnostic.setloclist, { desc = '[LSP] List diagnostics' })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = '[LSP] Documentation' })
  vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = '[LSP] Code Action' })
  vim.keymap.set('n', '<leader>td', toggle_diagnostics, { desc = '[LSP] Toggle diagnostics' })

  local servers = {
    clangd = {},
    gopls = {},
    -- rust_analyzer = {
    --   diagnostics = {
    --     enable = true,
    --   }
    -- },
    pyright = {},
    lua_ls = require('langs.lua').lsp,
    taplo = {
      keys = {
        {
          "K",
          function()
            if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
              require("crates").show_popup()
            else
              vim.lsp.buf.hover()
            end
          end,
          desc = "Show Crate Documentation",
        },
      },
    },
  }

  for k, v in pairs(servers) do
    lspconfig[k].setup(v)
  end
end

return lsp_setup
