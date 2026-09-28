local map = require('me.keymap').map

require('fzf-lua').setup {
  winopts = {
    on_create = function()
      vim.keymap.set('t', '<C-r>', [['<C-\><C-N>"'.nr2char(getchar()).'pi']], { expr = true, buffer = true })
    end,
  },
}

require('fzf-lua').register_ui_select() -- vim.ui.select

map('n', '<leader>f', function()
  require('fzf-lua').builtin()
end, { desc = 'Find finder' })
map('n', '<leader>o', function()
  require('fzf-lua').files()
end, { desc = 'Find file' })
map('n', '<leader>g', function()
  require('fzf-lua').live_grep()
end, { desc = 'Find string' })
map('n', '<leader>b', function()
  require('fzf-lua').buffers()
end, { desc = 'Find buffer' })
map('n', 'z=', function()
  require('fzf-lua').spell_suggest()
end, { desc = 'Fix spelling' })
map('n', '<leader>r', function()
  require('fzf-lua').registers()
end, { desc = 'Find register' })
map('n', '<leader>t', function()
  require('fzf-lua').fzf_exec("rg --files -g '*.tf' | sed 's|/[^/]*$||' | sort -u", {
    prompt = 'Terraform root> ',
    actions = {
      ['default'] = function(selected)
        require('oil').open(selected[1])
      end,
    },
  })
end, { desc = 'Find terraform root' })
