--
-- LSP
--

-- https://github.com/VonHeikemen/lsp-zero.nvim#usage
local lsp = require('lsp-zero').preset({})

-- NOTE: `.ensure_installed()` will be removed. Use the module mason-lspconfig to install LSP servers.
lsp.ensure_installed({
    'tsserver',
    --    'eslint',
    'lua_ls',
    'rust_analyzer',
})

-- Fix Undefined global 'vim'.
lsp.nvim_workspace()

-- Manual setup.
-- NOTE: if you use NixOS don't install mason.nvim.
-- When you don't have mason.nvim installed. You'll need to list the servers installed in your system.
lsp.setup_servers({ 'tsserver',

    -- 'eslint',
    'lua_ls', 'rust_analyzer' })

-- NOTE: Adopted primes lua-language-server to lua_ls. Not sure if the options are same.
-- Fix Undefined global 'vim'
-- Uncomment the wholelot if it doesn'twork.
-- lsp.configure('lua_ls', {
--     settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
-- })

-- Run `:LspInstall` and select the option Mason presents.
-- To make sure lua_ls can detect the "root directory" of our config we need to create a file
-- called `.luarc.json` in the Neovim config folder. This file can be empty, it just need to exists.
--
-- NOTE: Add this before the setup function of lsp-zero.
-- If you wanted to, you could setup lua_ls specifically for Neovim, all with one line of code.
-- (Optional) Configure lua language server for neovim
-- FIXME: Is this slowing down?
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

-- Defines the sign icons that appear in the gutter.
lsp.set_sign_icons({
    error = 'E', -- ✘
    warn = 'W',  -- ▲
    hint = 'H',  -- ⚑
    info = 'I',  -- »
})

-- Attaches on every single buffer that has a lsp associated with it.
-- Remap only works on the current buffer you are on.
-- If something isn't a buffer, vim will still try vim's method to jump on definition without the need of LSP.
lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    -- lsp.default_keymaps({buffer = bufnr})
    -- OR
    -- Custom mappings: ... [Quickfix List] References.
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)                             -- [g]o to [d]efinition.
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)                                   -- hover symbol overview under cursor (Shift+k).

    vim.keymap.set("n", "<leader>vds", require('telescope.builtin').lsp_document_symbols, opts)          -- [v]im [d]ocument [s]ymbols.
    vim.keymap.set("n", "<leader>vws", require('telescope.builtin').lsp_dynamic_workspace_symbols, opts) -- [v]im [w]orkspace [s]ymbols.
    --vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts) -- [v]im [w]orkspace [s]ymbol.
    -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)  -- [v]im [d]iagnostic.
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)           -- go to next [d]iagnostic.
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)           -- go to previous [d]iagnostic.
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)   -- [v]im [c]ode [a]ction.
    vim.keymap.set("n", "<leader>vcm", function() vim.cmd([[CodeActionMenu]]) end, opts) -- [v]im [c]ode action [m]enu.
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)    -- [v]im [r]eferences [r].
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)        -- [v]im [r]ename [n]ame.

    -- FIXME: Doesn't work. -- See [Reference](lsp.txt)
    -- signature_help()                                *vim.lsp.buf.signature_help()*
    --     Displays signature information about the symbol under the cursor in a floating window.
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

--
-- CMP
--

-- NOTE: You need to setup `cmp` after `lsp-zero`.
local cmp = require('cmp')
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

--local cmp_select = { behavior = cmp.SelectBehavior.Select }
--local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    -- NOTE: To add more keybindings I recommend you use nvim-cmp directly.
    mapping = {
        -- `Enter` key to confirm completion. If you want to confirm without selecting the item, use this.
        ['C-y'] = cmp.mapping.confirm({ select = true }), -- default: <CR> = ... {select = false} Enter will only confirm the selected item. You need to select the item before pressing enter.
        ['<C-Space>'] = cmp.mapping.complete(),           -- Ctrl+Space to trigger completion menu

        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        -- ['<C-n>'] = cmp_action.luasnip_jump_forward(),    -- default: '<C-f>' Navigate between snippet placeholder
        -- ['<C-p>'] = cmp_action.luasnip_jump_backward(),   -- default: '<C-b>'

        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { 'i', 's' }),
})

-- TODO: What does Tab do?
--local cmp_mappings = lsp.defaults.cmp_mappings({
--  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--  ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- `Ctrl+y` key to confirm completion
--  ["<C-Space>"] = cmp.mapping.complete(), -- Ctrl+Space to trigger completion menu
--})
--cmp_mappings['<Tab>'] = nil
--cmp_mappings['<S-Tab>'] = nil
--
--lsp.setup_nvim_cmp({
--  mapping = cmp_mappings
--})


vim.diagnostic.config({
    virtual_text = true
})

-- TODO:
--
-- - [ ] .ensure_installed() will be removed. Use the module mason-lspconfig to install LSP servers.
--		  {'williamboman/mason-lspconfig.nvim'},
--
-- - [ ] I would like to get rid of named preset in the future. It's better if you use the default preset, the minimal. I would advice against using the one called "recommended". Just add your settings using the .preset() function.
--
-- v v v v
--  v v v
--    v
--
-- NOTE:
-- [Source](https://github.com/VonHeikemen/lsp-zero.nvim#future-changesdeprecation-notice)
-- > I would like to get rid of named preset in the future. It's better if you use the
-- default preset, the minimal. I would advice against using the one called "recommended". Just
-- add your settings using the .preset() function.
--
-- Future Changes/Deprecation notice
-- Settings and functions that will change in case I feel forced to created a v3.x branch.
--
--
-- set_lsp_keymaps will be removed in favor of .default_keymaps().
-- manage_nvim_cmp will be removed in favor of .extend_cmp().
-- setup_servers_on_start will be removed. LSP servers will need to be listed explicitly using .setup_servers().
-- call_servers will be removed in favor of a explicit setup.
-- configure_diagnostics will be removed.
-- Functions
-- .set_preferences() will be removed in favor of overriding option directly in .preset.
-- .setup_nvim_cmp() will be removed. Use the cmp module to customize nvim-cmp.
-- .setup_servers() will no longer take an options argument. It'll only be a convenient way to initialize a list of servers.
-- .default.diagnostics() will be removed. Diagnostic config has been reduced, only severity_sort and borders are enabled. There is no need for this anymore.
-- .defaults.cmp_sources() will be removed. Sources for nvim-cmp will be handled by the user.
-- .defaults.cmp_mappings() will be removed. In the future only the defaults that align with Neovim's behavior will be configured. lsp-zero default functions for nvim-cmp will have to be added manually by the user.
-- .nvim_workspace() will be removed. Use .nvim_lua_ls() to get the config and then use .configure() to setup the server.
-- .defaults.nvim_workspace() will be replaced by .nvim_lua_ls().
-- .ensure_installed() will be removed. Use the module mason-lspconfig to install LSP servers.
-- .extend_lspconfig() will be removed.
