return {
  "hrsh7th/nvim-cmp",
  enabled = true,
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",  -- Add this line
  },
  opts = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")  -- Import luasnip
    return {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)  -- Use luasnip's expansion function
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<Enter>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
      },
      window = {
        completion = cmp.config.window.bordered({
          max_width = 50,
        }),
        documentation = cmp.config.window.bordered({
          max_width = 60,
        }),
      },
      formatting = {
        fields = { "abbr", "kind" },
        format = function(entry, vim_item)
          local max_width = 40
          local label = vim_item.abbr
          if #label > max_width then
            vim_item.abbr = label:sub(1, max_width - 3) .. "..."
          end
          return vim_item
        end,
      },
      experimental = {
        ghost_text = false, -- disable ghost
      },
    }
  end,
}
