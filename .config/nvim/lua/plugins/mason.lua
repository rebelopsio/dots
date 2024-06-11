return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "gopls",
        "black",
        "debugpy",
        "mypy",
        "ruff",
        "pyright",
        "yaml-language-server",
        "gofumpt",
        "golines",
        "goimports-reviser",
        "prettierd",
      })
    end,
  },
}
