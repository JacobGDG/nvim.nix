local M = {}

local get_buffer_absolute = function()
  return vim.fn.expand('%:p')
end

local get_buffer_cwd_relative = function()
  return vim.fn.expand('%:.')
end

M.yank_buffer_absolute = function(register)
  vim.fn.setreg(register, get_buffer_absolute())
end

M.yank_buffer_cwd_relative = function(register)
  vim.fn.setreg(register, get_buffer_cwd_relative())
end
return M
