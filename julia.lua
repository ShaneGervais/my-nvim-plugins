---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      if not vim.tbl_contains(opts.servers, "julials") then table.insert(opts.servers, "julials") end

      opts.config = opts.config or {}
      local julia_envs = vim.fn.glob(vim.fn.expand "~/.julia/environments/v*", false, true)
      table.sort(julia_envs)
      local global_env = julia_envs[#julia_envs] or vim.fn.expand "~/.julia/environments/v1.12"
      local julia_lsp = vim.fn.stdpath "data" .. "/mason/bin/julia-lsp"

      opts.config.julials = vim.tbl_deep_extend("force", opts.config.julials or {}, {
        cmd = { julia_lsp, global_env },
        single_file_support = true,
        root_dir = function(filename)
          local util = require "lspconfig.util"
          return util.root_pattern("Project.toml", "JuliaProject.toml", ".git")(filename) or util.path.dirname(filename)
        end,
        on_new_config = function(config, root_dir)
          local env_path = root_dir

          if vim.fn.filereadable(env_path .. "/Project.toml") == 0 then
            if vim.fn.filereadable(global_env .. "/Project.toml") == 1 then env_path = global_env end
          end

          config.cmd = { julia_lsp, env_path }
        end,
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if not vim.tbl_contains(opts.ensure_installed, "julia-lsp") then
        table.insert(opts.ensure_installed, "julia-lsp")
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if not vim.tbl_contains(opts.ensure_installed, "julia") then table.insert(opts.ensure_installed, "julia") end
    end,
  },
  {
    "JuliaEditorSupport/julia-vim",
    init = function()
      vim.g.latex_to_unicode_tab = "insert"
      vim.g.latex_to_unicode_auto = 1
      vim.g.latex_to_unicode_suggestions = 1
      vim.g.latex_to_unicode_file_types = { "julia" }
    end,
  },
  {
    "AstroNvim/astrocore",
    opts = {
      diagnostics = {
        virtual_text = true,
        underline = true,
        severity_sort = true,
        update_in_insert = false,
      },
    },
  },
}
