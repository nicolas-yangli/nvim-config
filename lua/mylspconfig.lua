M = {}

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
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', '<C-q>', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      --vim.keymap.set('n', '<space>wl', function()
      --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      --end, opts)
      vim.keymap.set('n', '<Leader>td', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<Leader>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
      vim.keymap.set('n', '<Leader>ld', vim.diagnostic.open_float, opts)
    end
  })
end

return M
