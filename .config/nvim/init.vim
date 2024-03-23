" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show (relative) line numbers.
set relativenumber

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set number

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Enable linebreak for words
set linebreak

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Recommended by vim.rust
filetype plugin indent on
let g:rustfmt_autosave = 1

" Color scheme

" Don't highlight search
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
:inoremap <C-v> <ESC>"+pa
:vnoremap <C-c> "+y
:vnoremap <C-d> "+d

" Fuzzy search keybinding
let g:ctrlp_map = '<c-p>'

" Auto save when building
set autowrite

inoremap <C-CR> <Esc>

" Go settings
let g:go_fmt_command = "goimports"
au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1


call plug#begin()
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'fatih/vim-go'
	Plug 'tpope/vim-fugitive'
	Plug 'sebdah/vim-delve'
	Plug 'scrooloose/nerdtree'
	
	Plug 'neovim/nvim-lspconfig'
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/vim-vsnip'
	Plug 'ray-x/lsp_signature.nvim'
	Plug 'mfussenegger/nvim-lint'
	
	" Themes
	Plug 'marko-cerovac/material.nvim'
	Plug 'sainnhe/sonokai'
	
	Plug 'voldikss/vim-floaterm'
	Plug 'mattn/emmet-vim'
	Plug 'airblade/vim-gitgutter'

	" Rust
	Plug 'rust-lang/rust.vim'
	Plug 'simrat39/rust-tools.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'mfussenegger/nvim-dap'
	" Plug 'rcarriga/nvim-dap-ui'

	Plug 'tpope/vim-sleuth'

	" Plug 'OmniSharp/omnisharp-vim'
	" Plug 'jiangmiao/auto-pairs'
	Plug 'yuezk/vim-js'
	Plug 'maxmellon/vim-jsx-pretty'
	Plug 'jparise/vim-graphql'
	Plug 'leafOfTree/vim-vue-plugin'
	Plug 'mhartington/formatter.nvim'
	" Treesitter
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-treesitter/playground'

	Plug 'rhysd/conflict-marker.vim'
	Plug 'neomake/neomake'

	Plug 'folke/neodev.nvim'
	Plug 'folke/neoconf.nvim'

	" VimWiki
	Plug 'vimwiki/vimwiki'

	" Telescope
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }

	" Copilot
	Plug 'zbirenbaum/copilot.lua'
	Plug 'zbirenbaum/copilot-cmp'


call plug#end()

" Wiki
nmap <Leader>wn <Plug>VimwikiNextLink
let g:vimwiki_global_ext = 0

if has('termguicolors')
  set termguicolors
endif

" Colors
let g:sonokai_style = 'default'
let g:sonokai_better_performance = 1
colorscheme sonokai
:lua vim.g.material_style = "palenight"

" Completion option
set completeopt=menu,menuone,noselect

" lsp configs
luafile ~/.vim/lsp_config.lua
sign define LspDiagnosticsSignError text=🔴
sign define LspDiagnosticsSignWarning text=🟠
sign define LspDiagnosticsSignInformation text=🔵
sign define LspDiagnosticsSignHint text=🟢

" formatter configs
luafile ~/.vim/formatter.lua

" debugger config
" luafile ~/.vim/dap_config.lua

" linter config
luafile ~/.vim/linters.lua

" copilot config
luafile ~/.vim/copilot.lua

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ge    <cmd>lua vim.diagnostic.setloclist()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <leader>f    <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>rn    <cmd>lua vim.lsp.buf.rename()<CR>


nnoremap <silent> <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
xmap <silent> <leader>a <cmd>lua vim.lsp.buf.range_code_action()<CR>

" Telescope
" Find files using Telescope command-line sugar.
" Using Lua functions
nnoremap <leader>tf <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>tg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>tb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>th <cmd>lua require('telescope.builtin').help_tags()<cr>

let mapleader = ","
let g:floaterm_keymap_toggle = '<F12>'
nmap <F5> :NERDTreeToggle<CR>

" JS settings
function s:RunBeat()
	execute '!js-beautify' shellescape(@%, 1)
	if v:shell_error | throw 'js-beautify failed' | endif
endfunction

function s:DefineBWPJs()
	augroup Run_js
		autocmd! BufWritePre <buffer> :call s:RunBeat()
	augroup END
endfunction

augroup Run_js
	autocmd!
	autocmd FileType * :autocmd! Run_js BufWritePre <buffer>
	autocmd FileType js :call s:DefineBWPJs()
augroup end

" Rust settings
let g:rustfmt_autosave = 1

" Auto close {} brackets
inoremap { {}<Left>
inoremap <expr> <CR> search('{\%#}', 'n') ? "\<CR>\<CR>\<Up>\<C-F>" : "\<CR>"
" Don't remove indent on empty lines
" inoremap <CR> <CR>x<BS>
" nnoremap o ox<BS>
" nnoremap O Ox<BS>

" vim-vue-plugin
let g:vim_vue_plugin_config = { 
      \'syntax': {
      \   'template': ['html'],
      \   'script': ['javascript'],
      \   'style': ['css'],
      \},
      \'full_syntax': [],
      \'initial_indent': [],
      \'attribute': 0,
      \'keyword': 0,
      \'foldexpr': 0,
      \'debug': 0,
      \}


" treesitter configs
luafile ~/.vim/treesitter.lua
