local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local localmap = require('me.keymap').localmap

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
    localmap('n', 'gD', vim.lsp.buf.declaration, { desc = 'lsp [g]o to [D]eclaration' }, bufnr)
    localmap('n', 'gd', vim.lsp.buf.definition, { desc = 'lsp [g]o to [d]efinition' }, bufnr)
    localmap('n', 'gt', vim.lsp.buf.type_definition, { desc = 'lsp [g]o to [t]ype definition' }, bufnr)
    localmap('n', 'gi', vim.lsp.buf.implementation, { desc = 'lsp [g]o to [i]mplementation' }, bufnr)
    localmap('n', 'gr', vim.lsp.buf.references, { desc = 'lsp [g]et [r]eferences' }, bufnr)

    localmap('n', 'K', vim.lsp.buf.hover, { desc = '[lsp] hover' }, bufnr)

    localmap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'lsp [r]e[n]ame' }, bufnr)
    localmap('n', '<M-CR>', vim.lsp.buf.code_action, { desc = '[lsp] code action' }, bufnr)
    -- localmap('n', '<M-l>', vim.lsp.codelens.run, { desc = '[lsp] run code lens' }, bufnr)
    -- localmap('n', '<leader>cr', vim.lsp.codelens.refresh, { desc = 'lsp [c]ode lenses [r]efresh' }, bufnr)
    localmap('n', '<leader>F', function()

      vim.lsp.buf.format { async = true }
    end, { desc = '[lsp] [f]ormat buffer' }, bufnr)
    if client and client.server_capabilities.inlayHintProvider then
      localmap('n', '<leader>h', function()
        local current_setting = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
        vim.lsp.inlay_hint.enable(not current_setting, { bufnr = bufnr })
      end, { desc = '[lsp] toggle inlay hints' }, bufnr)
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
