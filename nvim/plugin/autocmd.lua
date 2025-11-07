local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local my_group = augroup('Mine', {})

autocmd('TextYankPost', {
  group = my_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 1000,
    }
  end,
})

autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
  group = my_group,
  pattern = '*',
  command = 'set relativenumber',
})
autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
  group = my_group,
  pattern = '*',
  command = 'set norelativenumber',
})

autocmd({ 'VimResized' }, {
  group = my_group,
  command = 'wincmd =',
})
