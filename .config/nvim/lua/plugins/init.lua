local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- 	-- Automatically install LSPs and related tools to stdpath for neovim
      -- 	'williamboman/mason.nvim',
      -- 	'williamboman/mason-lspconfig.nvim',
      -- 	'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- 	-- Useful status updates for LSP.
      -- 	-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      -- 	{ 'j-hui/fidget.nvim', opts = {} },
    },
    config = require('lsp') -- Config is its own module
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = true,
  },

  'tpope/vim-fugitive',
  'tpope/vim-sleuth',

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup()
    end,
    keys = {
      { '<F5>', '<cmd>NvimTreeToggle<CR>', { desc = 'Open file tree' } }
    }
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end
  },

  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'gruvbox'
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- If you want to add a bunch of pre-configured snippets,
      --    you can use this plugin to help you. It even has snippets
      --    for various frameworks/libraries/etc. but you will have to
      --    set up the ones that are useful for you.
      'rafamadriz/friendly-snippets',
    },
    config = require('completion')
  },
  -- {
  --   'mrcjkb/rustaceanvim',
  --   version = '^4', -- Recommended
  --   ft = { 'rust' },
  --   config = function()
  --     vim.g.rustaceanvim = {
  --       -- inlay_hints = {
  --       --   highlight = "NonText",
  --       -- },
  --       server = {
  --         default_settings = {
  --           -- on_attach = function(client, bufnr)
  --           -- end,
  --           ["rust-analyzer"] = {
  --             cargo = {
  --               allFeatures = true,
  --               loadOutDirsFromCheck = true,
  --               runBuildScripts = true,
  --             },
  --             -- Add clippy lints for Rust.
  --             checkOnSave = {
  --               allFeatures = true,
  --               command = "clippy",
  --               extraArgs = { "--no-deps" },
  --             },
  --             procMacro = {
  --               enable = true,
  --               ignored = {
  --                 ["async-trait"] = { "async_trait" },
  --                 ["napi-derive"] = { "napi" },
  --                 ["async-recursion"] = { "async_recursion" },
  --               },
  --             },
  --           },
  --         }
  --       },
  --     }
  --   end,
  -- },
  {
    'https://github.com/simrat39/rust-tools.nvim',
    ft = "rust",
    config = function()
      require("rust-tools").setup()
    end
  },
  {
  "ray-x/go.nvim",
  dependencies = {  -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup()
  end,
  event = {"CmdlineEnter"},
  ft = {"go", 'gomod'},
  build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
},
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      src = {
        cmp = { enabled = true },
      },
    },
  },
})
