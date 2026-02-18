local map = require('me.keymap').map

require('codecompanion').setup {
  interactions = {
    chat = {
      adapter = 'openai',
    },
    inline = {
      adapter = 'openai',
    },
    cmd = {
      adapter = 'openai',
    },
  },
  opts = {
    log_level = 'DEBUG',
  },
}

map({ 'v' }, '<leader><leader>a', ":<C-U>'<,'>CodeCompanion<CR>", { desc = 'AI Inline Actions' })
map({ 'n', 'v' }, '<leader>a', '<CMD>CodeCompanionChat Toggle<CR>', { desc = 'AI Chat' })

vim.cmd([[cab cc CodeCompanion]])
