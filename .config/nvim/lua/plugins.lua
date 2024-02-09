local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system {
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    }
    vim.cmd [[packadd packer.nvim]]
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    local msg = "Couldn't require packer in lua/plugins.lua"
    vim.notify(msg, vim.log.levels.ERROR)
    return
end

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end
    }
}

packer.startup(function(use)
    use {
        'sainnhe/sonokai',
        'sainnhe/gruvbox-material',
        'sainnhe/everforest',
        'sainnhe/edge',
        'theniceboy/nvim-deus',
        -- 'Mofiqul/dracula.nvim',
        -- 'dracula/vim',
        'folke/tokyonight.nvim',
        -- These versions of sainnhe's themes have weird treesitter highlights
        -- 'rafi/awesome-vim-colorschemes'
    }
    use { 'catppuccin/nvim', as = 'catppuccin' }
    use { 'dracula/vim', as = 'dracula' }
    use { -- Adds git releated signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        config = function()
            -- See `:help gitsigns.txt`
            require('gitsigns').setup {
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                } }
        end
    }
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup { break_undo = false } end
    }

    -- Buddha bless Tim Pope
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive' -- :Git commands
    use 'tpope/vim-rhubarb'  -- github related commands
    use 'tpope/vim-surround' -- dealing with quotes and parens
    use 'tpope/vim-sleuth'   -- detect tabs and shiftwidth
    -- use 'tpope/vim-vinegar'

    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    -- use 'nvim-lua/popup.nvim'
    use { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            { 'j-hui/fidget.nvim', tag = 'legacy', config = function() require("fidget").setup() end },

            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',
            -- 'folke/trouble.nvim',
        },
    }
    use { -- Autocompletion
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',       -- The completion plugin
            'hrsh7th/cmp-path',         -- buffer completions
            'hrsh7th/cmp-cmdline',      -- path completions
            'saadparwaiz1/cmp_luasnip', -- snippet completions
            'L3MON4D3/LuaSnip',         -- snippet engine
            'rafamadriz/friendly-snippets',
        },
    }
    use {
        'simrat39/symbols-outline.nvim',
        config = function()
            require("symbols-outline").setup({
                width = 15,
                position = 'top'
            })
        end
    }
    use {
        'lvimuser/lsp-inlayhints.nvim',
        config = function()
            require("lsp-inlayhints").setup()
        end
    }
    use {
        'folke/zen-mode.nvim',
        config = function()
            require("zen-mode").setup()
        end
    }
    -- Debugging
    use {
        'rcarriga/nvim-dap-ui',
        'mfussenegger/nvim-dap',
    }

    -- Fuzzy Finder (files, lsp, etc)
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
    use { "nvim-telescope/telescope-file-browser.nvim" }
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        config = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
        config = function()
            require("nvim-tree").setup({ view = { relativenumber = true } })
        end
    }

    use 'mbbill/undotree'
    use { "akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end }
    use 'khaveesh/vim-fish-syntax'
    if is_bootstrap then
        packer.sync()
    end
end)

if is_bootstrap then
    return
end
