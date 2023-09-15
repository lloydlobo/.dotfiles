-- LEADER KEY
vim.g.mapleader = " " -- (Space as Leader Key)

-- <normal> -> `<leader>+p+v` -> `:Ex` (Project view -> Opens Netrw Explorer)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "[p]+[v] Project view" })

-- Select and move line below.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Select and move line [J] down" })

-- Select and move line above.
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = "Select and move line [K] up" })

-- Copy from cursor position to line end.
vim.keymap.set("n", "Y", "yg$", { desc = "Copy from cursor to line [Y] end" })

-- Keep cursor in the same place while appending the line below with space using `J`.
vim.keymap.set("n", "J", "mzJ`z", { desc = "Keep cursor and append line below [J]" })

-- Half page Jump below and recenter line in window.
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page jump [C-d] and recenter" })

-- Half page Jump above and recenter line in window.
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page jump [C-u] and recenter" })

-- Go forward to search terms and recenter.
vim.keymap.set("n", "n", "nzzzv", { desc = "Go forward to [n]ext search term and recenter" })

-- Go previous to search terms and recenter.
vim.keymap.set("n", "N", "Nzzzv", { desc = "Go [N]ext to search term and recenter" })

-- CTRL-Z -- Suspend Nvim, like ":stop".
vim.keymap.set("n", "<leader>gg", function()
    vim.cmd([[:terminal gitui]]) -- Open gitui in a terminal buffer.
end, { desc = "[g]+[g] Open gitui" })

-- Retain highlighted copied buffer while pasting over another term.
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste over with [p]" })

-- `y/Y` only for vim AND `<leader> + y/Y` for system clipboard.
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "[y]ank to system clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "[y]ank selection to system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "[Y]ank until end of line to system clipboard" })

-- Deleting to void register.
vim.keymap.set("n", "<leader>d", "\"_d", { desc = "[d]elete without yanking" })
vim.keymap.set("v", "<leader>d", "\"_d", { desc = "[d]elete selection without yanking" })

-- C-c to exit. (old habits die hard)
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode with [C-c]" })

-- C-s to save buffer.
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save buffer in normal mode with [C-s]" })
vim.keymap.set("i", "<C-s>", "<cmd>w<CR>", { desc = "Save buffer in insert mode with [C-s]" })

-- Never press Q.
vim.keymap.set("n", "Q", "<nop>", { desc = "Do nothing on [Q]" })

-- Edit file in a separate Zellij terminal pane.
local function open_zellij_file(filename)
    vim.cmd("!zellij edit " .. filename)
end

vim.keymap.set("n", "<C-f>ze", function()
    vim.cmd("!tree") -- Show files tree in the current directory.
    local filename = vim.fn.input("zellij edit <filename> ")
    open_zellij_file(filename)
end, { desc = "[z]+[e] Edit file in Zellij" })

-- Show directory tree structure.
vim.keymap.set("n", "<C-f>t", "<cmd>!tree<CR>", { desc = "Show directory tree structure" })

-- List all files in the current directory.
vim.keymap.set("n", "<C-f>d", "<cmd>!fd<CR>", { desc = "List all files in current directory" })

-- TODO: -- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- NOTE: Use tree for now.
vim.keymap.set("n", "<C-f>d", "<cmd>!zellij run -- <CR>", { desc = "[d]irectory run" })

-- Open in zellij
vim.keymap.set('n', '<leader>tz', function()
    local prompt = vim.fn.input("zellij run -- ") -- grep_string (provides search term which is a vim function input)
    -- TODO: something like this: :split term://node " . a:filename.
    print(prompt)
    --vim.cmd([["!zellij run -- " + prompt]])
end, { desc = "[t]+[z] Zellij run command" })

-- [f]ormat buffer
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "[f]ormat buffer" })

-- [F]ormat comment line
vim.keymap.set("n", "<leader>F", "0o<C-[>k0J080l3bea<CR><C-[>0", { desc = "[F]ormat comment line" })

-- Display the [count] previous/next error in the list that includes a file name.
-- If there are no file names at all, go to the [count] previous/next error.
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "[C-k] Next error" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "[C-j] Previous error" })

-- Same as ":cnext", except the location list for the current window is used instead of the quickfix list.
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "[k] Next location" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "[j] Previous location" })

-- Search and replace string under the cursor globally. Substitute / Substitution
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "[s]earch and replace" })

-- Make file executable.
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file e[x]ecutable" })

-- Make executable files non-executable.
vim.keymap.set("n", "<leader>X", "<cmd>!chmod -x %<CR>", { desc = "Make executable file non-e[X]ecutable" })

-- <normal> -> `<leader>+p+s` -> `:Telescope grep_string` (Grep search term project).
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it [r]ain" })

-- Edit [v]im [p]lugins [p]acker/[p]lugin file.
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/gg/packer.lua<CR>", { desc = "[v]im [p]lugins [p]acker" })

-- Source file ShoutOut!!!
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = "Source [file]" })

-- EOF --

-- [0 to LSP] 25:25 minute mark
--
-- :%s\/(./)noremap(/vim.keymap.set("\1",
-- :%s -- do it for the entire file.
-- /\(.\) -- everything that has a `.` (dot). Looks like a fighting one-eyed curvy. e.g. vnoremap("J"...
-- <word_to_replace> -- do not use `<`/`>` while entering the word.
-- (/<word_to_replace_with>"\1 -- suffix with `"` and the first letter (dot) char we skipped earlier. so `"v` e.g. vim.keymap.set("v"...
