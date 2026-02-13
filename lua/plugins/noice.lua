-- 禁用 LazyVim 弹出式命令行和错误通知
return {
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
      -- disable command line enhancements
      cmdline = {
        enabled = false,
      },
      -- disable message system
      messages = {
        enabled = false,
      },
      -- disable popup menu
      popupmenu = {
        enabled = false,
      },
      -- disable notifications
      notify = {
        enabled = false,
      },
      lsp = {
        -- disable LSP progress
        progress = {
          enabled = false,
        },
        -- keep hover documentation (optional)
        hover = {
          enabled = true,
        },
        -- keep function signature help (optional)
        signature = {
          enabled = true,
        },
        -- LSP messages
        message = {
          enabled = false,
        },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    enabled = false,
  },
}