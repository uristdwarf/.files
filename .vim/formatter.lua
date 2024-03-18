-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    javascript = {
      require("formatter.filetypes.javascript").jsbeautify,
    },
    vue = {
      require("formatter.defaults").eslint_d,
    },
    cs = {
      function()
        return {
          exe = "dotnet",
          args = {
            "format",
            "--include",
          },
          cwd = utils.get_cwd(),
          stdin = false,
        }
      end
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}
