-- Create a file: lua/plugins/go.lua
return {
    {
        "ray-x/go.nvim",
        dependencies = {
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        ft = { "go", "gomod", "gosum", "gowork" },
        config = function()
            require("go").setup({
                -- Add your go configuration here
                lsp_cfg = true,
                lsp_gofumpt = true,
                lsp_on_attach = true,
                dap_debug = true,
            })

            -- Run gofmt + goimport on save
            local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    require("go.format").goimport()
                end,
                group = format_sync_grp,
            })
        end,
    },
}
