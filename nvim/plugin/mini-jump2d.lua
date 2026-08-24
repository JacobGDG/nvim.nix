require('mini.jump2d').setup { mappings = {} }
local map = require('me.keymap').map

map({ 'n' }, '<CR>', function()
  vim.api.nvim_echo({ { '2djump> ', 'ModeMsg' } }, false, {})
  local char = vim.fn.getcharstr()
  if char == '\27' or char == '\r' then
    vim.api.nvim_echo({}, false, {})
    return
  end
  MiniJump2d.start({
    allowed_lines = { blank = false, fold = false },
    spotter = MiniJump2d.gen_spotter.pattern('%f[%a%d_]' .. vim.pesc(char)),
  })
end, { desc = '[jump2d] to word start from char' })
