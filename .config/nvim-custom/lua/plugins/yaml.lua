-- Create a file: lua/plugins/yaml.lua
return {
    {
        "someone-stole-my-name/yaml-companion.nvim",
        enabled = false,
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "nvim-lua/plenary.nvim" },
            --            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require("telescope").load_extension("yaml_schema")

            local cfg = require("yaml-companion").setup({
                -- Built-in schemas
                builtin_schemas = {
                    kubernetes = {
                        "deployment.yaml",
                        "service.yaml",
                        "k8s.yaml",
                        "*kubernetes*.yaml",
                        "kustomization.yaml",
                    },
                },
                -- Enable schema hover info
                lspconfig = {
                    settings = {
                        yaml = {
                            validate = true,
                            hover = true,
                            completion = true,
                        },
                    },
                },
            })

            -- Required for schema detection to work properly
            require("lspconfig")["yamlls"].setup(cfg)

            -- Add which-key mappings
            local wk = require("which-key")
            wk.register({
                ["<leader>y"] = {
                    name = "[Y]AML",
                    s = { "<cmd>Telescope yaml_schema<CR>", "YAML [S]chema" },
                },
            })
        end,
    },
}
