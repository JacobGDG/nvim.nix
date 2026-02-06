local fzf_lua = require('fzf-lua')
local map = require('me.keymap').map

fzf_lua.setup {
  winopts = {
    on_create = function()
      vim.keymap.set('t', '<C-r>', [['<C-\><C-N>"'.nr2char(getchar()).'pi']], { expr = true, buffer = true })
    end,
  },
}

fzf_lua.register_ui_select() -- vim.ui.select

map('n', '<leader>f', function()
  fzf_lua.builtin()
end, { desc = 'Find finder' })
map('n', '<leader>o', function()
  fzf_lua.files()
end, { desc = 'Find file' })
map('n', '<leader>g', function()
  fzf_lua.live_grep()
end, { desc = 'Find string' })
map('n', '<leader>b', function()
  fzf_lua.buffers()
end, { desc = 'Find buffer' })
map('n', 'z=', function()
  fzf_lua.spell_suggest()
end, { desc = 'Fix spelling' })
map('n', '<leader>r', function()
  fzf_lua.registers()
end, { desc = 'Find register' })
