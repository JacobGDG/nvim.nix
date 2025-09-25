if vim.g.did_load_gitsigns_plugin then
  return
end
vim.g.did_load_gitsigns_plugin = true

local map = require('me.keymap').map
local function localmap(mode, l, r, opts)
  opts = opts or {}
  opts.buffer = bufnr
  map(mode, l, r, opts)
end

vim.schedule(function()
  require('gitsigns').setup {
    current_line_blame = false,
    current_line_blame_opts = {
      ignore_whitespace = true,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local opts = { buffer = bufnr }

      localmap('n', '<leader>hb', function()
        gs.blame_line { full = true }
      end, { desc = 'git [h] [b]lame line (full)' })
      localmap('n', '<leader>lb', gs.toggle_current_line_blame, { desc = '[g]it toggle current [l]ine [b]lame' })
      localmap('n', '<leader>hd', gs.diffthis, { desc = 'git [h] [d]iff this' })
    end,
  }
end)
