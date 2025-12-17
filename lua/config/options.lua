-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.number = true         -- show absolute line numbers
vim.opt.relativenumber = false -- disable relative numbers

-- Use NuShell (nu) as the default shell on Windows
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	vim.opt.shell = "nu"
	vim.opt.shellcmdflag = "-c"
	vim.opt.shellquote = ""
	vim.opt.shellxquote = ""
	-- NuShell redirection settings
	vim.opt.shellredir = "out+err> %s"
	vim.opt.shellpipe = "out+err> %s"
end