return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Mason for LSP server management
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Language servers
        "html-lsp",
        "css-lsp", 
        "typescript-language-server",
        "svelte-language-server",
        "elixir-ls",
        "gleam",
        
        -- Formatters (already configured in conform.lua)
        "prettier",
        "stylua",
      },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },


  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- nvim-cmp and sources

  -- Surround motions (ys, ds, cs, etc.)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  -- Gitsigns for git integration
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
      },
      preview_config = {
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
      
      -- Add keybindings
      local map = vim.keymap.set
      
      -- Navigation
      map('n', ']h', function()
        require('gitsigns').nav_hunk('next')
      end, { desc = "Next git hunk" })
      
      map('n', '[h', function()
        require('gitsigns').nav_hunk('prev')
      end, { desc = "Previous git hunk" })
      
      -- Actions
      map('n', '<leader>hs', require('gitsigns').stage_hunk, { desc = "Stage hunk" })
      map('n', '<leader>hr', require('gitsigns').reset_hunk, { desc = "Reset hunk" })
      map('n', '<leader>hS', require('gitsigns').stage_buffer, { desc = "Stage buffer" })
      map('n', '<leader>hR', require('gitsigns').reset_buffer, { desc = "Reset buffer" })
      map('n', '<leader>hp', require('gitsigns').preview_hunk, { desc = "Preview hunk" })
      map('n', '<leader>hb', function()
        require('gitsigns').blame_line({ full = true })
      end, { desc = "Blame line" })
      map('n', '<leader>hd', require('gitsigns').diffthis, { desc = "Diff this" })
      
      -- Toggles
      map('n', '<leader>tb', require('gitsigns').toggle_current_line_blame, { desc = "Toggle git blame" })
      map('n', '<leader>tw', require('gitsigns').toggle_word_diff, { desc = "Toggle word diff" })
    end,
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css", "elixir",
       "javascript", "typescript", "svelte", "gleam"
  		}
  	},
  },

  -- nvim-ufo for modern folding
  {
    "kevinhwang91/promise-async"
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    config = function()
      -- Fold options
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Setup nvim-ufo
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return {'treesitter', 'indent'}
        end
      })
    end,
  },
}
