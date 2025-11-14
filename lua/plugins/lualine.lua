return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    return {
      options = {
        theme = "auto", -- 自动检测并使用当前颜色主题
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
