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
        { name = "luasnip" }, -- 确保 Snippet 的显示优先级
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
        ghost_text = false, -- 禁用 ghost text
      },
    }
  end,
}
