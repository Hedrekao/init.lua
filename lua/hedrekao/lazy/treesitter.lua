return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      -- Enable treesitter highlighting for all supported filetypes
      local ignore = {
        "oil",
        "trouble",
        "fzf",
        "qf", -- Quickfix list
        "NvimTree",
        "lazy",
        "mason",
        "help"
      }
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("Hedrekao_Treesitter", {}),
        pattern = "*",
        callback = function()
          -- Enable treesitter highlighting
          if vim.tbl_contains(ignore, vim.bo.filetype) then
            return
          end

          pcall(vim.treesitter.start)
          -- Enable treesitter-based indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
    init = function()
      local ensureInstalled = {
        'lua', 'python', 'typescript', 'markdown', "terraform", 'javascript', 'json',
      }
      local alreadyInstalled = require('nvim-treesitter.config').get_installed()
      local parsersToInstall = vim.iter(ensureInstalled)
          :filter(function(parser)
            return not vim.tbl_contains(alreadyInstalled, parser)
          end)
          :totable()
      require('nvim-treesitter').install(parsersToInstall)
    end,
  },
  -- {
  -- 	"nvim-treesitter/nvim-treesitter-context",
  -- 	dependencies = { "nvim-treesitter/nvim-treesitter" },
  -- 	config = function()
  -- 		vim.keymap.set("n", "[c", function()
  -- 			require("treesitter-context").go_to_context()
  -- 		end, { silent = true })
  -- 	end,
  -- },
}
