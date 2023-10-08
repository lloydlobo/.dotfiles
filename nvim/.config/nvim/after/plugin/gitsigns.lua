-- Adds git releated signs to the gutter, as well as utilities for managing changes
-- See `:help gitsigns.txt`
require('gitsigns').setup {
    signs                        = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '*' },
        untracked    = { text = '┆' },
    },
    signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
        interval = 1000,
        follow_files = true
    },
    attach_to_untracked          = true,
    current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,   -- Use default
    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
    preview_config               = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    yadm                         = {
        enable = false
    },

    on_attach                    = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = "next git hunk @gitsigns" })

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true, desc = "previous git hunk @gitsigns" })

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk, { desc = "[h]unk [s]tage @gitsigns" })
        map('n', '<leader>hr', gs.reset_hunk, { desc = "[h]unk [r]eset @gitsigns" })
        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
            { desc = "[h]unk [s]tage --VISUAL-- @gitsigns" })
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
            { desc = "[h]unk [r]eset --VISUAL-- @gitsigns" })

        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "[u]ndo stage [h]unk @gitsigns" })
        map('n', '<leader>hp', gs.preview_hunk, { desc = "[p]review [h]unk @gitsigns" })

        map('n', '<leader>hS', gs.stage_buffer, { desc = "[S]tage all [h]unks in buffer @gitsigns" })
        map('n', '<leader>hR', gs.reset_buffer, { desc = "[r]eset [b]uffer @gitsigns" })

        map('n', '<leader>hb', function() gs.blame_line { full = true } end,
            { desc = "[b]lame line [h]unk hover float @gitsigns" })

        map('n', '<leader>hd', gs.diffthis, { desc = "[d]iff this [h]unk @gitsigns" })
        map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "[D]iff this '~' [h]unk @gitsigns" })

        map('n', '<leader>hts', gs.toggle_signs, { desc = "[h]unk [t]oggle [s]igns @gitsigns" })
        map('n', '<leader>htw', gs.toggle_word_diff, { desc = "[t]oggle all [h]unks [w]ord diff @gitsigns" })
        map('n', '<leader>htd', gs.toggle_deleted, { desc = "[t]oggle [d]eleted [h]unks @gitsigns" })
        map('n', '<leader>htb', gs.toggle_current_line_blame, { desc = "[t]oggle current line [h]unk [b]lame @gitsigns" })


        -- Text object
        -- FIXME: Does this work, or how?
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select [h]unk --INSERT-- @gitsigns' })
    end
}
