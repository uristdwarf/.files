vim.g.autoformat = false
vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.autoformat = false
	else
		vim.g.autoformat = false
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.autoformat = true
	vim.g.autoformat = true
end, {
	desc = "Re-enable autoformat-on-save",
})

return {
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt", lsp_format = "fallback" },
		bash = { "shfmt", lsp_format = "fallback" },
		sh = { "shfmt", lsp_format = "fallback" },
		go = { "gofumpt", lsp_format = "fallback" },
	},
	format_on_save = function(bufnr)
		-- Disable with a global or buffer-local variable
		if not vim.g.autoformat or not vim.b[bufnr].autoformat then
			return
		end
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
}
