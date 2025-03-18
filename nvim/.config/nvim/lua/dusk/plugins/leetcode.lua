return {
    "kawre/leetcode.nvim",
    -- build = ":TSUpdate html",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        -- "ibhagwan/fzf-lua",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        -- configuration goes here
    },
    init = function()
        vim.keymap.set("n", "<leader>lH", "<cmd>Leet menu<CR>", { desc = "LeetCode: Menu" })
        vim.keymap.set("n", "<leader>ll", "<cmd>Leet lang<CR>", { desc = "LeetCode: Change language" })
        vim.keymap.set("n", "<leader>li", "<cmd>Leet info<CR>", { desc = "LeetCode: Show info" })
        vim.keymap.set("n", "<leader>lc", "<cmd>Leet console<CR>", { desc = "LeetCode: Show console" })
        vim.keymap.set("n", "<leader>lr", "<cmd>Leet run<CR>", { desc = "LeetCode: Run" })
        vim.keymap.set("n", "<leader>lR", "<cmd>Leet submit<CR>", { desc = "LeetCode: Submit" })
        vim.keymap.set("n", "<leader>lo", "<cmd>Leet open<CR>", { desc = "LeetCode: Open current question in browser" })
        vim.keymap.set("n", "<leader>lx", "<cmd>Leet reset<CR>", { desc = "LeetCode: Resets the code to default" })
        vim.keymap.set("n", "<leader>lz", "<cmd>Leet last_submit<CR>", { desc = "LeetCode: Retrieve last submitted code" })
        vim.keymap.set("n", "<leader>ld", "<cmd>Leet desc toggle<CR>", { desc = "LeetCode: Toggle description" })
        vim.keymap.set("n", "<leader>le", "<cmd>Leet desc stats<CR>", { desc = "LeetCode: Toggle description stats (Diff, Likes, etc.)" })

        -- On <leader>lq, first ask yes or no, then if yes, quit
        local on_quit = function()
            local ok = vim.fn.confirm("Do you really want to quit?", "&Yes\n&No", 2)
            if ok == 1 then
                vim.cmd("Leet exit")
            end
        end
        vim.keymap.set("n", "<leader>lq", on_quit, { desc = "LeetCode: Quit" })
    end,
}
