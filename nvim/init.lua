-- init.lua

-- Packer.nvim
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local fresh_install = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  fresh_install = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd([[
  augroup PackerUserConfig
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use { 'ishan9299/nvim-solarized-lua' }
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
  use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup{} end }
  use 'jose-elias-alvarez/null-ls.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = function() require('nvim-treesitter.install').update({ with_sync = true }) end }
  use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
  use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end }
  use {
    'folke/which-key.nvim',
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require('which-key').setup({})
    end
  }

  if fresh_install then require('packer').sync() end
end)

-- Neovim Settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.scrolloff = 8
vim.opt.updatetime = 250
vim.opt.mouse = "a"
vim.opt.fillchars = { eob = ' ' }

vim.g.mapleader = ' '

vim.cmd [[ syntax enable | filetype plugin indent on ]]

-- Transparency Settings
vim.cmd [[
  augroup TransparentNvim
    autocmd!
    autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight NormalNC guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight NonText guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight EndOfBuffer guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight SignColumn guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight LineNr guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight CursorLineNr guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight FoldColumn guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight Pmenu guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight PmenuSel guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight PmenuSbar guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight PmenuThumb guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight NvimTreeNormal guibg=NONE ctermbg=NONE 
  augroup END
]]
vim.cmd("doautocmd ColorScheme")


-- Key Mappings
local keymap_set = vim.keymap.set

keymap_set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Explorer: Toggle" })
keymap_set('n', '<leader>ff', ':Telescope find_files<CR>', { desc = "Find: Files" })
keymap_set('n', '<leader>fg', ':Telescope live_grep<CR>', { desc = "Find: Live Grep" })
keymap_set('n', '<leader>fb', ':Telescope buffers<CR>', { desc = "Find: Buffers" })
keymap_set('n', '<leader>fh', ':Telescope help_tags<CR>', { desc = "Find: Help Tags" })
keymap_set('n', '<leader>t', ':split | terminal<CR>', { desc = "Terminal: Horizontal Split" })
keymap_set('n', '<leader>vt', ':vsplit | terminal<CR>', { desc = "Terminal: Vertical Split" })
keymap_set('n', '<C-h>', '<C-w>h', { desc = "Window: Focus Left", silent = true })
keymap_set('n', '<C-j>', '<C-w>j', { desc = "Window: Focus Down", silent = true })
keymap_set('n', '<C-k>', '<C-w>k', { desc = "Window: Focus Up", silent = true })
keymap_set('n', '<C-l>', '<C-w>l', { desc = "Window: Focus Right", silent = true })
keymap_set('n', '<C-S-c>', ':close<CR>', { desc = "Window: Close Current", silent = true })
keymap_set('n', '<C-Tab>', ':bnext<CR>', { desc = "Buffer: Next", silent = true })
keymap_set('n', '<C-S-Tab>', ':bprevious<CR>', { desc = "Buffer: Previous", silent = true })
keymap_set({'n', 'v'}, '<leader>/', '<Plug>(comment_toggle_linewise_current)', { desc = "Comment: Toggle Line" })

-- LSP
local lspconfig = require('lspconfig')
local servers = { 'pyright', 'clangd', 'ts_ls', 'html', 'cssls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities()
  }
end

-- nvim-cmp
local cmp = require('cmp')
cmp.setup({
  snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.select_prev_item(), ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(), ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'luasnip' } }, { { name = 'buffer' } }),
})

-- null-ls
local null_ls = require('null-ls')
null_ls.setup({
  sources = { null_ls.builtins.formatting.prettier },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, { clear = true }),
        buffer = bufnr,
        callback = function() vim.lsp.buf.format({ bufnr = bufnr, async = true }) end,
      })
    end
  end,
})

-- nvim-tree
require('nvim-tree').setup {
  renderer = { icons = { show = { file = true, folder = true, folder_arrow = true, git = true } } },
}

-- Telescope
require('telescope').setup {
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = { horizontal = { prompt_position = 'top', preview_width = 0.55 } },
  },
}

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "python", "cpp", "c", "lua", "vim", "javascript", "typescript", "tsx",
    "html", "css", "json", "markdown", "go", "rust", "bash"
  },
  sync_install = false, auto_install = true,
  highlight = { enable = true, additional_vim_regex_highlighting = true },
  indent = { enable = true },
}
