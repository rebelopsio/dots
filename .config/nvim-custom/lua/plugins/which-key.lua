return { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function()
        local wk = require("which-key")
        wk.setup({
            -- delay between pressing a key and opening which-key (milliseconds)
            -- this setting is independent of vim.opt.timeoutlen
            delay = 0,
            icons = {
                -- set icon mappings to true if you have a Nerd Font
                mappings = vim.g.have_nerd_font,
                -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
                -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
                keys = vim.g.have_nerd_font and {} or {
                    Up = "<Up> ",
                    Down = "<Down> ",
                    Left = "<Left> ",
                    Right = "<Right> ",
                    C = "<C-…> ",
                    M = "<M-…> ",
                    D = "<D-…> ",
                    S = "<S-…> ",
                    CR = "<CR> ",
                    Esc = "<Esc> ",
                    ScrollWheelDown = "<ScrollWheelDown> ",
                    ScrollWheelUp = "<ScrollWheelUp> ",
                    NL = "<NL> ",
                    BS = "<BS> ",
                    Space = "<Space> ",
                    Tab = "<Tab> ",
                    F1 = "<F1>",
                    F2 = "<F2>",
                    F3 = "<F3>",
                    F4 = "<F4>",
                    F5 = "<F5>",
                    F6 = "<F6>",
                    F7 = "<F7>",
                    F8 = "<F8>",
                    F9 = "<F9>",
                    F10 = "<F10>",
                    F11 = "<F11>",
                    F12 = "<F12>",
                },
            },
        })

        -- Register groups and mappings using the old format
        wk.register({
            -- Search related mappings
            ["<leader>s"] = { name = "[S]earch" },
            ["<leader>sh"] = { "<cmd>Telescope help_tags<CR>", "[S]earch [H]elp" },
            ["<leader>sk"] = { "<cmd>Telescope keymaps<CR>", "[S]earch [K]eymaps" },
            ["<leader>sf"] = { "<cmd>Telescope find_files<CR>", "[S]earch [F]iles" },
            ["<leader>ss"] = { "<cmd>Telescope builtin<CR>", "[S]earch [S]elect Telescope" },
            ["<leader>sw"] = { "<cmd>Telescope grep_string<CR>", "[S]earch current [W]ord" },
            ["<leader>sg"] = { "<cmd>Telescope live_grep<CR>", "[S]earch by [G]rep" },
            ["<leader>sd"] = { "<cmd>Telescope diagnostics<CR>", "[S]earch [D]iagnostics" },
            ["<leader>sr"] = { "<cmd>Telescope resume<CR>", "[S]earch [R]esume" },
            ["<leader>s."] = { "<cmd>Telescope oldfiles<CR>", "[S]earch Recent Files" },
            ["<leader>s/"] = {
                function()
                    require("telescope.builtin").live_grep({
                        grep_open_files = true,
                        prompt_title = "Live Grep in Open Files",
                    })
                end,
                "[S]earch [/] in Open Files",
            },
            ["<leader>sn"] = {
                function()
                    require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
                end,
                "[S]earch [N]eovim files",
            },

            -- Files and buffers
            ["<leader><leader>"] = { "<cmd>Telescope buffers<CR>", "Find existing buffers" },
            ["<leader>/"] = {
                function()
                    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                        winblend = 10,
                        previewer = false,
                    }))
                end,
                "Fuzzy search in buffer",
            },

            -- Toggles
            ["<leader>t"] = { name = "[T]oggle" },
            ["<leader>th"] = {
                function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end,
                "[T]oggle Inlay [H]ints",
            },

            -- LSP and code actions
            ["<leader>f"] = {
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                "[F]ormat buffer",
            },
            ["<leader>q"] = { vim.diagnostic.setloclist, "Open diagnostic [Q]uickfix list" },

            -- LSP goto mappings prefixed with g
            ["gr"] = { name = "[G]oto [R]eferences" },
            ["grn"] = { vim.lsp.buf.rename, "[R]e[n]ame" },
            ["gra"] = { vim.lsp.buf.code_action, "Code [A]ction" },
            ["grr"] = {
                function()
                    require("telescope.builtin").lsp_references()
                end,
                "[R]eferences",
            },
            ["gri"] = {
                function()
                    require("telescope.builtin").lsp_implementations()
                end,
                "[I]mplementation",
            },
            ["grd"] = {
                function()
                    require("telescope.builtin").lsp_definitions()
                end,
                "[D]efinition",
            },
            ["grD"] = { vim.lsp.buf.declaration, "[D]eclaration" },
            ["grt"] = {
                function()
                    require("telescope.builtin").lsp_type_definitions()
                end,
                "[T]ype Definition",
            },

            -- Document Symbols
            ["gO"] = {
                function()
                    require("telescope.builtin").lsp_document_symbols()
                end,
                "Document Symbols",
            },
            ["gW"] = {
                function()
                    require("telescope.builtin").lsp_dynamic_workspace_symbols()
                end,
                "Workspace Symbols",
            },

            -- Treesitter textobjects (swap)
            ["<leader>a"] = { name = "Swap parameter with next" },
            ["<leader>A"] = { name = "Swap parameter with previous" },

            -- Git operations
            ["<leader>g"] = { name = "[G]it" },
            ["<leader>gs"] = { "<cmd>Gitsigns stage_hunk<CR>", "[G]it [S]tage Hunk" },
            ["<leader>gr"] = { "<cmd>Gitsigns reset_hunk<CR>", "[G]it [R]eset Hunk" },
            ["<leader>gb"] = { "<cmd>Gitsigns blame_line<CR>", "[G]it [B]lame" },
            ["<leader>gd"] = { "<cmd>Gitsigns diffthis<CR>", "[G]it [D]iff" },

            -- File explorer
            ["<leader>e"] = { "<cmd>Oil<CR>", "Open file [E]xplorer" },

            -- Terminal
            -- ["<leader>tt"] = { "<cmd>ToggleTerm<CR>", "Toggle Terminal" },
            -- ["<leader>tf"] = { "<cmd>ToggleTerm direction=float<CR>", "Float Terminal" },
            -- ["<leader>th"] = { "<cmd>ToggleTerm direction=horizontal<CR>", "Horizontal Terminal" },
            -- ["<leader>tv"] = { "<cmd>ToggleTerm direction=vertical<CR>", "Vertical Terminal" },

            -- Debug
            ["<leader>d"] = { name = "[D]ebug" },
            ["<leader>db"] = {
                function()
                    require("dap").toggle_breakpoint()
                end,
                "[D]ebug: Toggle [B]reakpoint",
            },
            ["<leader>dc"] = {
                function()
                    require("dap").continue()
                end,
                "[D]ebug: [C]ontinue",
            },
            ["<leader>do"] = {
                function()
                    require("dap").step_over()
                end,
                "[D]ebug: Step [O]ver",
            },
            ["<leader>di"] = {
                function()
                    require("dap").step_into()
                end,
                "[D]ebug: Step [I]nto",
            },
            ["<leader>du"] = {
                function()
                    require("dapui").toggle()
                end,
                "[D]ebug: Toggle [U]I",
            },
            ["<leader>do"] = { name = "[DO]cker" },
            ["<leader>doc"] = { "<cmd>Docker containers<CR>", "[DO]cker [C]ontainers" },
            ["<leader>doi"] = { "<cmd>Docker images<CR>", "[DO]cker [I]mages" },
            ["<leader>tf"] = { name = "[T]erra[F]orm" },
            ["<leader>tff"] = { "<cmd>!terraform fmt<CR>", "[T]erraform [F]ormat" },
            ["<leader>tfv"] = { "<cmd>!terraform validate<CR>", "[T]erraform [V]alidate" },
            ["<leader>tfi"] = { "<cmd>!terraform init<CR>", "[T]erraform [I]nit" },
            ["<leader>tfp"] = { "<cmd>!terraform plan<CR>", "[T]erraform [P]lan" },
            ["<leader>k"] = { name = "[K]ubernetes" },
            ["<leader>kc"] = { "<cmd>Kube context<CR>", "[K]ubernetes [C]ontext" },
            ["<leader>kn"] = { "<cmd>Kube namespace<CR>", "[K]ubernetes [N]amespace" },
        })
    end,
}
