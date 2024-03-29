--
-- PACKAGE MANAGER
--
-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd [[packadd packer.nvim]]
end

-- NOTE: if you use NixOS don't install mason.nvim
-- Prerquisites: $ git clone --depth 1 https://github.com/wbthomason/packer.nvim\
--   ~/.local/share/nvim/site/pack/packer/start/packer.nvim
-- [Source](https://github.com/wbthomason/packer.nvim#quickstart)
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim') -- vim.cmd [[packadd packer.nvim]]

-- TODO: Implement Debugging with dap and friends.
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Themes.
    use({
        'projekt0n/github-nvim-theme',
        config = function()
            -- vim.cmd('colorscheme github_dark')
        end
    })
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            -- vim.cmd('colorscheme rose-pine')
        end
    })

    -- Error lens/actions.
    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })
    -- Note: :TSUpdate will cause Packer to fail upon the first installation. It will run correctly
    -- when updating. To avoid this, call nvim-treesitter.install.update() directly:
    use({
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    })
    --use('nvim-treesitter/nvim-treesitter', {
    --    run = ':TSUpdate',
    --    requires = {
    --        { 'nvim-treesitter/nvim-treesitter-textobjects', },
    --    }
    --})
    use('nvim-treesitter/playground')    -- `TSPlaygroundToggle` -> (view AST).
    use('ThePrimeagen/harpoon')          -- Getting you where you want with the fewest keystrokes.
    use({
        "ThePrimeagen/refactoring.nvim", -- The Refactoring library based off the Refactoring book by Martin Fowler
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" }
        }
    })
    use('mbbill/undotree') -- undo history visualizer.

    -- Git related plugins.
    use('tpope/vim-fugitive')
    use('tpope/vim-rhubarb')
    use("rhysd/committia.vim") -- splits git commit to edit,status,diff windows.
    use({
        'ruifm/gitlinker.nvim',
        requires = 'nvim-lua/plenary.nvim',
    })

    use({ 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu', })
    -- Detect tabstop and shiftwidth automatically.
    use('tpope/vim-sleuth')

    use("folke/flash.nvim")

    use('lewis6991/gitsigns.nvim')                 -- Adds git releated signs to the gutter, as well as utilities for managing changes
    use('nvim-treesitter/nvim-treesitter-context') -- sticky parent function/module/.. name on scroll.

    use({
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {
                'neovim/nvim-lspconfig',
                requires = {
                    {
                        'williamboman/mason.nvim',
                        run = function() pcall(vim.cmd, 'MasonUpdate') end,
                    },                                       -- Optional
                    { 'williamboman/mason-lspconfig.nvim' }, -- Optional

                    -- Useful status updates for LSP
                    {
                        'j-hui/fidget.nvim',
                        -- NOTE: fidget.nvim will soon be completely rewritten.
                        tag = 'legacy', -- In the meantime, please pin your plugin config to the legacy tag to avoid breaking changes.
                        opts = {}
                    },                  -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`

                    -- Additional lua configuration, make nvim stuff amazing!
                    { 'folke/neodev.nvim', }, -- Additional lua configuration, makes nvim stuff amazing!
                },                            -- Required
            },

            -- Autocompletion
            {
                'hrsh7th/nvim-cmp',
                requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
                    'rafamadriz/friendly-snippets',
                },
            },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    })

    use({
        'mfussenegger/nvim-dap',
        requires = {
            'rcarriga/nvim-dap-ui',    -- Creates a beautiful debugger UI
            'williamboman/mason.nvim', -- Installs the debug adapters for you
            'jay-babu/mason-nvim-dap.nvim',
            'leoluz/nvim-dap-go',      -- Add your own debuggers here
        }
    })
    use({ 'theHamsta/nvim-dap-virtual-text' }) -- This plugin adds virtual text support to nvim-dap. nvim-treesitter is used to find variable definitions.

    -- comments
    use({ "JoosepAlviste/nvim-ts-context-commentstring", })
    use({ "kylechui/nvim-surround", tag = "*", })
    -- Use for stability; omit to use `main` branch for the latest features
    --
    use({
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim', -- See `:help lualine.txt`
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    })

    use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }

    use("folke/zen-mode.nvim")
    --use("github/copilot.vim")
    use("eandrju/cellular-automaton.nvim")
    use("laytan/cloak.nvim") --  overlay *'s (or any other character) over defined patterns in defined files. It also disables 'cmp' for the buffer(if it is installed).
    use('wakatime/vim-wakatime')
end)                         -- `:so` Shoutout! (source the file) -> `:PackerSync`
