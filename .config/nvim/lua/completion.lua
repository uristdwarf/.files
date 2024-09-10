-- Helper functions
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- Main config

local function tab_map(fallback)
  local luasnip = require('luasnip')
  local cmp = require('cmp')

  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.available(1) == 1 then
    luasnip.expand_or_jump()
  elseif has_words_before() then
    cmp.complete()
  else
    fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
  end
end

local function shift_tab_map()
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  end
end

local function cmp_mappings(cmp, luasnip)
  return {
    ["<Tab>"] = cmp.mapping(tab_map),
    ["<S-Tab>"] = cmp.mapping(shift_tab_map),

    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

    -- Manually trigger a completion from nvim-cmp.
    ['<C-Space>'] = cmp.mapping.complete {},

    -- Think of <c-l> as moving to the right of your snippet expansion.
    --  So if you have a snippet that's like:
    --  function $name($args)
    --    $body
    --  end
    --
    -- <c-l> will move you to the right of each of the expansion locations.
    -- <c-h> is similar, except moving you backwards.
    ['<C-l>'] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { 'i', 's' }),
  }
end

return function()
  -- See `:help cmp`
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  luasnip.config.setup {}

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    completion = { completeopt = 'menu,menuone,noinsert' },

    mapping = cmp_mappings(cmp, luasnip),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'buffer' },
    },
  }
end
