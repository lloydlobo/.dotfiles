require('rose-pine').setup({
    disable_background = true
})

-- require('github-theme').setup({
--     options = {
--         hide_end_of_buffer = false, -- Hide the '~' character at the end of the buffer for a cleaner look
--         hide_nc_statusline = false, -- Override the underline style for non-active statuslines
--         transparent = true,         -- Disable setting background
--         styles = {
--             comments = 'italic',
--             keywords = 'bold',
--             types = 'italic,bold',
--         },
--     }
-- })

-- 1. Sets color scheme
-- 2. Sets transparant background.
-- vim.opt.background = 'dark' vim.opt.termguicolors = true
-- `0` sets global space for every window. `Normal` is for vim.
function ColorMyPencils(color)
    color = color or "rose-pine"                              -- fallback to default `rose-pine` if no `color`.
    vim.cmd.colorscheme(color)                                -- Sets colorscheme.
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })         -- Sets transparency for background.
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })    -- Sets transparency for background floats too.
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#212020" }) -- Sets color for ColorColumn at 80 width. see lua/gg/sets.lua.
end                                                           --  "github_dark_tritanopia" || "github_dark" || "github_dark_high_contrast" || "github_dark_dimmed" || "github_dark_tritanopia"

ColorMyPencils()                                              -- Run `:lua ColorMyPencils()` from anywhere in neovim cmd.
