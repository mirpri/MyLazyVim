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
  {
    "folke/noice.nvim",
    opts = {
      views = {  
        hover = {  
          size = {  
            max_width = 40,    -- Maximum width in columns  
            max_height = 10,   -- Maximum height in lines  
            width = "auto",    -- Can also be a fixed number  
            height = "auto",   -- Can also be a fixed number  
          },  
        },  
      },
    },
  },
}
