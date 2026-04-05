vim.g.gruvbox_material_enable_italic = true
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd.colorscheme('gruvbox-material')
  end,
})
