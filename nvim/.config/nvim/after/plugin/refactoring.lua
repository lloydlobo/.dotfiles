require('refactoring').setup({
    -- For certain languages like Golang, types are required for
    -- functions that return an object(s) and parameters of functions
    -- . Unfortunately, for some parameters and functions there is no way
    -- to automatically find their type. In those instances, we want
    -- to provide a way to input a type instead of inserting a placeholder value.
    prompt_func_return_type = {
        go = true,
        java = false,

        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
    },
    prompt_func_param_type = {
        go = true,
        java = false,

        cpp = false,
        c = false,
        h = false,
        hpp = false,
        cxx = false,
    },
    printf_statements = {
        -- cpp = { 'std::cout << "%s" << std::endl;' }
    },
    print_var_statements = {
        -- cpp = { 'printf("a custom statement %%s %s", %s)' }
    },
    -- extract_var_statements = {
    --     go = "%s := %s // poggers"
    -- }, -- overriding extract statement for go
})

-- The ` ` (space) at the end of some mappings is intentional because
-- those mappings expect an additional argument (all of these mappings
-- leave the user in command mode to utilize the preview command feature).

vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")

vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")

vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")

vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")

--
-- API
--
--
-- 1. Lua API
-- [See more](https://github.com/ThePrimeagen/refactoring.nvim#lua-api-)
--
-- 2. Using Built-In Neovim Selection
-- prompt for a refactor to apply when the remap is triggered
-- vim.keymap.set(
--     { "n", "x" },
--     "<leader>rr",
--     function() require('refactoring').select_refactor() end
-- )
-- Note that not all refactor support both normal and visual mode
--
-- 3. Using Telescope
-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")
vim.keymap.set(
    { "n", "x" },
    "<leader>rr",
    function() require('telescope').extensions.refactoring.refactors() end
)

--
-- Configuration for Debug Operations
--
--
-- You can also use below = true here to to change the position of the printf
-- statement (or set two remaps for either one). This remap must be made in normal mode.
vim.keymap.set(
    "n",
    "<leader>rp",
    function() require('refactoring').debug.printf({ below = false }) end
)
--
-- Print var
--
vim.keymap.set({ "x", "n" }, "<leader>rv", function() require('refactoring').debug.print_var() end)
-- Supports both visual and normal mode
--
vim.keymap.set("n", "<leader>rc", function() require('refactoring').debug.cleanup({}) end)
-- Supports only normal mode
