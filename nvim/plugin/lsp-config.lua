local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local map = require('me.keymap').map

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
vim.lsp.enable('lua_ls')
vim.lsp.enable('nil_ls') -- nix
vim.lsp.enable('terraformls')
vim.lsp.enable('ruby_lsp')

local function prefix_diagnostic(prefix, diagnostic)
  return string.format(prefix .. ' %s', diagnostic.message)
end
vim.diagnostic.config {
  virtual_text = {
    prefix = '',
    format = function(diagnostic)
      local severity = diagnostic.severity
      if severity == vim.diagnostic.severity.ERROR then
        return prefix_diagnostic('󰅚', diagnostic)
      end
      if severity == vim.diagnostic.severity.WARN then
        return prefix_diagnostic('⚠', diagnostic)
      end
      if severity == vim.diagnostic.severity.INFO then
        return prefix_diagnostic('ⓘ', diagnostic)
      end
      if severity == vim.diagnostic.severity.HINT then
        return prefix_diagnostic('󰌶', diagnostic)
      end
      return prefix_diagnostic('■', diagnostic)
    end,
  },
  signs = {
    text = {
      -- Requires Nerd fonts
      [vim.diagnostic.severity.ERROR] = '󰅚',
      [vim.diagnostic.severity.WARN] = '⚠',
      [vim.diagnostic.severity.INFO] = 'ⓘ',
      [vim.diagnostic.severity.HINT] = '󰌶',
    },
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'if_many',
    header = '',
    prefix = '',
  },
}

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
    map('n', 'gD', vim.lsp.buf.declaration, { desc = 'lsp [g]o to [D]eclaration' })
    map('n', 'gd', vim.lsp.buf.definition, { desc = 'lsp [g]o to [d]efinition' })
    map('n', '<leader>gt', vim.lsp.buf.type_definition, { desc = 'lsp [g]o to [t]ype definition' })
    map('n', 'K', vim.lsp.buf.hover, { desc = '[lsp] hover' })
    map('n', 'gi', vim.lsp.buf.implementation, { desc = 'lsp [g]o to [i]mplementation' })
    map('n', '<C-k>', vim.lsp.buf.signature_help, { desc = '[lsp] signature help' })
    map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'lsp add [w]orksp[a]ce folder' })
    map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'lsp [w]orkspace folder [r]emove' })
    map('n', '<leader>wl', function()
      vim.print(vim.lsp.buf.list_workspace_folders())
    end, { desc = '[lsp] [w]orkspace folders [l]ist' })
    map('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'lsp [r]e[n]ame' })
    map('n', '<leader>wq', vim.lsp.buf.workspace_symbol, { desc = 'lsp [w]orkspace symbol [q]' })
    map('n', '<leader>dd', vim.lsp.buf.document_symbol, { desc = 'lsp [dd]ocument symbol' })
    map('n', '<M-CR>', vim.lsp.buf.code_action, { desc = '[lsp] code action' })
    map('n', '<M-l>', vim.lsp.codelens.run, { desc = '[lsp] run code lens' })
    map('n', '<leader>cr', vim.lsp.codelens.refresh, { desc = 'lsp [c]ode lenses [r]efresh' })
    map('n', 'gr', vim.lsp.buf.references, { desc = 'lsp [g]et [r]eferences' })
    map('n', '<leader>F', function()
      vim.lsp.buf.format { async = true }
    end, { desc = '[lsp] [f]ormat buffer' })
    if client and client.server_capabilities.inlayHintProvider then
      map('n', '<leader>h', function()
        local current_setting = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
        vim.lsp.inlay_hint.enable(not current_setting, { bufnr = bufnr })
      end, { desc = '[lsp] toggle inlay hints' })
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
