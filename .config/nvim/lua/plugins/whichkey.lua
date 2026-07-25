return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        cmd = "WhichKey",
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = true })
                end,
                desc = "Keybinding guide",
            },
        },
        opts = {
            delay = 250,
            preset = "modern",
            icons = {
                breadcrumb = "»",
                separator = "➜",
                group = "+",
            },
            spec = {
                { "<leader>f", group = "find" },
                { "<leader>g", group = "git" },
                { "g", group = "goto" },
                { "[", group = "previous" },
                { "]", group = "next" },
            },
            win = {
                border = "rounded",
                padding = { 1, 2 },
            },
        },
    },
}
