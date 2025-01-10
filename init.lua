vim.opt.fileformats = {'unix', 'dos'} 

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.diffopt:append('vertical')

vim.api.nvim_create_autocmd(
  'FileType',
  {
    pattern = {'python'},
    callback = function()
      vim.opt.colorcolumn = '120'
      vim.opt.textwidth = 118
    end
  }
)
vim.api.nvim_create_autocmd(
  'FileType',
  {
    pattern = {'css,json,yaml,lua'},
    callback = function()
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
    end
  }
)

vim.keymap.set('t', '<A-c>', '<C-\\><C-n>')
vim.keymap.set('n', '<Leader>ts', ':vsplit term://$SHELL<Enter>')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'tanvirtin/monokai.nvim',
    lazy = false,
    priority = 1000,
    config = function() vim.cmd('colorscheme monokai') end,
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          section_separators = '',
          component_separators = '',
        },
        tabline = {
          lualine_a = {'filename'},
          lualine_b = {'buffers'},
          lualine_c = {'branch'},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {'tabs'},
        }
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    ft = { 'lua', 'vim', 'python', 'toml' },
    config = function () 
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "python", 'toml' },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },  
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require('mylspconfig').setup()
    end,
    ft = { 'python', 'sh' },
  },
  {
    "nicolas-yangli/nvim-git-blame",
    build = ":UpdateRemotePlugins",
  },
  {
    "hrsh7th/nvim-cmp",
    ft = { 'python', },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function ()
      require('mycmpconfig').setup()
    end,
  },
  {
    "mmarchini/bpftrace.vim",
    event = { 'BufEnter *.bt' },
  }
})
