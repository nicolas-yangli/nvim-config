M = {}

function M.setup()
  local cmp = require'cmp'

  cmp.setup({
--  snippet = {
--    -- REQUIRED - you must specify a snippet engine
--    expand = function(args)
--      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
--      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--    end,
--  },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
--    ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = cmp.mapping(function(fallback)
        -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            cmp.confirm()
          else
            cmp.confirm()
          end
        else
          fallback()
        end
      end, {"i","s",}),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
--    { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })
end

return M
