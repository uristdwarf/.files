function lsp_setup()
	local servers = {
		clangd = {},
		gopls = {},
		pyright = {},
		lua_ls = {
			-- cmd = {...},
			-- filetypes { ...},
			-- capabilities = {},
			settings = {
				Lua = {
					runtime = { version = 'LuaJIT' },
					workspace = {
						checkThirdParty = false,
						-- Tells lua_ls where to find all the Lua files that you have loaded
						-- for your neovim configuration.
						library = {
							'${3rd}/luv/library',
							unpack(vim.api.nvim_get_runtime_file('', true)),
						},
						-- If lua_ls is really slow on your computer, you can try this instead:
						-- library = { vim.env.VIMRUNTIME },
					},
					completion = {
						callSnippet = 'Replace',
					},
					-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
					-- diagnostics = { disable = { 'missing-fields' } },
				},
			},
		},
	}
	
	for k, v in pairs(servers) do
		require('lspconfig')[k].setup(v)
	end
end

return lsp_setup
