if vim.g.did_load_gitsigns_plugin then
  return
end
vim.g.did_load_gitsigns_plugin = true

local map = require('me.keymap').map

vim.schedule(function()
  require('gitsigns').setup {
    current_line_blame = false,
    current_line_blame_opts = {
      ignore_whitespace = true,
    },
    on_attach = function(bufnr)
      local gitsigns = package.loaded.gitsigns

      map('n', '<leader>hb', function()
        gitsigns.blame_line { full = true }
      end, { desc = 'git [h] [b]lame line (full)', buffer = bufnr })
      map(
        'n',
        '<leader>lb',
        gitsigns.toggle_current_line_blame,
        { desc = 'git toggle current [l]ine [b]lame', buffer = bufnr }
      )
      map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [h] [d]iff this', buffer = bufnr })
    end,
  }
end)
