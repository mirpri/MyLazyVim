-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>rc", function()
    local filename = vim.fn.expand("%:p")
    local filepath = vim.fn.expand("%:p:h")
    local filebase = vim.fn.fnamemodify(filename, ":t:r")

    -- Use system temp directory for compiled outputs
    local temp_dir = vim.fn.expand("$TEMP") .. "\\nvim_cpp_temp"

    -- Create temp directory if it doesn't exist and remove existing executable
    local exe_path = temp_dir .. "\\" .. filebase .. ".exe"
    -- Use Lua APIs (shell-agnostic) instead of shell commands; pwsh is our shell, but this is simpler and safer
    vim.fn.mkdir(temp_dir, "p")
    if vim.fn.filereadable(exe_path) == 1 then
        vim.fn.delete(exe_path)
    end
    -- Save the file before compiling
    vim.cmd("w")

    -- Temp directory ensured and old executable removed above

    -- Compile the file with proper error capture
    local compile_cmd = string.format("g++ -std=c++24 \"%s\" -o \"%s\" 2>&1", filename, exe_path)
    local compile_output = vim.fn.system(compile_cmd)
    -- Check if compilation was successful and executable exists
    if vim.v.shell_error == 0 and vim.fn.filereadable(exe_path) == 1 then
        -- Run the compiled executable in a terminal split via PowerShell
        local term_cmd = string.format(":split | :term pwsh -NoLogo -NoProfile -Command \"& '%s'\"", exe_path)
        vim.cmd(term_cmd)
    else
        -- Show error message if compilation failed
        local error_msg = "Compilation failed!"
        if compile_output and compile_output ~= "" then
            error_msg = "Compilation failed:\n" .. compile_output
        end
        vim.notify(error_msg, vim.log.levels.ERROR)
    end
end, {
    noremap = true,
    silent = true,
    desc = "runCpp"
})

-- Add a keymap to clean up the temporary compilation directory
vim.keymap.set("n", "<leader>rC", function()
    local temp_dir = vim.fn.expand("$TEMP") .. "\\nvim_cpp_temp"

    -- Check if the directory exists before attempting to remove it
    if vim.fn.isdirectory(temp_dir) == 1 then
        -- PowerShell-native removal
        local cleanup_cmd = string.format("Remove-Item -LiteralPath \"%s\" -Recurse -Force -ErrorAction SilentlyContinue", temp_dir)
        vim.fn.system(cleanup_cmd)

        if vim.v.shell_error == 0 then
            vim.notify("Temporary compilation directory cleaned successfully", vim.log.levels.INFO)
        else
            vim.notify("Failed to clean temporary compilation directory", vim.log.levels.ERROR)
        end
    else
        vim.notify("Temporary compilation directory does not exist", vim.log.levels.WARN)
    end
end, {
    noremap = true,
    silent = true,
    desc = "cleanCppTemp"
})

vim.keymap.set("n", "<leader>rp", function()
  local filename = vim.fn.expand("%:p")
  local filepath = vim.fn.expand("%:p:h")
  local filebase = vim.fn.fnamemodify(filename, ":t:r")
  
  vim.cmd("w") -- Save the file before running
  
    -- Run the Python script in a terminal split via PowerShell
    local run_cmd = string.format(":split | :term pwsh -NoLogo -NoProfile -Command \"python '%s'\"", filename)
  vim.cmd(run_cmd)
end, { noremap = true, silent = true, desc = "runPython" })

-- Register the <leader>r menu name using which-key API (latest spec)
local wk = require("which-key")
wk.add({{
    "<leader>r",
    group = "Run/Compile"
}})

vim.keymap.set("n", "<leader>rr", function()
  local filename = vim.fn.expand("%:p")
  local filepath = vim.fn.expand("%:p:h")
  local filebase = vim.fn.fnamemodify(filename, ":t:r")
  
  vim.cmd("w") -- Save the file before running
  
    -- Cargo run in a terminal split via PowerShell
    local run_cmd = string.format(":split | :term pwsh -NoLogo -NoProfile -Command \"cargo run '%s'\"", filepath)
  vim.cmd(run_cmd)
end, { noremap = true, silent = true, desc = "runRust (cargo)" })