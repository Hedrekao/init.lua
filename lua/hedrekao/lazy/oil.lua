return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  opts = {
    use_default_keymaps = false,
    keymaps = {
      ["<CR>"] = "actions.select",
      ["<C-s>"] = { "actions.select", opts = { vertical = true } },
      ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
      ["<C-t>"] = { "actions.select", opts = { tab = true } },
      ["<C-S-p>"] = "actions.preview",
      ["<C-c>"] = { "actions.close", mode = "n" },
      ["<C-l>"] = "actions.refresh",
      ["-"] = { "actions.parent", mode = "n" },
      ["_"] = { "actions.open_cwd", mode = "n" },
      ["`"] = { "actions.cd", mode = "n" },
      ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
      ["g?"] = { "actions.show_help", mode = "n" },
      ["gs"] = { "actions.change_sort", mode = "n" },
      ["gx"] = "actions.open_external",
      ["g."] = { "actions.toggle_hidden", mode = "n" },
      ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, _)
        return name:match "%.git$" or name:match "%.class"
      end
    }
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
}
