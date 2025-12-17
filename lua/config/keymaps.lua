-- Run/Compile C++ in NuShell
vim.keymap.set("n", "<leader>rc", function()
    local filename = vim.fn.expand("%:p"):gsub("\\", "/")
    local filebase = vim.fn.fnamemodify(filename, ":t:r")
    local temp_dir = vim.fn.expand("$TEMP") .. "/nvim_cpp_temp"
    temp_dir = temp_dir:gsub("\\", "/")
    local exe_path = temp_dir .. "/" .. filebase .. ".exe"

    vim.fn.mkdir(temp_dir, "p")
    if vim.fn.filereadable(exe_path) == 1 then vim.fn.delete(exe_path) end
    vim.cmd("w") -- save file

    -- Compile via NuShell
    local compile_cmd = string.format('nu -c "g++ \\"%s\\" -o \\"%s\\""', filename, exe_path)
    local compile_output = vim.fn.system(compile_cmd)

    if vim.v.shell_error == 0 and vim.fn.filereadable(exe_path) == 1 then
        -- Run executable in split terminal
        vim.cmd(string.format(':split | :term nu -c "%s"', exe_path))
    else
        local error_msg = "Compilation failed!"
        if compile_output and compile_output ~= "" then
            error_msg = "Compilation failed:\n" .. compile_output
        end
        vim.notify(error_msg, vim.log.levels.ERROR)
    end
end, { noremap = true, silent = true, desc = "runCpp" })

-- Clean temp directory
vim.keymap.set("n", "<leader>rC", function()
    local temp_dir = vim.fn.expand("$TEMP") .. "/nvim_cpp_temp"
    if vim.fn.isdirectory(temp_dir) == 1 then
        local cleanup_cmd = string.format('nu -c "rm -r -f \\"%s\\""', temp_dir)
        vim.fn.system(cleanup_cmd)
        if vim.v.shell_error == 0 then
            vim.notify("Temporary compilation directory cleaned successfully", vim.log.levels.INFO)
        else
            vim.notify("Failed to clean temporary compilation directory", vim.log.levels.ERROR)
        end
    else
        vim.notify("Temporary compilation directory does not exist", vim.log.levels.WARN)
    end
end, { noremap = true, silent = true, desc = "cleanCppTemp" })

-- Python runner
vim.keymap.set("n", "<leader>rp", function()
    local filename = vim.fn.expand("%:p"):gsub("\\", "/")
    vim.cmd("w")
    vim.cmd(string.format(':split | :term nu -c "python \\"%s\\""', filename))
end, { noremap = true, silent = true, desc = "runPython" })

-- Rust runner
vim.keymap.set("n", "<leader>rr", function()
    local filepath = vim.fn.expand("%:p:h"):gsub("\\", "/")
    vim.cmd("w")
    vim.cmd(string.format(':split | :term nu -c "cargo run --manifest-path \\"%s/Cargo.toml\\""', filepath))
end, { noremap = true, silent = true, desc = "runRust (cargo)" })

-- Set current buffer's directory as pwd
vim.keymap.set("n", "<leader>fd", function()
    vim.cmd("lcd %:p:h")
end, { noremap = true, silent = true, desc = "setCurrentAsPwd" })
