require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- VSCode-like options parity
local opt = vim.opt

-- Tabs and indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Line numbers
opt.relativenumber = true
opt.number = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- UI/UX
opt.smoothscroll = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.wrap = false

-- Formatting behavior similar to VSCode settings
vim.g.mapleader = " "

-- Cursor blink in normal mode
-- For TUI Neovim, use 'guicursor' to control cursor behavior in supported UIs
opt.guicursor = [[n-v-c:block-blinkon500-blinkoff500,i-ci-ve:ver25,r-cr:hor20,o:hor50]]
