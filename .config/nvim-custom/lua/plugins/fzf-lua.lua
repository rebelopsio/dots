return {
    "ibhagwan/fzf-lua",
    -- Load immediately to avoid startup issues
    lazy = false,
    -- Recommended dependencies
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- Optional for file icons
        "junegunn/fzf", -- You can use the system's fzf as well by setting fzf_bin option
    },
    config = function()
        local fzf = require("fzf-lua")

        -- Basic configuration
        fzf.setup({
            -- Common options
            global_resume = true, -- Enable global resume across different pickers
            global_resume_query = true, -- Include query when resuming
            winopts = {
                -- Window layouts, similar to Telescope
                height = 0.85,
                width = 0.80,
                row = 0.35, -- Position in the middle of the screen
                col = 0.5, -- Center horizontally
                border = "rounded",
                preview = {
                    hidden = "nohidden",
                    vertical = "down:45%", -- Up/down/left/right and percentage
                    layout = "flex", -- Flex the layout direction based on window width
                    flip_columns = 120, -- Flip to horizontal when width > columns
                    scrollbar = "float",
                },
                -- If you're using a Nerd Font
                hl = {
                    normal = "Normal",
                    border = "FloatBorder",
                    cursor = "Cursor",
                    cursorline = "CursorLine",
                    search = "Search",
                    title = "Title",
                },
                -- Fix for the window disappearing
                on_create = function()
                    -- Disable folding in the fzf buffer
                    vim.opt_local.foldenable = false
                    -- Prevent any autocommands from closing the window
                    vim.opt_local.bufhidden = "wipe"
                end,
            },
            keymap = {
                -- General mappings
                builtin = {
                    ["<C-/>"] = "toggle-help",
                    ["<C-d>"] = "preview-page-down",
                    ["<C-u>"] = "preview-page-up",
                    ["<C-q>"] = "select-all+accept",
                    -- Fix for escape key handling
                    ["<esc>"] = "close",
                    ["<c-c>"] = "close",
                },
                fzf = {
                    -- FZF-specific mappings
                    ["ctrl-/"] = "toggle-help",
                    ["ctrl-d"] = "half-page-down",
                    ["ctrl-u"] = "half-page-up",
                    ["ctrl-q"] = "select-all+accept",
                    -- Fix for escape key handling in fzf
                    ["esc"] = "abort",
                    ["ctrl-c"] = "abort",
                },
            },
            -- Your theme
            fzf_colors = {
                ["fg"] = { "fg", "Normal" },
                ["bg"] = { "bg", "Normal" },
                ["preview-fg"] = { "fg", "Normal" },
                ["preview-bg"] = { "bg", "Normal" },
                ["hl"] = { "fg", "Statement" },
                ["fg+"] = { "fg", "CursorLine" },
                ["bg+"] = { "bg", "CursorLine" },
                ["hl+"] = { "fg", "Statement" },
                ["info"] = { "fg", "Comment" },
                ["border"] = { "fg", "FloatBorder" },
                ["prompt"] = { "fg", "Function" },
                ["pointer"] = { "fg", "Statement" },
                ["marker"] = { "fg", "Keyword" },
                ["spinner"] = { "fg", "Comment" },
                ["header"] = { "fg", "Comment" },
            },
            -- File-specific options
            files = {
                file_icons = true, -- Show file icons
                git_icons = true, -- Show git icons
                color_icons = true, -- colorize file icons
                find_opts = [[-type f -not -path "*/\.git/*" -not -path "*/node_modules/*" -not -path "*/target/*"]],
                fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude target",
            },
            -- Git options
            git = {
                status = {
                    cmd = "git status -s",
                    file_icons = true,
                    git_icons = true,
                },
                commits = {
                    cmd = "git log --pretty=oneline --abbrev-commit --color",
                    preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
                },
            },
            -- Add support for Terramate and Terraform
            previewers = {
                builtin = {
                    extensions = {
                        -- Add terramate/terraform syntax highlighting
                        ["tf"] = "bat",
                        ["hcl"] = "bat",
                        ["tm.hcl"] = "bat", -- terramate files
                    },
                },
            },
            -- If you're using the Catppuccin theme, this will match well
            fzf_opts = {
                ["--layout"] = "reverse",
                ["--info"] = "inline",
                ["--pointer"] = "→",
                -- Add these options to prevent issues with window disappearing
                ["--keep-right"] = "",
                ["--no-height"] = "",
                ["--no-separator"] = "",
                ["--no-scrollbar"] = "",
            },

            -- Improve performance and prevent hanging
            fn_pre_fzf = function()
                -- Disable all autocommands temporarily while fzf runs
                vim.cmd("noautocmd")
            end,

            fn_post_fzf = function()
                -- Re-enable autocommands after fzf closes
                vim.cmd("doautocmd all")
            end,
        })

        -- Set up which-key integration after fzf-lua is configured
        -- but handled in which-key.lua
    end,
}
