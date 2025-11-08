local M = {}

M.map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end

  vim.keymap.set(mode, lhs, rhs, options)
end

M.cabbrev = function(from, to)
  vim.cmd(string.format('cabbrev %s %s', from, to))
end

return M
