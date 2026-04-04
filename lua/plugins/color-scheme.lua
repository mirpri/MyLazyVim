return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- 1. 必须开启真彩色，否则文字颜色会失真
      vim.opt.termguicolors = true

      -- 2. 配置 vscode 主题插件
      require('vscode').setup({
        -- 开启透明背景（核心设置）
        transparent = true,
        
        -- 开启斜体注释（可选，看个人喜好）
        italic_comments = true,
        
        -- 禁用底部的状态栏背景色（让 Lualine 等插件也变透明）
        disable_nvimtree_bg = true, 
      })

      -- 3. 应用主题
      vim.cmd.colorscheme("vscode")
    end,
  }
}