-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.number = true         -- show absolute line numbers
vim.opt.relativenumber = false -- disable relative numbers

-- Use PowerShell (pwsh) as the default shell on Windows
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	vim.opt.shell = "pwsh"
	-- Recommended flags for pwsh compatibility with Neovim
	vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
	-- Redirect and encoding settings to capture output correctly
	vim.opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
	vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
	-- Avoid extra quoting that breaks commands
	vim.opt.shellquote = ""
	vim.opt.shellxquote = ""
end