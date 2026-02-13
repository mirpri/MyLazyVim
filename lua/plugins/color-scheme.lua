return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      transparent_mode = true,
    })

    vim.cmd.colorscheme("gruvbox")

    -- 强制核心元素透明
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" }) -- whickkey/recent's border
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" }) -- floating windows border
    -- vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
  end,
}