-- Create a new file: lua/plugins/snippets.lua
return {
  "rafamadriz/friendly-snippets",
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()

    local ls = require("luasnip")

    -- Custom snippets for Terraform
    ls.add_snippets("terraform", {
      ls.snippet("res", {
        ls.text_node({ 'resource "' }),
        ls.insert_node(1, "aws_resource_type"),
        ls.text_node('" "'),
        ls.insert_node(2, "resource_name"),
        ls.text_node({ '" {', "  " }),
        ls.insert_node(0),
        ls.text_node({ "", "}" }),
      }),

      ls.snippet("var", {
        ls.text_node({ 'variable "' }),
        ls.insert_node(1, "var_name"),
        ls.text_node({ '" {', "  type = " }),
        ls.insert_node(2, "string"),
        ls.text_node({ "", "  default = " }),
        ls.insert_node(3),
        ls.text_node({ "", '  description = "' }),
        ls.insert_node(4, "Description"),
        ls.text_node({ '"', "}" }),
      }),
    })
  end,
}
