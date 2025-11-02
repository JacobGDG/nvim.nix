local map = require('me.keymap').map

vim.g.committia_min_window_width = 30
vim.g.committia_edit_window_width = 80
vim.g.committia_hooks = {
  edit_open = function()
    vim.cmd.resize(10)

    map('n', 'q', '<cmd>quit<CR>', { buffer = vim.api.nvim_get_current_buf() })
    map('i', '<C-d>', '<Plug>(committia-scroll-diff-down-half)', { buffer = vim.api.nvim_get_current_buf() })
    map('n', '<C-d>', '<Plug>(committia-scroll-diff-down-half)', { buffer = vim.api.nvim_get_current_buf() })
    map('i', '<C-u>', '<Plug>(committia-scroll-diff-up-half)', { buffer = vim.api.nvim_get_current_buf() })
    map('n', '<C-u>', '<Plug>(committia-scroll-diff-up-half)', { buffer = vim.api.nvim_get_current_buf() })

    vim.cmd('highlight ColorColumn ctermbg=0 guibg=DarkGreen')
    vim.cmd('setlocal spell')

    vim.api.nvim_set_option_value('colorcolumn', '51', {})
  end,
}
