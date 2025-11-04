return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "frappe",
      transparent_background = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        -- 启用 which-key 的透明集成
        which_key = true,
      },
    })

    vim.cmd.colorscheme "catppuccin"
    -- lua/plugins/color-scheme.lua
-- ...
    vim.cmd.colorscheme "catppuccin"

    -- 强制核心元素透明
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" }) -- whickkey/recent's border
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" }) -- floating windows border
    -- vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
  end,
}