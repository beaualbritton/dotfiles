return {
    {
        "saghen/blink.cmp",
        version = "1.*",
        event = "InsertEnter",
        opts = {
            keymap = {
                preset = "super-tab",
                ["<CR>"] = { "accept", "fallback" },
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-e>"] = { "hide", "fallback" },
                ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
            },
            appearance = {
                nerd_font_variant = "mono",
            },
            completion = {
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = false,
                    },
                },
                menu = {
                    border = "rounded",
                    max_height = 10,
                    winblend = 10,
                    draw = {
                        columns = {
                            { "kind_icon" },
                            { "label", "label_description", gap = 1 },
                            { "source_name" },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 250,
                    window = {
                        border = "rounded",
                        winblend = 10,
                    },
                },
                ghost_text = {
                    enabled = true,
                },
            },
            signature = {
                enabled = true,
                window = {
                    border = "rounded",
                    winblend = 10,
                },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                providers = {
                    lsp = {
                        name = "LSP",
                        fallbacks = {},
                    },
                    path = {
                        name = "Path",
                    },
                    snippets = {
                        name = "Snippet",
                    },
                    buffer = {
                        name = "Buffer",
                        min_keyword_length = 3,
                    },
                },
            },
            fuzzy = {
                implementation = "prefer_rust_with_warning",
            },
        },
        opts_extend = { "sources.default" },
    },
}
