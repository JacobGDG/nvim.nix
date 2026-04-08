local my_group = vim.api.nvim_create_augroup('Plugins', {})
local autocmd = vim.api.nvim_create_autocmd

require('mini.icons').setup()

autocmd('InsertEnter', {
  group = my_group,
  desc = 'Load buffer based plugin',
  once = true,
  callback = function()
    require('luasnip').setup()
    require('luasnip.loaders.from_vscode').lazy_load()
  end,
})
