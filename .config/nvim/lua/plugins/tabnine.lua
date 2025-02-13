return {
  {
    "codota/tabnine-nvim",
    build = "./dl_binaries.sh",
    event = { "InsertEnter", "BufRead" },
    config = function()
      require("tabnine").setup({
        disable_auto_comment = true,
        accept_keymap = "<Tab>",
        dismiss_keymap = "<C-]>",
        debounce_ms = 800,
        suggestion_color = { gui = "#808080", cterm = 244 },
        exclude_filetypes = { "TelescopePrompt", "NvimTree" },
        log_file_path = nil,

        hub = {
          host = "https://api.tabnine.com",
          certificate_path = nil,
        },

        capabilities = {
          suggestion = true,
          completion = true,
          semantic = true,
          learning = true,
        },
      })

      -- Set up completion after TabNine is initialized
      local ok, cmp = pcall(require, "cmp")
      if ok then
        local sources = cmp.get_config().sources or {}
        table.insert(sources, { name = "tabnine", group_index = 2, priority = 750 })

        cmp.setup({
          sources = sources,
        })
      end

      -- Optional: Add custom keymaps
      vim.keymap.set("n", "<leader>te", ":TabnineEnable<CR>", { desc = "Enable Tabnine" })
      vim.keymap.set("n", "<leader>td", ":TabnineDisable<CR>", { desc = "Disable Tabnine" })
      vim.keymap.set("n", "<leader>ts", ":TabnineStatus<CR>", { desc = "Tabnine Status" })
    end,
  },
}
