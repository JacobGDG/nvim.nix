if vim.g.did_load_neogit_plugin then
  return
end
vim.g.did_load_neogit_plugin = true

local neogit = require('neogit')

neogit.setup {
  disable_builtin_notifications = true,
  disable_insert_on_commit = 'auto',
  integrations = {
    diffview = true,
    telescope = true,
    fzf_lua = true,
  },
  sections = {
    ---@diagnostic disable-next-line: missing-fields
    recent = {
      folded = false,
    },
  },
}

local map = require('me.keymap').map
map('n', '<leader>go', neogit.open, { desc = 'neo[g]it [o]pen' })
map('n', '<leader>gs', function()
  neogit.open { kind = 'auto' }
end, { desc = 'neo[g]it open [s]plit' })
map('n', '<leader>gc', function()
  neogit.open { 'commit' }
end, { desc = 'neo[g]it [c]ommit' })
