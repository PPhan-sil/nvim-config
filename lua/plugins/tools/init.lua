local conf = require("plugins.tools.config")

return {
  {
    "DreamMaoMao/yazi.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    config = conf.markdown(),
  },
  {
    "lervag/vimtex",
    ft = "tex",
    opts = conf.vimtex(),
  },
  {
    "norcalli/nvim-colorizer.lua",
    -- ft = "tex",
    config = conf.colorizer(),
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre " .. vim.fn.expand "~" .. "/Documents/Vault/**.md",
      "BufNewFile " .. vim.fn.expand "~" .. "/Documents/Vault/**.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "Notes",
          path = "~/Documents/Vault/Notes",
          overrides = {
            notes_subdir = "Notes",
          },
        },
        {
          name = "Academics",
          path = "~/Documents/Vault/Academics",
          overrides = {
            notes_subdir = "Notes",
          },
        },
      },

      templates = {
        subdir = "Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },

      image_name_func = function()
        -- Prefix image names with timestamp.
        return string.format(os.time(), "-%s")
      end,

      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        -- vim.fn.jobstart({ "open", url }) -- Mac OS
        vim.fn.jobstart({ "xdg-open", url }) -- linux
      end,

      note_frontmatter_func = function(note)
        -- This is equivalent to the default frontmatter function.
        local out = { id = note.id, aliases = note.aliases, tags = note.tags, created = os.date("%Y-%m-%d %H:%M") }
        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,

      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "_"):gsub("[^A-Za-z0-9_]", "")
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
    },
  }
}
