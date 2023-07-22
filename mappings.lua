local utils = require "astronvim.utils"

local function compare_to_clipboard()
  local ftype = vim.api.nvim_eval "&filetype"
  vim.cmd "vsplit"
  vim.cmd "enew"
  vim.cmd "normal! P"
  vim.cmd "setlocal buftype=nowrite"
  vim.cmd("set filetype=" .. ftype)
  vim.cmd "diffthis"
  vim.cmd [[execute "normal! \<C-w>h"]]
  vim.cmd "diffthis"
end

-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local maps = {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
    -- ["<leader>gg"] = { name = "Fugitive" },
    ["<leader>yd"] = { ':let @*=expand("%:p:h")<CR>', desc = "Copy Current Dir" },
    ["<A-DOWN>"] = { ":m .+1<cr>", desc = "move line down" },
    ["<A-UP>"] = { ":m .-2<cr>", desc = "move line up" },
    ["<C-.>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Go to Next buffer",
    },
    ["<C-,>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Go to Previous buffer",
    },
  },
  i = {
    ["<A-DOWN>"] = { "<esc>:m .+1<cr>gi", desc = "move line down" },
    ["<A-UP>"] = { "<esc>:m .-2<cr>gi", desc = "move line up" },
  },
  v = {
    ["<C-m>"] = { compare_to_clipboard, desc = "compare selected with clipboard" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}

-- override astronvim default session keymaps
if utils.is_available "neovim-session-manager" then
  maps.n["<leader>s"] = { name = "Session" }
  maps.n["<leader>sl"] = { "<cmd>SessionManager! load_last_session<cr>", desc = "Load last session" }
  maps.n["<leader>ss"] = { "<cmd>SessionManager! save_current_session<cr>", desc = "Save this session" }
  maps.n["<leader>sd"] = { "<cmd>SessionManager! delete_session<cr>", desc = "Delete session" }
  maps.n["<leader>sf"] = { "<cmd>SessionManager! load_session<cr>", desc = "Search sessions" }
  maps.n["<leader>s."] =
    { "<cmd>SessionManager! load_current_dir_session<cr>", desc = "Load current directory session" }
end

if utils.is_available "resession.nvim" then
  maps.n["<leader>s"] = { name = "Session" }
  maps.n["<leader>sl"] = { function() require("resession").load "Last Session" end, desc = "Load last session" }
  maps.n["<leader>ss"] = { function() require("resession").save() end, desc = "Save this session" }
  maps.n["<leader>st"] = { function() require("resession").save_tab() end, desc = "Save this tab's session" }
  maps.n["<leader>sd"] = { function() require("resession").delete() end, desc = "Delete a session" }
  maps.n["<leader>sf"] = { function() require("resession").load() end, desc = "Load a session" }
  maps.n["<leader>s."] = {
    function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
    desc = "Load current directory session",
  }
end

return maps
