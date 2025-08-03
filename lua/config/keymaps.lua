-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>rr", function()
    local filename = vim.fn.expand("%:p")
    local filepath = vim.fn.expand("%:p:h")
    local filebase = vim.fn.fnamemodify(filename, ":t:r")

    -- Use system temp directory for compiled outputs
    local temp_dir = vim.fn.expand("$TEMP") .. "\\nvim_cpp_temp"

    -- Create temp directory if it doesn't exist and remove existing executable
    local exe_path = temp_dir .. "\\" .. filebase .. ".exe"
    local mkdir_cmd = string.format("if not exist \"%s\" mkdir \"%s\"", temp_dir, temp_dir)
    local remove_cmd = string.format("if exist \"%s\" del \"%s\"", exe_path, exe_path)
    -- Save the file before compiling
    vim.cmd("w")

    -- Create temp directory first
    vim.fn.system(mkdir_cmd)

    -- Remove existing executable if it exists
    vim.fn.system(remove_cmd)

    -- Compile the file with proper error capture
    local compile_cmd = string.format("g++ \"%s\" -o \"%s\" 2>&1", filename, exe_path)
    local compile_output = vim.fn.system(compile_cmd)
    -- Check if compilation was successful and executable exists
    if vim.v.shell_error == 0 and vim.fn.filereadable(exe_path) == 1 then
        -- Run the compiled executable in a terminal split
        local run_cmd = string.format(":split | :term \"%s\"", exe_path)
        vim.cmd(run_cmd)
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
vim.keymap.set("n", "<leader>rc", function()
    local temp_dir = vim.fn.expand("$TEMP") .. "\\nvim_cpp_temp"

    -- Check if the directory exists before attempting to remove it
    if vim.fn.isdirectory(temp_dir) == 1 then
        -- Use rmdir /s /q for recursive directory removal on Windows
        local cleanup_cmd = string.format("rmdir /s /q \"%s\"", temp_dir)
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
  
  -- Run the Python script in a terminal split
  local run_cmd = string.format(":split | :term python \"%s\"", filename)
  vim.cmd(run_cmd)
end, { noremap = true, silent = true, desc = "runPython" })

-- Register the <leader>r menu name using which-key API (latest spec)
local wk = require("which-key")
wk.add({{
    "<leader>r",
    group = "Run/Compile"
}})
