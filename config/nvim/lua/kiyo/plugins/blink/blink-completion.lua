return {
  "saghen/blink.cmp",
  opts = {
    completion = {

      list = {
        selection = {
          preselect = function(ctx)
            return not require("blink.cmp").snippet_active({ direction = 1 })
          end,
          auto_insert = function(ctx)
            return vim.bo.filetype ~= "markdown"
          end,
        },
      },

      accept = {
        create_undo_point = true,
        resolve_timeout_ms = 500,
        auto_brackets = {
          enabled = true,
          default_brackets = { "(", ")" },
          override_brackets_for_filetypes = {},
          kind_resolution = {
            enabled = true,
            blocked_filetypes = { "typescriptreact", "javascriptreact", "vue" },
          },
          semantic_token_resolution = {
            enabled = true,
            blocked_filetypes = { "java" },
            timeout_ms = 400,
          },
        },
      },

      documentation = {
        window = {
          border = nil,
          scrollbar = false,
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
        },
        auto_show = true,
        auto_show_delay_ms = 500,
      },

      menu = {
        auto_show = true,
        draw = {
          treesitter = {
            "lsp",
          },
          columns = {
            -- { "label", "label_detail", "label_description", gap = 1 },
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind" },
            { "source_name" },
          },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                return ctx.kind_icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                return ctx.kind_hl
              end,
            },

            kind = {
              ellipsis = false,
              width = { fill = true },
              text = function(ctx)
                return ctx.kind
              end,
              highlight = function(ctx)
                return ctx.kind_hl
              end,
            },

            label = {
              width = { fill = true, max = 60 },
              text = function(ctx)
                return ctx.label .. ctx.label_detail
              end,
              highlight = function(ctx)
                -- label and label details
                local highlights = {
                  {
                    0,
                    #ctx.label,
                    group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
                  },
                }
                if ctx.label_detail then
                  table.insert(highlights, {
                    #ctx.label,
                    #ctx.label + #ctx.label_detail,
                    group = "BlinkCmpLabelDetail",
                  })
                end

                -- characters matched on the label by the fuzzy matcher
                for _, idx in ipairs(ctx.label_matched_indices) do
                  table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                end

                return highlights
              end,
            },

            label_description = {
              width = { max = 30 },
              text = function(ctx)
                return ctx.label_description
              end,
              highlight = "BlinkCmpLabelDescription",
            },

            source_name = {
              width = { max = 30 },
              text = function(ctx)
                return ctx.source_name
              end,
              highlight = "BlinkCmpSource",
            },

            source_id = {
              width = { max = 30 },
              text = function(ctx)
                return ctx.source_id
              end,
              highlight = "BlinkCmpSource",
            },
          },
        },
      },

      ghost_text = {
        enabled = true,
        show_with_selection = true,
      },
    },
  },
}
