-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 禁用 LazyVim 的自动格式化功能
vim.g.autoformat = false

-- 设置 Neovim 的标题
vim.o.title = true
vim.o.titlestring = "nvim - %t"