-- Create a file: lua/plugins/dap.lua
return {
    -- Debug Adapter Protocol client for Neovim
    "mfussenegger/nvim-dap",
    dependencies = {
        -- UI for DAP
        {
            "rcarriga/nvim-dap-ui",
            dependencies = {
                -- Required dependency for dap-ui
                "nvim-neotest/nvim-nio",
            },
        },
        -- Virtual text for DAP
        { "theHamsta/nvim-dap-virtual-text" },
        -- Mason integration
        { "jay-babu/mason-nvim-dap.nvim" },
        -- Go debugger
        { "leoluz/nvim-dap-go" },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local wk = require("which-key")

        -- Set up the UI
        dapui.setup()

        -- Set up virtual text
        require("nvim-dap-virtual-text").setup()

        -- Set up Go debugging
        require("dap-go").setup()

        -- Set up Mason DAP
        require("mason-nvim-dap").setup({
            ensure_installed = { "delve", "codelldb" },
            automatic_installation = true,
        })

        -- Auto open/close dapui
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- Add which-key mappings for debugger
        wk.register({
            { "<leader>d", group = "[D]ebug" },
            {
                "<leader>dc",
                function()
                    dap.continue()
                end,
                desc = "[D]ebug: [C]ontinue",
            },
            {
                "<leader>dn",
                function()
                    dap.step_over()
                end,
                desc = "[D]ebug: Step [N]ext",
            },
            {
                "<leader>ds",
                function()
                    dap.step_into()
                end,
                desc = "[D]ebug: [S]tep Into",
            },
            {
                "<leader>do",
                function()
                    dap.step_out()
                end,
                desc = "[D]ebug: Step [O]ut",
            },
            {
                "<leader>db",
                function()
                    dap.toggle_breakpoint()
                end,
                desc = "[D]ebug: Toggle [B]reakpoint",
            },
            {
                "<leader>dB",
                function()
                    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
                end,
                desc = "[D]ebug: Conditional [B]reakpoint",
            },
            {
                "<leader>dl",
                function()
                    dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
                end,
                desc = "[D]ebug: [L]ogpoint",
            },
            {
                "<leader>dr",
                function()
                    dap.repl.open()
                end,
                desc = "[D]ebug: Open [R]EPL",
            },
            {
                "<leader>du",
                function()
                    dapui.toggle()
                end,
                desc = "[D]ebug: Toggle [U]I",
            },
        })
    end,
}
