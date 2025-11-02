local map = require('me.keymap').map
local conform = require('conform')

conform.setup {
  lsp_format = 'fallback',
  format_on_save = {
    lsp_format = 'fallback',
    timeout_ms = 500,
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    nix = { 'alejandra' },
    terraform = { 'tofu_fmt', 'terraform_fmt', stop_after_first = true },
    ruby = { 'rubocop' },
  },
}

map('n', '<leader>F', function()
  conform.format { async = true }
end, { desc = '[lsp] [f]ormat buffer' })
