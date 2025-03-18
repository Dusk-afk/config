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
                    local detached = true

                    -- Use detached on windows
                    if jit.os == 'Windows' then
                        detached = false
                    end

                    dap.adapters.dart = {
                        type = "executable",
                        command = paths.flutter_bin,
                        args = { "debug-adapter" },
                        options = {
                            detached = detached,
                        },
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

        -- Autoload
        local function is_flutter_project()
            local pubspec_path = vim.fn.getcwd() .. '/pubspec.yaml'
            print(pubspec_path)
            if vim.fn.filereadable(pubspec_path) == 1 then
                for line in io.lines(pubspec_path) do
                    if line:match('sdk: flutter') then
                        return true
                    end
                end
            end
            return false
        end

        local flutter_tools = require('flutter-tools')
        local flutter_lsp = require('flutter-tools.lsp')
        if is_flutter_project() then
            flutter_tools.setup_project({})
            flutter_lsp.attach()
        end
        -- ----------------------
    end
}
