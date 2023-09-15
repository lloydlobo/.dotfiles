local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

--
-- REMAPS
--

-- NOTE: for me - Ctrl-e for ui. You could use `Ctrl-p` for git file list telescope preview.
vim.keymap.set("n", "<leader>a", mark.add_file)    -- add current file to harpoon.
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu) -- popup navigations file list menu.

-- Shortcuts to jump to file.
vim.keymap.set("n", "<C-h>n", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-h>e", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-h>a", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-h>i", function() ui.nav_file(4) end)
