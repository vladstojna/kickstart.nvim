local dap_ui = require 'dap-view'

local ui_data = {
  win = nil,
  tab = nil,
  came_from_tab = nil,
}

--- Open DAP UI in new tab
---@param opts? any
local function open_in_tab(opts)
  if ui_data.win and vim.api.nvim_win_is_valid(ui_data.win) then
    vim.api.nvim_set_current_win(ui_data.win)
    return
  end

  local curr_win = vim.api.nvim_get_current_win()
  ui_data.came_from_tab = vim.api.nvim_win_get_tabpage(curr_win)

  vim.cmd 'tabedit %'
  ui_data.win = vim.fn.win_getid()
  ui_data.tab = vim.api.nvim_win_get_tabpage(ui_data.win)

  vim.api.nvim_win_set_cursor(ui_data.win, vim.api.nvim_win_get_cursor(curr_win))

  dap_ui.open(opts)
end

--- Close DAP UI tab
---@param opts? any
local function close_tab(opts)
  dap_ui.close(opts)

  if ui_data.came_from_tab and vim.api.nvim_tabpage_is_valid(ui_data.came_from_tab) then vim.api.nvim_set_current_tabpage(ui_data.came_from_tab) end
  if ui_data.tab and vim.api.nvim_tabpage_is_valid(ui_data.tab) then vim.cmd { cmd = 'tabclose', args = { vim.api.nvim_tabpage_get_number(ui_data.tab) } } end

  ui_data.win = nil
  ui_data.tab = nil
  ui_data.came_from_tab = nil
end

--- Toggle DAP UI Tab
---@param opts? any
local function toggle_tab(opts)
  if ui_data.tab and vim.api.nvim_get_current_tabpage() == ui_data.tab then
    close_tab(opts)
  else
    open_in_tab(opts)
  end
end

local M = {}

M.open = open_in_tab
M.close = close_tab
M.toggle = toggle_tab

return M
