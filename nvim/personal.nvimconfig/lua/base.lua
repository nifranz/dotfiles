vim.cmd('set nowrap')
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Relative Line Number
vim.wo.relativenumber = true
vim.cmd('set nu rnu')

vim.opt.title = true

-- indentation configuration
vim.opt.autoindent = true
vim.cmd('set tabstop=4')
vim.cmd('set softtabstop=4')
vim.cmd('set shiftwidth=4')
vim.cmd('set expandtab')

-- Plugin Configurations
require('lualine').setup()
require('lspconfig').tsserver.setup {}
require('lspconfig').pyright.setup {}

-- Emmet Abbreviation Configuration
vim.cmd('let g:user_emmet_install_global = 0')
vim.cmd("let g:user_emmet_leader_key='<C-Z>'")
vim.cmd('autocmd FileType html,css EmmetInstall')
