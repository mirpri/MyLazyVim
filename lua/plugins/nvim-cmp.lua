return {
  "hrsh7th/nvim-cmp",
  enabled = true,
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
  },
  opts = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip") -- 确保 LuaSnip 被正确导入
    return {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- 使用 LuaSnip 的扩展功能
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
        { name = "luasnip" },
        {
          name = "nvim_lsp",
          entry_filter = function(entry, ctx)
            local completion_item = entry.completion_item
            -- 如果补全项有额外的文本编辑（通常是自动添加include），则过滤掉
            if completion_item.additionalTextEdits and #completion_item.additionalTextEdits > 0 then
              return false
            end
            return true
          end,
        },
        { name = "buffer" },
        { name = "path" },
      },
      formatting = {
        fields = { "kind", "abbr"},
      },
      experimental = {
        ghost_text = false, -- 禁用 ghost text
      },
      window = {
        completion = {
          scrollbar = true,
          max_height = 10,
          max_width = 20,
          winblend = 0,
        },
        documentation = {
          max_width = 20,
          winblend = 0,
        },
      },
    }
  end,
}
