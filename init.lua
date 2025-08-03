-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 禁用 LazyVim 的自动格式化功能
vim.g.autoformat = false

vim.o.title = true
vim.o.titlestring = "nvim - %t"