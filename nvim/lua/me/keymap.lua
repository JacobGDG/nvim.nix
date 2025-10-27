local M = {}

M.map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  vim.keymap.set(mode, lhs, rhs, options)
end

M.localmap = function(mode, lhs, rhs, opts, bufnr)
  local options = { buffer = bufnr }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  map(mode, lhs, rhs, options)
end

return M
