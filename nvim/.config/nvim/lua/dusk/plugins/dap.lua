return {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = {
        {
            'Dusk-afk/nvim-dap-virtual-text',
            branch = 'fix/clear_on_continue'
        },
        {
            'Dusk-afk/nvim-dap-ui',
            branch = 'fix/render_on_continue'
        },
        'nvim-neotest/nvim-nio',
        'leoluz/nvim-dap-go',
    },
    config = function()
        local dap = require("dap")
        local ui = require("dapui")
        local virtText = require("nvim-dap-virtual-text")

        ui.setup({
            layouts = {
                {
                    elements = { {
                        id = "watches",
                        size = 0.25
                    }, {
                        id = "stacks",
                        size = 0.25
                    }, {
                        id = "scopes",
                        size = 0.25
                    }, {
                        id = "breakpoints",
                        size = 0.25
                    } },
                    position = "left",
                    size = 40
                },
                {
                    elements = { {
                        id = "repl",
                        size = 0.5
                    }, {
                        id = "console",
                        size = 0.5
                    } },
                    position = "bottom",
                    size = 10
                }
            },
        })

        virtText.setup({
            clear_on_continue = true,
        })

        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
        vim.keymap.set("n", "<leader>dg", dap.run_to_cursor)

        -- Eval under cursor
        vim.keymap.set("n", "<leader>d?", function()
            ui.eval(nil, { enter = true })
        end)

        vim.keymap.set("n", "<leader>du", dap.continue)
        vim.keymap.set("n", "<leader>di", dap.step_into)
        vim.keymap.set("n", "<leader>do", dap.step_over)
        vim.keymap.set("n", "<leader>dp", dap.step_out)
        vim.keymap.set("n", "<leader>d[", dap.step_back)
        vim.keymap.set("n", "<leader>dr", dap.restart)
        vim.keymap.set("n", "<leader>dq", dap.terminate)

        vim.keymap.set("n", "<leader>dt", ui.toggle)
        vim.keymap.set("n", "<leader>dn", function() ui.open({ reset = true }) end)

        -- Automatic UI open and close
        dap.listeners.before.attach.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            ui.close()
        end

        -- Signs
        vim.cmd("hi debugPC guibg=#4d4c3a")
        vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })
        vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
        vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped' })

        -- Debuggers
        require('dap-go').setup()
    end
}
