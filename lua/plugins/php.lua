-- php.lua
-- PHP, Laravel, and Blade template support

return {
  -- PHP Language Server configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Additional configuration for intelephense (PHP language server)
      intelephense = {
        settings = {
          intelephense = {
            stubs = {
              "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", 
              "ctype", "curl", "date", "dba", "dom", "enchant", "exif", 
              "FFI", "fileinfo", "filter", "fpm", "ftp", "gd", "gettext", 
              "gmp", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", 
              "mbstring", "meta", "mysqli", "oci8", "odbc", "openssl", "pcntl", 
              "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", 
              "pgsql", "Phar", "posix", "pspell", "readline", "Reflection", 
              "session", "shmop", "SimpleXML", "snmp", "soap", "sockets", 
              "sodium", "SPL", "sqlite3", "standard", "superglobals", "sysvmsg", 
              "sysvsem", "sysvshm", "tidy", "tokenizer", "xml", "xmlreader", 
              "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib",
              -- Laravel stubs
              "laravel", "blade"
            },
            environment = {
              includePaths = {
                -- Add Laravel vendor directory for better support
                "vendor/laravel/framework/src"
              }
            },
            files = {
              maxSize = 5000000 -- Increase file size limit for large PHP files
            },
            completion = {
              insertUseDeclaration = true,
              fullyQualifyGlobalConstantsAndFunctions = false,
              triggerParameterHints = true,
              maxItems = 100
            },
            format = {
              enable = true
            }
          }
        }
      }
    }
  },

  -- Treesitter configuration for PHP and Blade
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        -- Add PHP and Blade to treesitter
        vim.list_extend(opts.ensure_installed, {
          "php",
          "phpdoc",
        })
      end
    end,
  },

  -- Laravel and Blade template support
  {
    "jwalton512/vim-blade",
    ft = "blade",
    dependencies = {
      "sheerun/vim-polyglot" -- Additional syntax highlighting
    },
  },

  -- PHP CS Fixer integration
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        php = { "phpstan", "php" }
      }
    }
  },

  -- Formatter configuration for PHP
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        php = { "php_cs_fixer" }
      },
      formatters = {
        php_cs_fixer = {
          -- PHP CS Fixer options
          args = {
            "--rules=@PSR12,no_unused_imports",
            "--using-cache=no",
            "--quiet"
          }
        }
      }
    }
  },

  -- Laravel-specific utilities
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Artisan", "Laravel" },
    keys = {
      { "<leader>la", ":Laravel artisan<cr>", desc = "Laravel Artisan" },
      { "<leader>lr", ":Laravel routes<cr>", desc = "Laravel Routes" },
      { "<leader>lm", ":Laravel models<cr>", desc = "Laravel Models" },
    },
    opts = {
      features = {
        -- Enable Laravel specific features
        route_info = true,
        lsp = {
          enabled = true,
        },
      },
    },
    config = function(_, opts)
      require("laravel").setup(opts)
      
      -- Set filetype for Blade templates
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "*.blade.php",
        callback = function()
          vim.bo.filetype = "blade"
        end,
      })
    end,
  },
} 