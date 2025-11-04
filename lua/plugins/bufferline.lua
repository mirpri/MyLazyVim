return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    return {
      options = {
        separator_style = { "", "" }, -- No separators
        indicator = {
          style = "icon",
          icon = "●",
        },
        always_show_bufferline = false, -- Only show when more than one buffer
      },
    }
  end,
}
