-- Init.lua

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

-- Plugin management
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'windwp/nvim-autopairs'
  use 'jose-elias-alvarez/null-ls.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
end)

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Remove termguicolors to ensure compatibility with all terminals
-- vim.opt.termguicolors = true

-- Explicitly enable syntax highlighting
vim.cmd [[
  syntax enable
  filetype plugin indent on
]]

-- Set background (uncomment one of these if you want to force a specific background)
-- vim.opt.background = "dark"
-- vim.opt.background = "light"

-- Key mappings
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':split | terminal<CR>', { noremap = true })

-- LSP setup
local lspconfig = require('lspconfig')
local servers = { 'pyright', 'clangd', 'tsserver', 'html', 'cssls' }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {}
end

-- Completion setup
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }),
})

-- Autopairs setup
require('nvim-autopairs').setup {}

-- Null-ls for formatting
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,
  },
})

-- Format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- NvimTree setup
require('nvim-tree').setup {
  renderer = {
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
}

-- Telescope setup
require('telescope').setup {}

-- Treesitter setup
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "python", "cpp", "c", "lua", "vim", "javascript", "typescript", 
    "html", "css", "json", "markdown", "tsx"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,  -- Enable this for better highlighting in limited color terminals
  },
  indent = { enable = true },
}

-- Helper function to check if Treesitter highlighting is active
local function is_treesitter_active()
  local parsers = require('nvim-treesitter.parsers')
  local lang = parsers.get_buf_lang()
  return parsers.has_parser(lang)
end

-- Fallback to Vim's syntax highlighting if Treesitter is not active
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if not is_treesitter_active() then
      vim.cmd("syntax on")
    end
  end
})

-- Debug information (you can comment this out after confirming it works)
vim.api.nvim_create_user_command("HighlightInfo", function()
  print("Treesitter active: " .. tostring(is_treesitter_active()))
  print("Syntax enabled: " .. tostring(vim.fn.exists("syntax_on") == 1))
end, {})