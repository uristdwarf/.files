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

  local mason_servers = {
    clangd = {},
    gopls = {},
    -- rust_analyzer = {
    --   diagnostics = {
    --     enable = true,
    --   }
    -- },
    pyright = {},
    lua_ls = require('langs.lua').lsp,
    bashls = {},
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

	local manual_servers = {
		gdscript = {},
	}

	for k, v in pairs(manual_servers) do
		lspconfig[k].setup(v)
	end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

  require('mason-lspconfig').setup {
    handlers = {
      function(server_name)
        local server = mason_servers[server_name] or {}
        -- This handles overriding only values explicitly passed
        -- by the server configuration above. Useful when disabling
        -- certain features of an LSP (for example, turning off formatting for tsserver)
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        require('lspconfig')[server_name].setup(server)
      end,
    }
  }
end

return lsp_setup
