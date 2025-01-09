return {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        -- log_level = 'debug',
        pre_save_cmds = { "NvimTreeClose" },
        post_restore_cmds = {
            function()
                -- Restore nvim-tree after a session is restored
                local nvim_tree_api = require('nvim-tree.api')
                nvim_tree_api.tree.open()
                nvim_tree_api.tree.change_root(vim.fn.getcwd())
                nvim_tree_api.tree.reload()
            end
        },
        auto_save = true,
        auto_restore = true,
        auto_create = true,
        no_restore_cmds = {
            -- This is a workaround to still try to restore the session
            function()
                vim.cmd("SessionRestore")
            end
        },
        session_lens = {
            theme_conf = {
                border = true,
            },
        },
    },
    keys = {
        -- Will use Telescope if installed or a vim.ui.select picker otherwise
        { '<leader>wr', '<cmd>SessionRestore<CR>',        desc = 'Restore session' },
        { '<leader>ww', '<cmd>SessionSave<CR>',           desc = 'Save session' },
        { '<leader>ws', '<cmd>SessionSearch<CR>',         desc = 'Session search' },
        { '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
    },
    init = function()
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end
}
