require("flash").setup({
    ---@type Flash.Config
    opts = {},
})

vim.keymap.set({ "x", "n" }, "<C-y>", function() require("flash").treesitter(opts) end,
    { desc = "open flash to increase/decrease the selection with jump label, or ; and ," })
