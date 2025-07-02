local M = {}

function M.setup()
  lspconfig = require('lspconfig')

  lspconfig.pyright.setup({})
  lspconfig.bashls.setup({})

  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'grd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', '<C-q>', vim.lsp.buf.hover, opts)
      --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      --vim.keymap.set('n', '<space>wl', function()
      --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      --end, opts)
      vim.keymap.set('n', '<Leader>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
      vim.keymap.set('n', '<Leader>ld', vim.diagnostic.open_float, opts)
      -- vim.keymap.del('i', vim.lsp.buf.signature_help)
      vim.keymap.set({ 'n', 'v', 'i' }, '<C-k>', vim.lsp.buf.signature_help, opts)
      -- default keymaps
      -- n  grn:    vim.lsp.rename
      -- n  gri:    vim.lsp.buf.implementation
      -- n  gO:     vim.lsp.buf.document_symbol
      -- n  grr:    vim.lsp.buf.references
      -- nv gra:    vim.lsp.buf.code_action
    end
  })
end

return M
