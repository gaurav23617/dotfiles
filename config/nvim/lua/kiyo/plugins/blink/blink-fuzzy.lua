return {
  "saghen/blink.cmp",
  opts = {
    fuzzy = {
      sorts = {
        -- Prioritize Copilot completions first
        function(a, b)
          if a.source_name == "Copilot" then
            return true -- Copilot first
          elseif b.source_name == "Copilot" then
            return false
          end

          -- Ensure Emmet LS is given priority where needed
          if a.client_name == nil or b.client_name == nil then
            return
          end
          return b.client_name == "emmet_ls"
        end,
        -- Default sorts
        "score",
        "sort_text",
      },
    },
  },
}
