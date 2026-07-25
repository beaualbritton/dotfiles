return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
            { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
        },
        opts = {
            defaults = {
                border = true,
                layout_strategy = "horizontal",
                sorting_strategy = "ascending",
                layout_config = {
                    prompt_position = "top",
                    width = 0.88,
                    height = 0.78,
                    preview_width = 0.55,
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
        },
    },
}

