local opt = vim.opt

opt.number = false
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "auto"
opt.updatetime = 250
opt.timeoutlen = 400
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.inccommand = "split"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.confirm = true
opt.termguicolors = true
opt.winborder = "rounded"
opt.completeopt = { "menuone", "noselect", "popup" }
opt.fillchars:append({ eob = " " })
opt.laststatus = 0
opt.cmdheight = 0

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

-- Keep diagnostics readable without pushing messages into the source text.
-- Each diagnostic is rendered on a virtual row immediately above its line.
local diagnostic_namespace = vim.api.nvim_create_namespace("everforest_diagnostics_above")
local diagnostic_highlights = {
    [vim.diagnostic.severity.ERROR] = "DiagnosticVirtualTextError",
    [vim.diagnostic.severity.WARN] = "DiagnosticVirtualTextWarn",
    [vim.diagnostic.severity.INFO] = "DiagnosticVirtualTextInfo",
    [vim.diagnostic.severity.HINT] = "DiagnosticVirtualTextHint",
}
local diagnostic_icons = {
    [vim.diagnostic.severity.ERROR] = "󰅚 ",
    [vim.diagnostic.severity.WARN] = "󰀪 ",
    [vim.diagnostic.severity.INFO] = "󰋽 ",
    [vim.diagnostic.severity.HINT] = "󰌶 ",
}

vim.diagnostic.handlers["everforest/virtual_lines_above"] = {
    show = function(_, bufnr, diagnostics)
        vim.api.nvim_buf_clear_namespace(bufnr, diagnostic_namespace, 0, -1)
        for _, diagnostic in ipairs(diagnostics) do
            local message = diagnostic.message:gsub("\n", " ")
            vim.api.nvim_buf_set_extmark(bufnr, diagnostic_namespace, diagnostic.lnum, 0, {
                virt_lines = {
                    {
                        {
                            (diagnostic_icons[diagnostic.severity] or "") .. message,
                            diagnostic_highlights[diagnostic.severity],
                        },
                    },
                },
                virt_lines_above = true,
                virt_lines_overflow = "scroll",
            })
        end
    end,
    hide = function(_, bufnr)
        vim.api.nvim_buf_clear_namespace(bufnr, diagnostic_namespace, 0, -1)
    end,
}

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
    ["everforest/virtual_lines_above"] = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
