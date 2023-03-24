return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use { 'catppuccin/nvim', as = 'catppuccin' }
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use 'neovim/nvim-lspconfig'
	use 'edkolev/tmuxline.vim'
	use 'nvim-zh/better-escape.vim'
	use 'tpope/vim-commentary'
	use 'nvim-tree/nvim-tree.lua'
	use 'nvim-tree/nvim-web-devicons'
    use 'hrsh7th/nvim-cmp'
    use 'tpope/vim-surround'
    use 'mattn/emmet-vim'
end)
