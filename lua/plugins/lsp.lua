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
        -- add others as needed
        lua_ls = { enabled = false },
      },
    },
  },
}