return {
  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
    },
    keys = {
      {
        "<leader>fd",
        function()
          local telescope = require("telescope")

          telescope.extensions.file_browser.file_browser({
            hidden = true,
            grouped = true,
          })
        end,
        desc = "File Browser",
      },
      {
        "<leader>pj",
        function()
          local telescope = require("telescope")
          telescope.extensions.project.project()
        end,
        desc = "Project Manager",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        initial_mode = "normal",
        winblend = 0,
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
          n = {
            l = actions.select_default,
            o = actions.select_default,
            q = actions.close,
            ["/"] = function()
              vim.cmd("startinsert")
            end,
          },
        },
      })
      opts.pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }
      opts.extensions = {
        file_browser = {
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            -- your custom insert mode mappings
            n = {
              -- your custom normal mode mappings
              h = fb_actions.goto_parent_dir,
            },
          },
        },
      }
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("project")
    end,
  },
}
