-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false
      },
      servers = {
        clangd = {}, -- C++
        pyright = {}, -- Python
        tsserver = {}, -- TypeScript
        -- add others as needed
        lua_ls = { enabled = false },
        rust_analyzer = {}, -- Rust
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = false 
  },

}
