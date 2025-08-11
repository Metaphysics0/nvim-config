require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- VSCode Vim parity: movement accelerators
map({ "n", "v" }, "J", "5j", { desc = "Move down 5" })
map({ "n", "v" }, "<S-k>", "5k", { desc = "Move up 5" })

-- VSCode Vim parity: visual mode actions
-- Go to definition (LSP)
map("v", "<leader><CR>", function()
  vim.lsp.buf.definition()
end, { desc = "Go to Definition" })

-- Duplicate selected lines down (like VSCode copyLinesDownAction)
map(
  "v",
  "<A-S-j>",
  ":t'><CR>gv",
  { desc = "Copy selection down" }
)

-- Duplicate selected lines up (like VSCode copyLinesUpAction)
map(
  "v",
  "<leader>k",
  ":copy '<-1<CR>gv",
  { desc = "Copy selection up" }
)

-- VSCode Vim parity: normal mode paste at end of line
map("n", ",", "$p", { desc = "Paste at end of line" })

-- VSCode Vim parity: tabs management
map("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tp", "<cmd>tabprev<CR>", { desc = "Prev tab" })
map("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "Close other tabs" })

-- VSCode Vim parity: folding (nvim-ufo)
-- Fold current method/function scope (like VSCode)
map("n", "<M-D-[>", function()
  -- First try to close fold at current line
  local success = pcall(vim.cmd, 'normal! zc')
  
  -- If no fold at current line, try to find parent scope and fold it
  if not success then
    -- Use treesitter to find the containing function/method
    local ok, ts_utils = pcall(require, 'nvim-treesitter.ts_utils')
    if ok then
      local node = ts_utils.get_node_at_cursor()
      if node then
        local parent = node:parent()
        while parent do
          local type = parent:type()
          if type == 'function' or type == 'function_declaration' or 
             type == 'method' or type == 'method_definition' or
             type == 'function_definition' or type == 'arrow_function' or
             type == 'class_declaration' or type == 'if_statement' or
             type == 'for_statement' or type == 'while_statement' then
            local start_row = parent:start()
            vim.api.nvim_win_set_cursor(0, {start_row + 1, 0})
            vim.cmd('normal! zc')
            break
          end
          parent = parent:parent()
        end
      end
    else
      -- Fallback: use built-in fold commands
      vim.cmd('normal! zc')
    end
  end
end, { desc = "Fold current method" })
map("n", "<M-D-]>", function() require('ufo').openAllFolds() end, { desc = "Unfold all" })
map("n", "zR", function() require('ufo').openAllFolds() end, { desc = "Open all folds" })
map("n", "zM", function() require('ufo').closeAllFolds() end, { desc = "Close all folds" })

-- Enhanced fold preview with different key (since K is for movement)
map("n", "<leader>fp", function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = "Peek fold or hover" })
