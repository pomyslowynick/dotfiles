local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.localmapleader = " "
vim.g.mapleader = " "

require("lazy").setup({
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  },
  "elihunter173/dirbuf.nvim",
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  { "junegunn/fzf", build = "./install --all", name = "fzf" },
  "junegunn/fzf.vim",
  { "fatih/vim-go", build = ":GoUpdateBinaries" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-telescope/telescope.nvim", tag = '0.1.3', dependencies = { 'nvim-lua/plenary.nvim' }},
  "vim-ctrlspace/vim-ctrlspace",
  "takac/vim-hardtime",
}) 

-- let g:CtrlSpaceDefaultMappingKey = "<C-space> "
local action_layout = require('telescope.actions.layout')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<C-l>', '<Cmd>Rg!<CR>', {})
vim.keymap.set('n', '<C-k>', '<Cmd>Dirbuf<CR>', {})
vim.keymap.set('n', '<C-p>', '<Cmd>GitFiles!<CR>', {})

require("telescope").setup({
  defaults = {
    layout_strategy = "vertical",
  },
})
