local group = vim.api.nvim_create_augroup("everforest_user", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    desc = "Briefly highlight yanked text",
    callback = function()
        vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    desc = "Return to the last cursor position",
    callback = function(event)
        local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(event.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "gdscript" },
    desc = "Use Godot's tab-oriented indentation",
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
    end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    desc = "Show a small built-in start screen and right-side file tree",
    callback = function()
        if vim.fn.argc() ~= 0 or vim.api.nvim_buf_get_name(0) ~= "" then
            return
        end

        local buffer = vim.api.nvim_get_current_buf()
        local content = {
            [[       (        )          (                   (       *     ]],
            [[   (   )\ )  ( /(  (       )\ )                )\ )  (  `    ]],
            [[ ( )\ (()/(  )\()) )\ )   (()/(  (     (   (  (()/(  )\))(   ]],
            [[ )((_) /(_))((_)\ (()/(    /(_)) )\    )\  )\  /(_))((_)()\  ]],
            [[((_)_ (_))   _((_) /(_))_ (_))  ((_)  ((_)((_)(_))  (_()((_) ]],
            [[ | _ )|_ _| | \| |(_)) __|| |   | __| \ \ / / |_ _| |  \/  | ]],
            [[ | _ \ | |  | .` |  | (_ || |__ | _|   \ V /   | |  | |\/| | ]],
            [[ |___/|___| |_|\_|   \___||____||___|   \_/   |___| |_|  |_| ]],
            "",
            [[ a neo-post-utilitarian-luddite editor]],
            "",
            "Find",
            "   f   files                 g   text",
            "   r   recent files          e   file explorer",
            "",
            "Tools",
            "   m   Mason                 ?   keybinding guide",
            "   q   quit",
            "",
            "   ~/.config/nvim",
            "",
            "   © BINGLECORP LLC"
        }

        vim.bo[buffer].buftype = "nofile"
        vim.bo[buffer].bufhidden = "wipe"
        vim.bo[buffer].swapfile = false
        vim.bo[buffer].filetype = "everforest_start"
        vim.wo.cursorline = false
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.wo.signcolumn = "no"
        vim.wo.foldcolumn = "0"

        local function buffer_map(key, command, desc)
            vim.keymap.set("n", key, command, { buffer = buffer, silent = true, desc = desc })
        end

        buffer_map("f", "<cmd>Telescope find_files<CR>", "Find files")
        buffer_map("g", "<cmd>Telescope live_grep<CR>", "Search text")
        buffer_map("r", "<cmd>Telescope oldfiles<CR>", "Recent files")
        buffer_map("e", "<cmd>NvimTreeToggle<CR>", "Toggle file explorer")
        buffer_map("m", "<cmd>Mason<CR>", "Open Mason")
        buffer_map("?", "<cmd>WhichKey<CR>", "Open keybinding guide")
        buffer_map("q", "<cmd>quit<CR>", "Quit")

        vim.schedule(function()
            if vim.api.nvim_buf_is_valid(buffer) then
                vim.cmd("NvimTreeOpen")
                vim.cmd("wincmd p")

                local window = vim.fn.bufwinid(buffer)
                if window == -1 then
                    return
                end

                local width = vim.api.nvim_win_get_width(window)
                local lines = {}
                local top_padding = 3
                local left_padding = math.min(4, math.max(0, width - 1))

                for _ = 1, top_padding do
                    table.insert(lines, "")
                end
                for _, line in ipairs(content) do
                    table.insert(lines, string.rep(" ", left_padding) .. line)
                end

                vim.bo[buffer].modifiable = true
                vim.api.nvim_buf_set_lines(buffer, 0, -1, false, lines)
                vim.bo[buffer].modifiable = false
                local namespace = vim.api.nvim_create_namespace("everforest_start")
                for row = top_padding, top_padding + 7 do
                    vim.api.nvim_buf_add_highlight(
                        buffer,
                        namespace,
                        "EverforestSplashTitle",
                        row,
                        left_padding,
                        -1
                    )
                end
                vim.api.nvim_buf_add_highlight(
                    buffer,
                    namespace,
                    "EverforestSplashSubtitle",
                    top_padding + 9,
                    left_padding,
                    -1
                )
                vim.api.nvim_buf_add_highlight(
                    buffer,
                    namespace,
                    "EverforestSplashCopyright",
                    top_padding + #content - 1,
                    left_padding,
                    -1
                )
                vim.api.nvim_set_current_win(window)
                vim.api.nvim_win_set_cursor(window, { top_padding + 12, left_padding })
            end
        end)
    end,
})
