return {
  {
    "tanvirtin/monokai.nvim",
    name = "monokai",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("monokai")
      -- 设置背景为透明
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
      -- 设置行号背景为透明
      vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          section_separators = { left = "", right = "" }, -- 圆滑的分隔符
          component_separators = { left = "/", right = "/" },
        },
      }
    end,
  },
}
