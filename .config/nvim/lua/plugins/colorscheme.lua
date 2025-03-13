return {
  -- Catppuccin theme plugin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,  -- Load immediately, no lazy loading
    opts = {
      flavour = "auto",  -- latte, frappe, macchiato, mocha
      background = {
        light = "latte",  -- light background flavor (optional)
        dark = "mocha",   -- dark background flavor (optional)
      },
      transparent_background = false,  -- Set to true if you want a transparent background
      term_colors = true,  -- Enable terminal colors
      integrations = {
        treesitter = true,
        --lsp = true,
        cmp = true,
        gitsigns = true,
        telescope = true,
        -- Add more integrations as necessary
      },
      dim_inactive = {
        enabled = true,  -- Enable or disable dimming of inactive windows
        percentage = 0.3,  -- Adjust the dimming level (0 to 1)
      },
    },
    config = function(_, opts)
      -- Apply the Catppuccin theme with the provided opts
      require("catppuccin").setup(opts)
      -- Set the colorscheme to Catppuccin
      vim.cmd("colorscheme catppuccin")
    end,
  },
}

