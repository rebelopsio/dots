return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "saghen/blink.cmp",
        lazy = false,
        version = "*",
        opts = {
          keymap = {
            preset = "enter",
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<Tab>"] = { "select_next", "fallback" },
          },
          sources = {
            default = { "lsp", "path", "buffer", "codecompanion" },
            cmdline = {}, -- Disable sources for command-line mode
          },
        },
      },
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "cmd:op read --account my.1password.com op://private/Anthropic/credential --no-newline",
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = "anthropic",
          },
          inline = {
            adapter = "anthropic",
          },
          cmd = {
            adapter = "anthropic",
          },
        },
      })
      require("which-key").add({
        { "<leader>C", group = "codecompanion" },
        { "<leader>CC", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat", mode = "n" },
        { "<C-a>", "<cmd>CodeCompanionActions<cr>", desc = "Actions" },
        { "<leader>CC", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat", mode = "v" },
        { "ga", "<cmd>CodeCompanionChat Add<cr>", desc = "Add to Chat", mode = "v" },
      })
    end,
  },
}
