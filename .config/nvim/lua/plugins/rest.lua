local wk = require("which-key")
wk.register({
  ["<leader>r"] = {
    name = "+rest",
    r = { "<cmd>Rest run<cr>", "Run request under the cursor" },
    l = { "<cmd>Rest run last<cr>", "Re-run latest request" },
  },
})

return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
    },
  },
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    lazy = false,
    dependencies = { "luarocks.nvim" },
    config = function()
      require("rest-nvim").setup()
    end,
  },
}
