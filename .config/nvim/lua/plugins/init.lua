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
      { 'williamboman/mason.nvim', config=true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- 	-- Useful status updates for LSP.
      -- 	-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },
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
  -- 'pearofducks/ansible-vim',

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
      { '<F5>', '<cmd>NvimTreeToggle<CR>', desc = 'Open file tree' }
    }
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        highlight = {
          enable = true,
          disable = { "dockerfile", "htmldjango" },
        },
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
  {
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<C-p>',      function() require('telescope.builtin').find_files() end,          desc = 'Search files' },
      { '<leader>fg', function() require('telescope.builtin').live_grep() end,           desc = 'Grep files' },
      { '<leader>\\', function() require('telescope.builtin').buffers() end,             desc = 'Buffers' },
      { '<leader>gs', function() require('telescope.builtin').grep_string() end,         desc = 'Grep string' },
      { 'gr',         function() require('telescope.builtin').lsp_references() end,      desc = '[LSP] References' },
      { 'gE',         function() require('telescope.builtin').diagnostics() end,         desc = '[LSP] Diagnostics' },
      { 'gd',         function() require('telescope.builtin').lsp_definitions() end,     desc = '[LSP] Diagnostics' },
      { 'gi',         function() require('telescope.builtin').lsp_implementations() end, desc = '[LSP] Diagnostics' },
    }
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
      'hrsh7th/cmp-buffer',

      -- If you want to add a bunch of pre-configured snippets,
      --    you can use this plugin to help you. It even has snippets
      --    for various frameworks/libraries/etc. but you will have to
      --    set up the ones that are useful for you.
      'rafamadriz/friendly-snippets',
    },
    config = require('completion')
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        -- inlay_hints = {
        --   highlight = "NonText",
        -- },
        server = {
          default_settings = {
            -- on_attach = function(client, bufnr)
            -- end,
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              -- Add clippy lints for Rust.
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          }
        },
      }
    end,
  },
  -- {
  --   'https://github.com/simrat39/rust-tools.nvim',
  --   ft = "rust",
  --   config = function()
  --     require("rust-tools").setup({
  --       server = {
  --         settings = {
  --           -- rust-analyzer language server configuration
  --           ["rust-analyzer"] = {
  --             cargo = {
  --               allFeatures = true,
  --               loadOutDirsFromCheck = true,
  --               buildScripts = {
  --                 enable = true,
  --               },
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
  --       }
  --     })
  --   end
  -- },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
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
  {
    'stevearc/conform.nvim',
    opts = require("formatting"),
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
  {
    'chaoren/vim-wordmotion'
  },
  {
    "aserowy/tmux.nvim",
  },
  -- {'ckipp01/nvim-jenkinsfile-linter', dependencies = { "nvim-lua/plenary.nvim" } },
  -- lazy.nvim
})
