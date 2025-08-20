return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local custom_theme = {
      normal = {
        a = { fg = "#67f0fc", bg = "NONE", gui = "bold" },
        b = { fg = "#fce167", bg = "NONE" },
        c = { fg = "#ffffff", bg = "NONE" },
      },
      insert = {
        a = { fg = "#a6ff4c", bg = "NONE", gui = "bold" },
      },
      visual = {
        a = { fg = "#bf88ff", bg = "NONE", gui = "bold" },
      },
      replace = {
        a = { fg = "#ff2f63", bg = "NONE", gui = "bold" },
      },
      command = {
        a = { fg = "#ffe100", bg = "NONE", gui = "bold" },
      },
      terminal = {
        a = { fg = "#ff8c00", bg = "NONE", gui = "bold" },
      },
      inactive = {
        a = { fg = "#c1c1c1", bg = "NONE", gui = "bold" },
        b = { fg = "#c1c1c1", bg = "NONE" },
        c = { fg = "#c1c1c1", bg = "NONE" },
      },
    }

    return {
      options = {
        theme = custom_theme,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch",
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                sections = { "error", "warn", "info", "hint" },
                symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
                colored = true,
                update_in_insert = false,
                always_visible = false,
            },
        },
        lualine_c = { "filename" },
        lualine_x = {
          {
            function()
              local ts = vim.bo.tabstop
              local sw = vim.bo.shiftwidth
              return string.format(" %d,%d", ts, sw) -- '' is a commonly supported symbol for files
            end,
          },
          "encoding",
          "filetype"
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    }
  end,
}
