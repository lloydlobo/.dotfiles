local dap = require('dap')

vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = "toggle [b]reakpoint @dap" })
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    { desc = "set [B]reakpoint condition @dap" })
vim.keymap.set("n", "<leader>lb", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
    { desc = "set breakpoint [l]og [p]oint message @dap" })
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>",
    { desc = "open [d]ebugging [r]epl @dap" })
vim.keymap.set("n", "<leader>dt", ":lua require'dap-go'.debug_test()<CR>",
    { desc = "[d]ebug [t]est for go @dap" })

vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>", { desc = "continue @dap" })
vim.keymap.set("n", "<F3>", ":lua require'dap'.step_over()<CR>", { desc = "step over @dap" })
vim.keymap.set("n", "<F2>", ":lua require'dap'.step_into()<CR>", { desc = "step into @dap" })
vim.keymap.set("n", "<F2>", ":lua require'dap'.step_into()<CR>", { desc = "step into @dap" })

require("nvim-dap-virtual-text").setup()
require("dapui").setup()
--require("dap-go").setup()

---@diagnostic disable-next-line: redefined-local
local dapui = require('dapui')
dap.listeners.after.event_initalized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
            return '/usr/bin/python'
        end,
    },
}

-- NOTE: Resolve missing configs with:
-- - No configuration found for `lua`. You need to add configs to `dap.confi
--   gurations.lua` (See `:h dap-configuration`)
