-- `ysiw"` # basic
require("nvim-surround").setup({
    keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
    },
    -- surrounds = {}, -- Defines surround keys and behavior
    aliases = {
        ["a"] = ">",
        ["b"] = ")",
        ["B"] = "}",
        ["r"] = "]",
        ["q"] = { '"', "'", "`" },
        ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
    },                 -- Defines aliases
    -- highlight = {},    -- Defines highlight behavior
    -- move_cursor = {},  -- Defines cursor behavior
    -- indent_lines = {}, -- Defines line indentation behavior
    attach = function()
        -- Note: While `ysabB` is a valid surround action, `ysarB` is not
        -- , since `ar` is not a valid Vim motion. side-stepped by
        -- these operator-mode maps:
        vim.keymap.set("o", "ir", "i[")
        vim.keymap.set("o", "ar", "a[")
        vim.keymap.set("o", "ia", "i<")
        vim.keymap.set("o", "aa", "a<")
    end,
})

-- https://github.com/kylechui/nvim-surround/blob/26b5067c3b56815eafbf41b7b830f1ab52819a45/doc/nvim-surround.txt
-- To configure this plugin, call `require("nvim-surround").setup()` or
-- `require("nvim-surround").buffer_setup()`. The former configures "global"
-- options that are present in every buffer, while the latter configures
-- buffer-local options that override the global options. This is particularly
-- useful for setting up filetype-specific surrounds, i.e. by calling
-- `require("nvim-surround").buffer_setup()` in a `ftplugin/` file.
