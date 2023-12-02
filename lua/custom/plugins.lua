local plugins = {
  -- extend treesitter ensure_installed
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "java", "c_sharp", "latex" },
    },
  },

  -- extend mason ensure_installed
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "csharp-language-server",
        "prettier",
        "stylua",
        "csharpier",
        "texlab",

        -- Java stuff
        "jdtls",
        "java-debug-adapter",
        "java-test",
        "vscode-java-decompiler",
      },
    },
  },

  -- In order to modify the `lspconfig` configuration:
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "custom.configs.null-ls"
      end,
    },

    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "NvChad/nvterm",
    config = function()
      require "custom.configs.nvterm"
    end,
  },

  -- Debug stuff
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("core.utils").load_mappings "dap"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1])
      local config = {
        cmd = {
          vim.fn.stdpath "config" .. "-data\\mason\\bin\\jdtls.cmd",
        },
        root_dir = root_dir,
        on_attach = function(client, bufnr)
          require("jdtls").setup_dap { hotcodereplace = "auto" }
          require("jdtls").setup_dap_main_class_configs()
          require("jdtls").add_commands()
        end,
        init_options = {
          bundles = {
            -- Bundle Java debug adapter
            "C:\\Users\\mikev\\AppData\\Local\\nvim-data\\mason\\packages\\java-debug-adapter\\extension\\server\\com.microsoft.java.debug.plugin-0.47.0.jar",
            -- TODO Bundle java-test
          },
        },
      }
      require("jdtls").start_or_attach(config)
      require("core.utils").load_mappings "jdtls"

      -- Setup dap java configuration
      local dap = require "dap"
      dap.configurations.java = {
        {
          javaExec = "java",
          request = "launch",
          type = "java",
          name = "Debg current file",
          hostName = "127.0.0.1",
          port = 5005,
        },
      }
    end,
  },

  -- VimTex
  {
    "lervag/vimtex",
    ft = { "tex" },
    init = function()
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_mappings_enabled = 0
      vim.g.vimtex_indent_enabled = 0
    end,
    lazy = false,
  },
}

return plugins
