return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },

  -- Themes
  { "santos-gabriel-dario/darcula-solid.nvim", name = "darcula-solid", lazy = false },
  { "morhetz/gruvbox", lazy = false },
  { "sainnhe/gruvbox-material", lazy = false },
  { "lifepillar/vim-gruvbox8", branch = "neovim", lazy = false },

  { "tpope/vim-fugitive", lazy = false },
  { "tpope/vim-rhubarb", lazy = false },
  { "tpope/vim-surround", lazy = false },
  -- { "mg979/vim-visual-multi", lazy = false },
  { "rktjmp/lush.nvim", lazy = false },
}
