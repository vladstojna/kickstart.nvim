--- Checks if layout override exists and returns overriden key
---@param if_not_present table If override value not present use this value as default
---@param module string Module with override table
---@return any
local function override_if_present(if_not_present, module)
  assert(type(if_not_present) ~= table, 'Type to override must be a table')
  local has_override, override = pcall(require, module)
  if not has_override or type(override) ~= type(if_not_present) then
    return if_not_present
  end

  return vim.tbl_extend('force', if_not_present, override)
end

local M = {
  no_neck_pain = {
    width = 120,
  },
  telescope = {
    standard = {
      min_width = 120,
    },
    fullscreen = {
      min_width = 240,
      flex_flip_columns = 200,
    },
  },
  goto_preview = {
    width = 120,
    height = 30,
  },
  oil = {
    float_max_width = 120,
  },
}

return override_if_present(M, 'custom.layout-override')
