--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight-moon"
-- to disable icons and use a minimalist setup, uncomment the following

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- MRU
lvim.keys.normal_mode["<S-Tab>"] = ":MRU<cr>"
vim.cmd([[
autocmd FileType mru nnoremap <buffer> <esc> :MRUToggle<cr>
autocmd FileType mru nnoremap <buffer> <tab> j
autocmd FileType mru nnoremap <buffer> <s-tab> k
]])


-- Additional Plugins
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    url = "https://gitlab.com/yorickpeterse/nvim-pqf.git"
  },
  { 'yegappan/mru' },
  { 'numToStr/FTerm.nvim' },
  {
    'nvim-treesitter/playground'
  },
  { 'nvim-lua/plenary.nvim' },

  -- local projects
  { dir = "~/projects/codegen" },
  { dir = '~/projects/dev',    config = function() require('dev') end }
}

-- require('codegen').setup()

-- FTerm
local fterm = require("FTerm")
fterm.setup({
  border = 'rounded',
  dimensions = {
    height = 0.95,
    width = 0.95
  }
})
vim.keymap.set('n', '<C-t>', fterm.toggle)
vim.keymap.set('t', '<C-t>', fterm.toggle)
vim.keymap.set('n', '<leader>j', fterm.toggle)
vim.keymap.set('t', '<leader>j', fterm.toggle)

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.terminal.active = false
lvim.builtin.project.active = false

lvim.builtin.bufferline.options.mode = 'tabs'
require("lvim.core.bufferline").setup()

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- pretty quickfix
require('pqf').setup()
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})


vim.opt.relativenumber = true
vim.opt.timeoutlen = 250

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black" },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    command = "proselint"
  },
}

lvim.builtin.nvimtree.setup.update_focused_file.enable = false
lvim.builtin.nvimtree.setup.update_focused_file.update_root = false
