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
    localmap('n', 'gD', vim.lsp.buf.declaration, { desc = 'lsp [g]o to [D]eclaration' }, bufnr)
    localmap('n', 'gd', vim.lsp.buf.definition, { desc = 'lsp [g]o to [d]efinition' }, bufnr)
    -- localmap('n', '<leader>gt', vim.lsp.buf.type_definition, { desc = 'lsp [g]o to [t]ype definition' }, bufnr)
    localmap('n', 'K', vim.lsp.buf.hover, { desc = '[lsp] hover' }, bufnr)
    localmap('n', 'gi', vim.lsp.buf.implementation, { desc = 'lsp [g]o to [i]mplementation' }, bufnr)
    localmap('n', '<C-k>', vim.lsp.buf.signature_help, { desc = '[lsp] signature help' }, bufnr)
    -- localmap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'lsp add [w]orksp[a]ce folder' }, bufnr)
    -- localmap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'lsp [w]orkspace folder [r]emove' }, bufnr)
    -- localmap('n', '<leader>wl', function()
    --   vim.print(vim.lsp.buf.list_workspace_folders())
    -- end, { desc = '[lsp] [w]orkspace folders [l]ist' }, bufnr)
    localmap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'lsp [r]e[n]ame' }, bufnr)
    -- localmap('n', '<leader>wq', vim.lsp.buf.workspace_symbol, { desc = 'lsp [w]orkspace symbol [q]' }, bufnr)
    localmap('n', '<leader>dd', vim.lsp.buf.document_symbol, { desc = 'lsp [dd]ocument symbol' }, bufnr)
    localmap('n', '<M-CR>', vim.lsp.buf.code_action, { desc = '[lsp] code action' }, bufnr)
    localmap('n', '<M-l>', vim.lsp.codelens.run, { desc = '[lsp] run code lens' }, bufnr)
    localmap('n', '<leader>cr', vim.lsp.codelens.refresh, { desc = 'lsp [c]ode lenses [r]efresh' }, bufnr)
    localmap('n', 'gr', vim.lsp.buf.references, { desc = 'lsp [g]et [r]eferences' }, bufnr)
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

