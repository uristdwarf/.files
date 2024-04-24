-- Vim options
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.laststatus = 2

vim.opt.errorbells = false
vim.opt.visualbell = false

vim.opt.mouse = 'a'

-- Is this really necessary in Neovim? TODO: Look at docs
-- The backspace key has slightly unintuitive behavior by default. For example,
-- by default, you can't backspace before the insertion point set with 'i'.
-- This configuration makes backspace behave more reasonably, in that you can
-- backspace over anything.
vim.opt.backspace = { 'indent', 'eol', 'start' }

vim.opt.hidden = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.autowrite = true

vim.opt.scrolloff = 10

vim.opt.termguicolors = true

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Global mappings
vim.keymap.set('n', 'Q', "")

local arrow_message = '<cmd> echoe "GET OFF MY COMPUTER YOU PLEB! (use hjkl)"<cr>'
local disabled_modes = { 'n', 'i' }
vim.keymap.set(disabled_modes, '<Left>', arrow_message)
vim.keymap.set(disabled_modes, '<Right>', arrow_message)
vim.keymap.set(disabled_modes, '<Up>', arrow_message)
vim.keymap.set(disabled_modes, '<Down>', arrow_message)

-- Disable highlighting
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-w>\\', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<C-w>-', '<C-w>s', { desc = 'Split window horizontally' })

-- Autocmds

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- Set filetype to shell when using C-x C-e from terminal
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "/tmp/bash-fc*",
    callback = function()
        vim.bo.filetype = "sh"
    end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)


-- Plugin manager (in another file)
require('plugins')
