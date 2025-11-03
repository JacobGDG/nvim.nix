vim.lsp.set_log_level('off')

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
vim.lsp.enable('lua_ls')
vim.lsp.enable('nil_ls') -- nix
vim.lsp.enable('terraformls')
vim.lsp.enable('ruby_lsp')
vim.lsp.enable('yamlls')
vim.lsp.enable('rust_analyzer')
