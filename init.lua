-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 打开文件时自动切换到文件所在目录
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.cmd("silent! lcd %:p:h")  -- 切换到当前文件的目录
  end,
})