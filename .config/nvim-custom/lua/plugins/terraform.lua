return {
    {
        "hashivim/vim-terraform",
        ft = { "terraform", "tf", "hcl" },
        config = function()
            -- Enable terraform auto formatting on save
            vim.g.terraform_fmt_on_save = 1
            -- Enable terraform alignment for = signs
            vim.g.terraform_align = 1
        end,
    },
}
