vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer.nvim
    use 'wbthomason/packer.nvim'

    -- Wakatime/nvim
    use 'wakatime/vim-wakatime'

    -- Icons
    -- use 'ryanoasis/vim-devicons'

    -- Theme
    use 'folke/tokyonight.nvim'

    -- Treesetter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Whichkey
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    -- File tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        }
    }

    -- lsp color
    use 'folke/lsp-colors.nvim'

    -- lsp config
    use 'neovim/nvim-lspconfig'

    -- Autocompletion
    -- Nvim cmp
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- Snippets
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

end)
-- local plug = vim.fn['plug#']

-- vim.call('plug#begin', '~/.config/nvim/plugged')

-- Plug 'ThePrimeagen/vim-be-good'
-- Plug('neoclide/coc.nvim', {branch = 'release'})
-- Plug 'SirVer/ultisnips'
-- Plug 'mlaursen/vim-react-snippets'
-- Plug 'nvim-lua/popup.nvim'
-- Plug 'nvim-lua/plenary.nvim'
-- Plug('nvim-telescope/telescope.nvim')
-- Plug('nvim-treesitter/nvim-treesitter', {
--     ['do'] = function()
--         vim.cmd('call vim_treesitter#TSInstall()')
--     end
-- })
-- Plug('nvim-treesitter/playground')
-- Plug('folke/tokyonight.nvim', {branch = 'main' })
-- Plug('lukas-reineke/indent-blankline.nvim')
-- Plug('tpope/vim-commentary')
-- Plug('maxmellon/vim-jsx-pretty')
-- Plug('suy/vim-context-commentstring')
-- Plug('tpope/vim-fugitive')
-- Plug('preservim/nerdtree')
-- Plug('Xuyuanp/nerdtree-git-plugin')
-- Plug('PhilRunninger/nerdtree-visual-selection')
-- Plug('puremourning/vimspector')
-- Plug('mustache/vim-mustache-handlebars')
-- -- Plug('PhilRunninger/nerdtree-buffer-ops')

-- Plug('github/copilot.vim')

-- Plug('voldikss/vim-floaterm')

-- Plug('folke/which-key.nvim')

-- -- Icon plugin

-- -- Svelte syntax highight
-- Plug('burner/vim-svelte')

-- vim.call('plug#end')
