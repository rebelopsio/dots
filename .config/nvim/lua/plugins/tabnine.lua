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
        max_num_results = 10,
        sort_results = true,
        run_in_background = true,
      })

      -- Optional: Add custom keymaps
      --vim.keymap.set("n", "<leader>te", ":TabnineEnable<CR>", { desc = "Enable Tabnine" })
      --vim.keymap.set("n", "<leader>td", ":TabnineDisable<CR>", { desc = "Disable Tabnine" })
      --vim.keymap.set("n", "<leader>ts", ":TabnineStatus<CR>", { desc = "Tabnine Status" })
    end,
  },
}
