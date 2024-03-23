local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
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
	config = require('lsp') -- Config is it's own module
	},
	{
		'folke/which-key.nvim',
		event = 'VimEnter'
	}
})
