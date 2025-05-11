return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      servers = {
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
              schemas = {
                ["https://raw.githubusercontent.com/argoproj/argo-cd/master/manifests/crds/application-crd.json"] = {
                  "**/argo-cd.yaml",
                  "**/argo-*.yaml",
                  "**/argocd-*.yaml",
                  "**/applicationset*.yaml",
                },
                ["https://raw.githubusercontent.com/argoproj/argo-cd/master/manifests/crds/applicationset-crd.json"] = {
                  "**/applicationset*.yaml",
                  "**/argo-cd.yaml",
                },
                kubernetes = "*.yaml",
              },
              customTags = {
                "!reference sequence",
              },
              validate = true,
              schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
              },
            },
          },
        },
      },
    },
  },
}
