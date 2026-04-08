require('oil').setup {
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name)
      return name == '..'
    end,
  },

  use_default_keymaps = false,
  keymaps = {
    ['g?'] = 'actions.show_help',
    ['<CR>'] = 'actions.select',
    ['<leader>v'] = { 'actions.select', opts = { vertical = true } },
    ['-'] = 'actions.parent',
    ['~'] = 'actions.open_cwd',
    ['g.'] = 'actions.toggle_hidden',
    ['<leader>l'] = 'actions.refresh',
    ['cd'] = {
      desc = 'CD into this directory in TMUX pane 2',
      callback = function()
        local dir = require('oil').get_current_dir()
        io.popen(string.format('tmux send-keys -t :.$(tmux-other-pane) "cd %s" Enter', dir))
        io.popen('tmux select-pane -t :.$(tmux-other-pane)')
      end,
    },
  },
}

require('me.keymap').map('n', '-', '<CMD>Oil<CR>', { desc = 'Open Oil' })
