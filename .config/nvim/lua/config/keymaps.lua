-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-a>", ":Neotree focus<CR>", { desc = "Neotree focus", remap = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Better J" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page jumping down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page jumping up" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Better search jumping down" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Better search jumping up" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Better paste" })
