-- require('rose-pine').setup({
--     disable_background = true
-- })

require('github-theme').setup({
    -- ...
    options = {
        hide_end_of_buffer = false, -- Hide the '~' character at the end of the buffer for a cleaner look
        hide_nc_statusline = false, -- Override the underline style for non-active statuslines
        transparent = true,         -- Disable setting background
        styles = {
            comments = 'italic',
            keywords = 'bold',
            types = 'italic,bold',
        },
    }
})

-- 1. Sets color scheme
-- 2. Sets transparant background.
--
-- vim.opt.background = 'dark' vim.opt.termguicolors = true
function ColorMyPencils(color)
    -- color = color or "rose-pine" -- fallback to default `rose-pine` if no `color`.
    color = color or "github_dark_dimmed" -- or "github_dark_high_contrast"
    vim.cmd.colorscheme(color)            -- Sets colorscheme.

    -- `0` sets global space for every window. `Normal` is for vim.
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })         -- Sets transparency for background.
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })    -- Sets transparency for background floats too.
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#111111" }) -- Sets color for ColorColumn at 80 width. see lua/gg/sets.lua.
    --vim.api.nvim_set_hl(0, "ColorColumn", { bg = 13 }) -- Sets color for ColorColumn at 80 width. see lua/gg/sets.lua.
end

ColorMyPencils() -- Run `:lua ColorMyPencils()` from anywhere in neovim cmd.
