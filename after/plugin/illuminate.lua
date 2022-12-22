vim.g.Illuminate_ftblacklist = {'NvimTree', 'lua'}
vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

require("illuminate").configure({
    delay = 0,
    filetypes_denylist = {
        "alpha",
        "NvimTree",
        "Trouble",
        "toggleterm",
        "TelescopePrompt",
    },
})
