local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	{ -- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		-- dependencies = {
		-- 	-- Automatically install LSPs and related tools to stdpath for neovim
		-- 	'williamboman/mason.nvim',
		-- 	'williamboman/mason-lspconfig.nvim',
		-- 	'WhoIsSethDaniel/mason-tool-installer.nvim',

		-- 	-- Useful status updates for LSP.
		-- 	-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		-- 	{ 'j-hui/fidget.nvim', opts = {} },
		-- },
	config = function()
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
	},
	{
		'folke/which-key.nvim',
		event = 'VimEnter'
	}
})
