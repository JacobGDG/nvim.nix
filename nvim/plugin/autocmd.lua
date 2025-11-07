local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local my_group = augroup('Mine', {})

autocmd('TextYankPost', {
  group = my_group,
  pattern = '*',
  desc = 'Highlight yanked text for clarity',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'Visual',
      timeout = 200,
    }
  end,
})

autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
  group = my_group,
  pattern = '*',
  desc = 'Show relative numbers when in buffer for jumping',
  command = 'set relativenumber',
})
autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
  group = my_group,
  pattern = '*',
  desc = 'Show absolute numbers when not in buffer for referencing',
  command = 'set norelativenumber',
})

autocmd({ 'VimResized' }, {
  group = my_group,
  desc = 'Auto size windows on terminal resize',
  command = 'wincmd =',
})

autocmd('FileType', {
  pattern = 'help',
  desc = 'Open help in veritical window instead of horizontal',
  command = 'wincmd L',
})
