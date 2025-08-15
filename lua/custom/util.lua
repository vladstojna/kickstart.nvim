local M = {}

local function string_contains_prefix(str, prefix)
  return string.sub(str, 0, #prefix) == prefix
end

M.string_remove_prefix = function(str, prefix)
  return string_contains_prefix(str, prefix) and string.sub(str, #prefix + 1) or str
end

M.copy_active_buffer_path = function(register)
  local current_file = M.string_remove_prefix(vim.fn.getreg '%', vim.fn.getcwd() .. '/')

  vim.fn.setreg(register ~= nil and register or '', current_file)
  vim.notify('Copied ' .. current_file, vim.log.levels.INFO)
end

M.copy_active_buffer_abs_path = function(register)
  local abs_path = vim.fn.getreg '%'

  if string_contains_prefix(abs_path, '/') == false then
    abs_path = vim.fn.getcwd() .. '/' .. vim.fn.getreg '%'
  end

  vim.fn.setreg(register ~= nil and register or '', abs_path)
  vim.notify('Copied ' .. abs_path, vim.log.levels.INFO)
end

-- From: https://github.com/gennaro-tedesco/dotfiles/blob/c1459c3cc97e4d6186decd1fb50b014b54bcfdbe/nvim/lua/utils.lua#L274-L289
M.jumplist2table = function()
  local jumplist, _ = unpack(vim.fn.getjumplist())
  local result = {}
  for _, v in pairs(jumplist) do
    if vim.fn.bufloaded(v.bufnr) == 1 then
      table.insert(result, {
        bufnr = v.bufnr,
        lnum = v.lnum,
        col = v.col,
        text = vim.api.nvim_buf_get_lines(v.bufnr, v.lnum - 1, v.lnum, false)[1],
      })
    end
  end
  return result
end

M.replace_loclist_with_jumplist = function()
  vim.fn.setloclist(0, M.jumplist2table(), 'r')
end

return M
