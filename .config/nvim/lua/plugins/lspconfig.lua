return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      servers = { yamlls = { settings = { yaml = { keyOrdering = false } } } },
    },
  },
}
