-- Example of disabling some plugins. Add yours
local disabled = {
  {
    "akinsho/bufferline.nvim",
  },
}

for i, plugin in ipairs(disabled) do
  plugin.enabled = false
end

return disabled
