call plug#begin()

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

call plug#end()

set relativenumber
lua << EOF
require'lspconfig'.tsserver.setup{}

require('nvim-treesitter.configs').setup {
  -- one of "all", "maintained" (parsers with maintainers),
  -- or a list of languages
  ensure_installed = { "javascript", "typescript", "lua", "python", "comment" },
}

require('catppuccin').setup({
	flavour = "frappe",
})
vim.cmd.colorscheme "catppuccin"
EOF

hi! Normal ctermbg=NONE guibg=NONE
