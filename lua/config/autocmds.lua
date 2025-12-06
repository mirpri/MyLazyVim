-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 打开终端时自动进入插入模式
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    command = "startinsert",
})

vim.api.nvim_create_autocmd("SwapExists", {
  callback = function()
    vim.cmd("let v:swapchoice = 'e'") -- Automatically choose to edit the file
  end,
})

-- 打开文件时自动切换到文件所在目录
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*",
--   callback = function()
--     vim.cmd("silent! lcd %:p:h")  -- 切换到当前文件的目录
--   end,
-- })

-- 禁用拼写检查
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.spell = false
    -- 禁用自动注释（确保在文件类型插件加载后生效）
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- 修复 nvim-cmp 在插入模式下拖动鼠标插入奇怪文本的问题
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.schedule(function()
      local keys = { "<LeftMouse>", "<LeftDrag>", "<LeftRelease>" }
      for _, key in ipairs(keys) do
        local map = vim.fn.maparg(key, "i")
        if map and map:find("cmp.utils.feedkeys") then
          vim.keymap.del("i", key)
        end
      end
    end)
  end,
})