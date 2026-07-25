return {
    {
        "nvim-tree/nvim-tree.lua",
        cmd = {
            "NvimTreeOpen",
            "NvimTreeClose",
            "NvimTreeToggle",
            "NvimTreeFindFile",
        },
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function(_, opts)
            local api = require("nvim-tree.api")

            opts.on_attach = function(bufnr)
                api.config.mappings.default_on_attach(bufnr)
                vim.keymap.set("n", "<BS>", api.tree.change_root_to_parent, {
                    buffer = bufnr,
                    silent = true,
                    desc = "Explorer: parent directory",
                })
            end

            require("nvim-tree").setup(opts)
        end,
        opts = {
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            view = {
                side = "right",
                width = 24,
                preserve_window_proportions = true,
            },
            renderer = {
                group_empty = true,
                highlight_git = true,
                indent_markers = {
                    enable = true,
                },
                icons = {
                    git_placement = "after",
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                },
            },
            filters = {
                dotfiles = false,
                git_ignored = false,
            },
            actions = {
                open_file = {
                    quit_on_open = false,
                    resize_window = true,
                },
            },
        },
    },
}
