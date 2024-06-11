return {
  "someone-stole-my-name/yaml-companion.nvim",
  lazy = false,
  dependencies = {
    { "neovim/nvim-lspconfig" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
  },
  config = function()
    require("telescope").load_extension("yaml_schema")
  end,
  keys = {
    { "n", "<leader>ys", ":Telescope yaml_schema<CR>", { noremap = true } },
    { "n", "<leader>yu", ":lua require('yaml-companion').open_ui_select()<CR>", { noremap = true } },
  },
}
