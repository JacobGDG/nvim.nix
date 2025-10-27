require('snacks').setup {
  indent = {
    enabled = true,
  },
  gitbrowse = {
    enabled = true,
    what = 'file',
    branch = 'HEAD'
  },
  zen = {
    enabled = true,
    toggles = {
      dim = false,
    }
  },
  dim = { },
  input = {
    enable = true
  },
}

vim.g.snacks_animate = false -- never animate

local map = require('me.keymap').map
map('n', '<leader>w', function() require('snacks').gitbrowse.open() end, { desc = 'Open gitbrowse, ie open web', } )
map('n', '<leader>z',  function() require('snacks').zen() end, { desc = 'Toggle Zen Mode' } )
map('n', '<leader>Z',  function() require('snacks').zen.zoom() end, { desc = 'Toggle Zoom' } )
