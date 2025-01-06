return {
    'rcarriga/nvim-notify',
    priority = 1000,
    config=function()
        local notify = require('notify')
        notify.setup({
            -- True = Top
            top_down = false,
        })

        vim.notify = notify
    end,
}
