return {
  {
    "hat0uma/csvview.nvim",
    lazy = false,
    opts = {
      view = { display_mode = "border" },
    },
    config = function(_, opts)
      require("csvview").setup(opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "csv", "tsv" },
        callback = function() vim.cmd("CsvViewEnable") end,
      })
    end,
  },
  {
    "cameron-wags/rainbow_csv.nvim",
    config = true,
    ft = { "csv", "tsv", "csv_semicolon", "csv_whitespace", "csv_pipe", "rfc_csv", "rfc_semicolon" },
    cmd = { "RainbowDelim", "RainbowDelimSimple", "RainbowDelimQuoted", "RainbowMultiDelim" },
  },
}
