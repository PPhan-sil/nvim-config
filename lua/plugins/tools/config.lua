local config = {}

function config.vimtex()
  return function()
    vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_quickfix_enabled = 0
    -- vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
    vim.g.vimtex_syntax_enabled = 0
    vim.g.vimtex_compiler_latexmk = {
      options = {
        -- "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-shell-escape",
      },
    }
  end
end

function config.obsidian()
  return function()
    return {
      ui = { enabled = false },
      workspaces = {
        -- {
        --   name = "Notes",
        --   path = "~/Sync/Vault/Notes",
        --   overrides = {
        --     notes_subdir = "Notes",
        --   },
        -- },
        {
          name = "Notes",
          path = "~/Documents/Vault/00 Notes",
          overrides = {
            notes_subdir = "00 Notes",
          },
        },
      },
      --
      -- Where to put new notes. Valid options are
      --  * "current_dir" - put new notes in same directory as the current buffer.
      --  * "notes_subdir" - put new notes in the default notes subdirectory.
      new_notes_location = "notes_subdir",

      templates = {
        subdir = "04 Templates",
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
        if vim.fn.has("mac") == 1 then
          vim.fn.jobstart({ "open", url }) -- Mac OS
        elseif vim.fn.jobstart({ "xdg-open", url }) == 1 then
          vim.fn.jobstart({ "xdg-open", url }) -- linux
        end
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
    }
  end
end

return config
