local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' --packer manage itself
  

  --completion
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  -- cmp sources 
  use 'saadparwaiz1/cmp_luasnip' 
  use 'hrsh7th/cmp-buffer'  
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lua'


  -- lsp for nvim config 
  --use "folke/neodev.nvim"

  -- colorchemes  
  --use 'morhetz/gruvbox'
  use 'neanias/everforest-nvim'
  --use { "catppuccin/nvim", as = "catppuccin" }
  --use "rebelot/kanagawa.nvim"
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  --
  use 'lervag/vimtex'

  use 'nvim-treesitter/nvim-treesitter'
  use 'p00f/nvim-ts-rainbow'


  if packer_bootstrap then
    require('packer').sync()
  end
end)

