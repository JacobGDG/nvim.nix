local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local map = require('me.keymap').map

autocmd('LspAttach', {
  group = augroup('UserLspConfig', {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Attach plugins
    -- require('nvim-navic').attach(client, bufnr)

    vim.cmd.setlocal('signcolumn=yes')
    vim.bo[bufnr].bufhidden = 'hide'

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- [g]o to keymaps
    map('n', 'gD', vim.lsp.buf.declaration, { desc = 'lsp [g]o to [D]eclaration', buffer = bufnr })
    map('n', 'gd', vim.lsp.buf.definition, { desc = 'lsp [g]o to [d]efinition', buffer = bufnr })
    map('n', 'gt', vim.lsp.buf.type_definition, { desc = 'lsp [g]o to [t]ype definition', buffer = bufnr })
    map('n', 'gi', vim.lsp.buf.implementation, { desc = 'lsp [g]o to [i]mplementation', buffer = bufnr })
    map('n', 'gr', vim.lsp.buf.references, { desc = 'lsp [g]et [r]eferences', buffer = bufnr })

    map('n', 'K', vim.lsp.buf.hover, { desc = '[lsp] hover', buffer = bufnr })

    map('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'lsp [r]e[n]ame', buffer = bufnr })
    map('n', '<M-CR>', vim.lsp.buf.code_action, { desc = '[lsp] code action', buffer = bufnr })
    -- localmap('n', '<M-l>', vim.lsp.codelens.run, { desc = '[lsp] run code lens', buffer = bufnr })
    -- localmap('n', '<leader>cr', vim.lsp.codelens.refresh, { desc = 'lsp [c]ode lenses [r]efresh', buffer = bufnr })
    if client and client.server_capabilities.inlayHintProvider then
      map('n', '<leader>h', function()
        local current_setting = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
        vim.lsp.inlay_hint.enable(not current_setting, { bufnr = bufnr })
      end, { desc = '[lsp] toggle inlay hints', buffer = bufnr })
    end

    -- Auto-refresh code lenses
    if not client then
      return
    end
    local group = augroup(string.format('lsp-%s-%s', bufnr, client.id), {})
    if client.server_capabilities.codeLensProvider then
      autocmd({ 'InsertLeave', 'BufWritePost', 'TextChanged' }, {
        group = group,
        callback = function()
          vim.lsp.codelens.refresh { bufnr = bufnr }
        end,
        buffer = bufnr,
      })
      vim.lsp.codelens.refresh { bufnr = bufnr }
    end
  end,
})
