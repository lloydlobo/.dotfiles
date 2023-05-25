local dap = require('dap')

vim.keymap.set("n", "<leader>B", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = "continue dap" })

vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>", { desc = "continue dap" })

--dap.configurations.python = {
--    {
--        type = 'python',
--        request = 'launch',
--        name = "Launch file",
--        program = "${file}",
--        pythonPath = function()
--            return '/usr/bin/python'
--        end,
--    },
--}
