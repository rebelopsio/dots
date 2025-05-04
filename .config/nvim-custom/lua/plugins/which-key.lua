return { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function()
        local wk = require("which-key")

        -- Load fzf-lua in a protected call
        local fzf_ok, fzf = pcall(require, "fzf-lua")

        -- Check if the module loaded successfully
        if not fzf_ok then
            vim.notify("fzf-lua not found. Please install the plugin first.", vim.log.levels.WARN)
        end

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
            window = {
                border = "rounded", -- none, single, double, shadow, rounded
                padding = { 1, 1, 1, 1 }, -- extra window padding
            },
            layout = {
                height = { min = 3, max = 25 }, -- min and max height of the columns
                width = { min = 20, max = 50 }, -- min and max width of the columns
                spacing = 3, -- spacing between columns
            },
        })

        -- Define FzfLua key mappings only if FzfLua is available
        if fzf_ok then
            -- Helper function to wrap fzf calls with error handling
            local function safe_fzf(func, ...)
                local args = { ... }
                return function()
                    -- Protected call to handle any errors
                    local status, err = pcall(function()
                        fzf[func](unpack(args))
                    end)

                    if not status then
                        vim.notify("FzfLua error: " .. tostring(err), vim.log.levels.ERROR)
                    end
                end
            end

            -- Main keybindings
            wk.register({
                -- Create a search group similar to your telescope configuration
                ["<leader>f"] = { name = "[F]ind with FzfLua" },
                ["<leader>s"] = { name = "[S]earch" },
                ["<leader>g"] = { name = "[G]it" },

                -- File finding
                ["<leader>ff"] = { safe_fzf("files"), "Find Files" },
                ["<leader>fr"] = { safe_fzf("oldfiles"), "Recent Files" },
                ["<leader>fp"] = { safe_fzf("git_files"), "Git Files" },
                ["<leader>fg"] = { safe_fzf("live_grep"), "Live Grep" },
                ["<leader>fb"] = { safe_fzf("buffers"), "Buffers" },

                -- Search group (matching your telescope structure)
                ["<leader>sh"] = { safe_fzf("help_tags"), "Help Tags" },
                ["<leader>sk"] = { safe_fzf("keymaps"), "Keymaps" },
                ["<leader>sf"] = { safe_fzf("files"), "Find Files" },
                ["<leader>ss"] = { safe_fzf("builtin"), "Select FzfLua" },
                ["<leader>sw"] = { safe_fzf("grep_cword"), "Search Current Word" },
                ["<leader>sg"] = { safe_fzf("live_grep"), "Live Grep" },
                ["<leader>sd"] = { safe_fzf("diagnostics_document"), "Document Diagnostics" },
                ["<leader>sD"] = { safe_fzf("diagnostics_workspace"), "Workspace Diagnostics" },
                ["<leader>sr"] = { safe_fzf("resume"), "Resume Last Search" },
                ["<leader>s."] = { safe_fzf("oldfiles"), "Recent Files" },
                ["<leader>s/"] = {
                    function()
                        fzf.grep_project({
                            prompt = "Grep Open Files> ",
                            cmd = "git ls-files --exclude-standard | xargs grep -l ''",
                        })
                    end,
                    "Search in Open Files",
                },

                -- Git commands
                ["<leader>gc"] = { safe_fzf("git_commits"), "Git Commits" },
                ["<leader>gb"] = { safe_fzf("git_branches"), "Git Branches" },
                ["<leader>gs"] = { safe_fzf("git_status"), "Git Status" },
                ["<leader>gf"] = { safe_fzf("git_files"), "Git Files" },
                ["<leader>gB"] = { safe_fzf("git_bcommits"), "Git Buffer Commits" },

                -- Special searches for your work
                ["<leader>st"] = {
                    function()
                        fzf.files({ cmd = "find . -name '*.tf' -o -name '*.hcl'" })
                    end,
                    "Terraform/HCL Files",
                },
                ["<leader>sr"] = {
                    function()
                        fzf.files({ cmd = "find . -name '*.rs'" })
                    end,
                    "Rust Files",
                },
                ["<leader>sg"] = {
                    function()
                        fzf.files({ cmd = "find . -name '*.go'" })
                    end,
                    "Go Files",
                },

                -- LSP related
                ["<leader>ls"] = { safe_fzf("lsp_document_symbols"), "Document Symbols" },
                ["<leader>lS"] = { safe_fzf("lsp_workspace_symbols"), "Workspace Symbols" },
                ["<leader>lr"] = { safe_fzf("lsp_references"), "References" },
                ["<leader>ld"] = { safe_fzf("lsp_definitions"), "Definitions" },
                ["<leader>lt"] = { safe_fzf("lsp_typedefs"), "Type Definitions" },
                ["<leader>li"] = { safe_fzf("lsp_implementations"), "Implementations" },

                -- Quick buffer search
                ["/"] = { safe_fzf("blines"), "Search in Current Buffer" },
                ["<leader>/"] = { safe_fzf("blines"), "Search in Current Buffer" },

                -- The classic ctrl-p (like vscode)
                ["<C-p>"] = { safe_fzf("files"), "Find Files (ctrl-p)" },

                -- Replacements for common telescope actions
                ["<leader><leader>"] = { safe_fzf("buffers"), "Find Buffers" },

                -- Special neovim config search
                ["<leader>sn"] = {
                    function()
                        fzf.files({ cwd = vim.fn.stdpath("config") })
                    end,
                    "Search Neovim Config",
                },

                -- Additional customizations for your workflow
                ["<leader>fk"] = { safe_fzf("tmux_buffers"), "Tmux Buffers" },
                ["<leader>fp"] = { safe_fzf("man_pages"), "Man Pages" },

                -- DevOps specific commands
                ["<leader>fpm"] = {
                    function()
                        fzf.grep_project({ search = "proxmox" })
                    end,
                    "Search Proxmox Files",
                },
                ["<leader>fk8"] = {
                    function()
                        fzf.grep_project({ search = "kubernetes|k8s" })
                    end,
                    "Search Kubernetes Files",
                },
                ["<leader>fgr"] = {
                    function()
                        fzf.grep_project({ search = "grafana|prometheus" })
                    end,
                    "Search Monitoring Files",
                },
                ["<leader>fdb"] = {
                    function()
                        fzf.grep_project({ search = "postgres|clickhouse" })
                    end,
                    "Search Database Files",
                },
                ["<leader>fcl"] = {
                    function()
                        fzf.grep_project({ search = "terraform|aws|gcp" })
                    end,
                    "Search Cloud Files",
                },
            })

            -- Group registrations for better organization in which-key display
            wk.register({
                f = { name = "FzfLua Find" },
                s = { name = "Search" },
                g = { name = "Git" },
                l = { name = "LSP" },
                t = { name = "Toggle" }, -- Keep existing toggle group
            }, { prefix = "<leader>" })
        else
            -- Fallback if FzfLua is not available
            vim.notify("FzfLua not available. Some keymaps were not registered.", vim.log.levels.WARN)
        end

        -- Keep your existing mappings for other functionality
        wk.register({
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
            ["grD"] = { vim.lsp.buf.declaration, "[D]eclaration" },

            -- Treesitter textobjects (swap)
            ["<leader>a"] = { name = "Swap parameter with next" },
            ["<leader>A"] = { name = "Swap parameter with previous" },

            -- Git operations
            ["<leader>gs"] = { "<cmd>Gitsigns stage_hunk<CR>", "[G]it [S]tage Hunk" },
            ["<leader>gr"] = { "<cmd>Gitsigns reset_hunk<CR>", "[G]it [R]eset Hunk" },
            ["<leader>gb"] = { "<cmd>Gitsigns blame_line<CR>", "[G]it [B]lame" },
            ["<leader>gd"] = { "<cmd>Gitsigns diffthis<CR>", "[G]it [D]iff" },

            -- File explorer
            ["<leader>e"] = { "<cmd>Oil<CR>", "Open file [E]xplorer" },

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
