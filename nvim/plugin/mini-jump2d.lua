require('mini.jump2d').setup {
  mappings = {},
}
local map = require('me.keymap').map

map(
  { 'n' },
  '<CR>',
  '<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>',
  { desc = '[jump2d] single character' }
)
