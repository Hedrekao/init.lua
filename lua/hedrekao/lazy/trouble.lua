return {
    {
        "folke/trouble.nvim",
        opts = {
            auto_jump = true
        }, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>tt",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "[t",
                "next"
            }
        },
    },
}
