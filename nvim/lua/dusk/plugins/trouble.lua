return {
    "folke/trouble.nvim",
    opts = {
        preview = {
            -- Scratch only loads preview buffers with syntax highlighting
            -- Disabling it will load the real buffer
            scratch = false,
        },
        keys = {
            ["?"] = "help",
            r = "refresh",
            R = "toggle_refresh",
            q = "close",
            o = "jump_close",
            -- ["<esc>"] = "cancel",
            ["<cr>"] = "jump",
            ["<2-leftmouse>"] = "jump",
            ["<c-s>"] = "jump_split",
            ["<c-v>"] = "jump_vsplit",
            -- go down to next item (accepts count)
            -- j = "next",
            ["}"] = "next",
            ["]]"] = "next",
            -- go up to prev item (accepts count)
            -- k = "prev",
            ["{"] = "prev",
            ["[["] = "prev",
            dd = "delete",
            d = { action = "delete", mode = "v" },
            i = "inspect",
            p = "preview",
            P = "toggle_preview",
            zo = "fold_open",
            zO = "fold_open_recursive",
            zc = "fold_close",
            zC = "fold_close_recursive",
            za = "fold_toggle",
            zA = "fold_toggle_recursive",
            zm = "fold_more",
            zM = "fold_close_all",
            zr = "fold_reduce",
            zR = "fold_open_all",
            zx = "fold_update",
            zX = "fold_update_all",
            zn = "fold_disable",
            zN = "fold_enable",
            zi = "fold_toggle_enable",
            gb = { -- example of a custom action that toggles the active view filter
                action = function(view)
                    view:filter({ buf = 0 }, { toggle = true })
                end,
                desc = "Toggle Current Buffer Filter",
            },
            s = { -- example of a custom action that toggles the severity
                action = function(view)
                    local f = view:get_filter("severity")
                    local severity = ((f and f.filter.severity or 0) + 1) % 5
                    view:filter({ severity = severity }, {
                        id = "severity",
                        template = "{hl:Title}Filter:{hl} {severity}",
                        del = severity == 0,
                    })
                end,
                desc = "Toggle Severity Filter",
            },
        },
        icons = {
            indent        = {
                top         = "│ ",
                middle      = "├╴",
                -- last        = "└╴",
                -- last          = "-╴",
                last       = "╰╴", -- rounded
                fold_open   = " ",
                fold_closed = " ",
                ws          = "  ",
            },
            folder_closed = " ",
            folder_open   = " ",
            kinds         = {
                Array         = " ",
                Boolean       = "󰨙 ",
                Class         = " ",
                Constant      = "󰏿 ",
                Constructor   = " ",
                Enum          = " ",
                EnumMember    = " ",
                Event         = " ",
                Field         = " ",
                File          = " ",
                Function      = "󰊕 ",
                Interface     = " ",
                Key           = " ",
                Method        = "󰊕 ",
                Module        = " ",
                Namespace     = "󰦮 ",
                Null          = " ",
                Number        = "󰎠 ",
                Object        = " ",
                Operator      = " ",
                Package       = " ",
                Property      = " ",
                String        = " ",
                Struct        = "󰆼 ",
                TypeParameter = " ",
                Variable      = "󰀫 ",
            },
        },
    },
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle focus=true<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>xs",
            "<cmd>Trouble symbols toggle focus=true<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>xl",
            "<cmd>Trouble lsp toggle focus=true win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle focus=true<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle focus=true<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
}
