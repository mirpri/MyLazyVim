return {
  {
    "tanvirtin/monokai.nvim",
    name = "monokai",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("monokai")
      -- 设置背景为透明
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      -- 设置行号背景为透明
      vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
    end,
  },
  {
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
        a = { fg = "#b06bffff", bg = "NONE", gui = "bold" },
      },
      replace = {
        a = { fg = "#ff2f63", bg = "NONE", gui = "bold" },
      },
      command = {
        a = { fg = "#ffe100", bg = "NONE", gui = "bold" },
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
        component_separators = { left = "/", right = "/" },
        globalstatus = true,
      },
    }
  end,
}

}
