require('copilot').setup({
  panel = {
    enabled = false,
  },
  suggestion = {
    enabled = false,
    auto_trigger = false,
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
    lua = true,
  },
})
require("copilot_cmp").setup()
