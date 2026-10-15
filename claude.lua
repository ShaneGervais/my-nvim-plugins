return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  cmd = { "ClaudeCode" },
  keys = {
    { "<leader>a", nil, desc = "AI/Claude Code" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
  },
  opts = {},
}
