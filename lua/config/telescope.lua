require("telescope").setup({
  pickers = {
    find_files = {
      find_command = {
        "fd",
        "--type", "f",
        "--hidden",  -- 搜索隐藏文件
        "--no-ignore",  -- 不忽略 .gitignore
        "--full-path",  -- 匹配完整路径
        "--glob", "**/*",  -- 递归搜索所有文件
        "--path-separator", "/",  -- 确保路径格式正确
      },
    },
  },
})