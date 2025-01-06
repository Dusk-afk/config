return {
    'nvim-flutter/flutter-tools.nvim',
    event = 'VeryLazy',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
        require("flutter-tools").setup {
            decorations = {
                statusline = {
                    app_version = true,
                    device = true,
                    project_config = true,
                }
            },

            debugger = {
                enabled = true,
                run_via_dap = true,
                exception_breakpoints = {},
                register_configurations = function(paths)
                    local dap = require("dap")
                    dap.adapters.dart = {
                        type = "executable",
                        command = paths.flutter_bin,
                        args = { "debug-adapter" },
                    }
                    dap.configurations.dart = {}
                    require("dap.ext.vscode").load_launchjs()
                end,
            },
        }

        -- Keymaps
        vim.keymap.set("n", "<leader>fld", ":FlutterDebug<CR>", { desc = "Debug flutter app" })
        vim.keymap.set("n", "<leader>flk", ":FlutterDevices<CR>", { desc = "List of connected devices" })
        vim.keymap.set("n", "<leader>fle", ":FlutterEmulators<CR>", { desc = "List of emulators" })
        vim.keymap.set("n", "<leader>flr", ":FlutterReload<CR>", { desc = "Hot reload" })
        vim.keymap.set("n", "<leader>flR", ":FlutterRestart<CR>", { desc = "Hot restart" })
        vim.keymap.set("n", "<leader>flq", ":FlutterQuit<CR>", { desc = "Quit" })
        vim.keymap.set("n", "<leader>fll", ":FlutterLogToggle<CR>", { desc = "Toggles log buffer" })
        vim.keymap.set("n", "<leader>flL", ":FlutterLogClear<CR>", { desc = "Clears log buffer" })
        vim.keymap.set("n", "<leader>flo", ":FlutterOutlineToggle<CR>", { desc = "Toggles outline buffer" })
    end
}
