local mason_servers = {
    "bashls",
    "basedpyright",
    "clangd",
    "lua_ls",
}

return {
    {
        "mason-org/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        cmd = {
            "Mason",
            "MasonInstall",
            "MasonUninstall",
            "MasonUpdate",
            "MasonLog",
        },
        dependencies = {
            "saghen/blink.cmp",
            {
                "mason-org/mason.nvim",
                opts = {
                    ui = {
                        border = "rounded",
                    },
                },
            },
            "neovim/nvim-lspconfig",
        },
        config = function()
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            vim.lsp.config("lua_ls", {
                root_dir = function(bufnr, on_dir)
                    local filename = vim.api.nvim_buf_get_name(bufnr)
                    local nvim_config = vim.fn.stdpath("config")
                    if vim.startswith(filename, nvim_config .. "/") then
                        on_dir(nvim_config)
                        return
                    end
                    local root = vim.fs.root(filename, {
                        ".luarc.json",
                        ".luarc.jsonc",
                        ".stylua.toml",
                        ".git",
                    })
                    on_dir(root or vim.fs.dirname(filename))
                end,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                            },
                        },
                    },
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = mason_servers,
                automatic_enable = mason_servers,
            })

            vim.lsp.config("gdscript", {
                cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
                filetypes = { "gdscript" },
                root_markers = { "project.godot", ".git" },
            })
            vim.lsp.enable("gdscript")

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("everforest_lsp_attach", { clear = true }),
                callback = function(event)
                    local opts = { buffer = event.buf, silent = true }

                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
                    vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
                    vim.keymap.set("n", "gl", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
                    vim.keymap.set("n", "<leader>li", "<cmd>checkhealth vim.lsp<CR>", vim.tbl_extend(
                        "force",
                        opts,
                        { desc = "LSP information" }
                    ))
                end,
            })
        end,
    },
}
