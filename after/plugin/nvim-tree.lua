local gwidth = vim.api.nvim_list_uis()[1].width
local gheight = vim.api.nvim_list_uis()[1].height
local width = 80
local height = 40

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    float = {
        enable = true,
        open_win_config = {
            relative = "editor",
            width = width,
            height = height,
            row = (gheight - height) * 0.4,
            col = (gwidth - width) * 0.5,
        }
    },
    width = 80,
    height = 100
  },
  renderer = {
     indent_markers = {
      enable = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        none = " ",
      },
    },
    icons = {
          webdev_colors = true,
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            git = {
              deleted = "",
              ignored = "◌",
              renamed = "➜",
              staged = "S",
              unmerged = "",
              unstaged = "",
              untracked = "U",
            },
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
            }
          }
        }
  },
  git = {
      enable = true,
      ignore = false
  },
  filters = {
      dotfiles = false
  }
})
