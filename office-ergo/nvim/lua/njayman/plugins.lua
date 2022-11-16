vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
    -- Packer.nvim
    use("wbthomason/packer.nvim")

    -- Wakatime/nvim
    use("wakatime/vim-wakatime")

    -- tabnine
    use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })

    -- tmux
    use("christoomey/vim-tmux-navigator")

    -- Git
    use("dinhhuy258/git.nvim")
    use("lewis6991/gitsigns.nvim")

    -- Trouble
    -- use 'folke/trouble.nvim'

    -- indent blankline
    use("lukas-reineke/indent-blankline.nvim")

    -- dashboard
    -- use("glepnir/dashboard-nvim")

    -- scrollbar
    use("petertriho/nvim-scrollbar")
    use("kevinhwang91/nvim-hlslens")
    -- Icons
    use("kyazdani42/nvim-web-devicons")

    -- Theme
    -- use 'folke/tokyonight.nvim'
    -- use {
    --     'projekt0n/github-nvim-theme',
    --     config = function()
    --         require('github-theme').setup {
    --             theme_style = "dark"
    --         }
    --     end
    -- }
    use({
        "catppuccin/nvim",
        as = "catppuccin",
    })

    -- -- Zen mode
    -- use {
    --     "folke/zen-mode.nvim",
    --     config = function()
    --         require("zen-mode").setup {
    --             -- your configuration comes here
    --             -- or leave it empty to use the default settings
    --             -- refer to the configuration section below
    --         }
    --     end
    -- }

    -- Treesetter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
    })

    -- Treesetter playground
    use("nvim-treesitter/playground")

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        -- or                            , branch = '0.1.x',
        requires = { { "nvim-lua/plenary.nvim" } },
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    -- Bufferline
    use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })

    -- Scope
    use("tiagovla/scope.nvim")

    -- Whichkey
    use("folke/which-key.nvim")

    -- File tree
    use("kyazdani42/nvim-tree.lua")

    -- fidget
    use("j-hui/fidget.nvim")

    -- Lualine
    use({
        "nvim-lualine/lualine.nvim",
        requires = { opt = true },
    })

    -- LSP
    -- lsp color
    use("folke/lsp-colors.nvim")
    use("p00f/nvim-ts-rainbow")
    use("onsails/lspkind.nvim")
    use("neovim/nvim-lspconfig")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("WhoIsSethDaniel/mason-tool-installer.nvim")

    -- Autocompletion
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("saadparwaiz1/cmp_luasnip")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lua")

    -- Snippets
    use("L3MON4D3/LuaSnip")
    use("rafamadriz/friendly-snippets")
    -- lsp config
    -- use 'neovim/nvim-lspconfig'

    -- Null lsp
    use("jose-elias-alvarez/null-ls.nvim")
    -- use 'jayp0521/mason-null-ls.nvim'

    -- Formatter
    -- use 'mhartington/formatter.nvim'

    -- lsp installer
    -- use "williamboman/nvim-lsp-installer"

    -- mason
    -- use "williamboman/mason.nvim"

    -- mason lsp config
    -- use "williamboman/mason-lspconfig.nvim"

    -- Autocompletion

    -- Nvim cmp
    -- use 'hrsh7th/cmp-nvim-lsp'
    -- use 'hrsh7th/cmp-buffer'
    -- use 'hrsh7th/cmp-path'
    -- use 'hrsh7th/cmp-cmdline'
    -- use 'hrsh7th/nvim-cmp'

    -- Auto pairs
    use("windwp/nvim-autopairs")

    use("windwp/nvim-ts-autotag")

    -- Snippets
    -- use 'L3MON4D3/LuaSnip'
    -- use 'rafamadriz/friendly-snippets'
    -- use { 'saadparwaiz1/cmp_luasnip' }

    -- Comments
    use("numToStr/Comment.nvim")
    use("JoosepAlviste/nvim-ts-context-commentstring")

    -- Debugger
    -- use 'puremourning/vimspector'
    use("mfussenegger/nvim-dap")

    -- vim-be-good
    -- use("ThePrimeagen/vim-be-good")

    -- refactoring
    use("napmn/react-extract.nvim")
    -- use({
    -- 	"ThePrimeagen/refactoring.nvim",
    -- 	module = { "refactoring", "telescope" },
    -- 	keys = { [[<leader>r]] },
    -- 	wants = { "telescope.nvim" },
    -- 	-- config = function()
    -- 	--   require("config.refactoring").setup()
    -- 	-- end,
    -- })
end)
