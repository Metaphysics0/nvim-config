local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    svelte = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    markdown = { "prettier" },

    -- Elixir uses Mix format
    elixir = { "mix" },
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}

return options
