return {
    {
        "sainnhe/everforest",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.everforest_background = "hard"
            vim.g.everforest_better_performance = 1
            vim.g.everforest_enable_italic = 1
            vim.g.everforest_transparent_background = 1
            vim.cmd.colorscheme("everforest")

            -- Splash screen colors
            vim.api.nvim_set_hl(0, "EverforestSplashTitle", {
              fg = "#E69875",
              bold = true,
            })

            vim.api.nvim_set_hl(0, "EverforestSplashSubtitle", {
              fg = "#A7C080",
              italic = true,
            })

            vim.api.nvim_set_hl(0, "EverforestSplashCopyright", {
              fg = "#DBBC7F",
            })

            -- Keep every form of an error on the official Everforest red.
            vim.api.nvim_set_hl(0, "DiagnosticError", {
                fg = "#E67E80",
            })
            vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {
                fg = "#E67E80",
                bg = "NONE",
            })
            vim.api.nvim_set_hl(0, "DiagnosticSignError", {
                fg = "#E67E80",
                bg = "NONE",
            })
            vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
                sp = "#E67E80",
                undercurl = true,
            })

            -- Floating completion surfaces use one consistent glass treatment;
            -- their 10% blend stays close to Ghostty's 88% background opacity.
            for _, group in ipairs({
                "BlinkCmpMenu",
                "BlinkCmpMenuBorder",
                "BlinkCmpDoc",
                "BlinkCmpDocBorder",
                "BlinkCmpSignatureHelp",
                "BlinkCmpSignatureHelpBorder",
            }) do
                vim.api.nvim_set_hl(0, group, { bg = "NONE" })
            end
            vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", {
                bg = "#374145",
                bold = true,
            })
        end,
    },
}
