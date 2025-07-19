-- ~/.config/nvim/lua/plugins/lsp.lua
return {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {}, -- C++
        -- add others as needed
      },
    },
  }