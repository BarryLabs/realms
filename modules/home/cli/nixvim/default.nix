{ config
, lib
, pkgs
, ...
}:
with lib; let
  module = "nixvim";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Nixvim Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gcc
      nodejs-slim
      tree-sitter
      uv
      zig
    ];
    programs.${module} = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      globals.mapleader = " ";
      colorschemes.catppuccin = {
        enable = true;
        settings = {
          style = "mocha";
          integrations = {
            cmp = true;
            treesitter = true;
            nvimtree = true;
            notify = true;
            mini = {
              enable = true;
            };
          };
        };
      };
      extraPackages = [
        pkgs.tree-sitter-grammars.tree-sitter-norg
        pkgs.tree-sitter-grammars.tree-sitter-norg-meta
      ];
      opts = {
        clipboard = "unnamedplus";
        mouse = "a";
        splitbelow = true;
        splitright = true;
        timeoutlen = 500;
        termguicolors = true;
        completeopt = "menuone,noselect";
        updatetime = 300;
        number = true;
        relativenumber = true;
        wrap = false;
        tabstop = 2;
        shiftwidth = 2;
        softtabstop = 2;
        expandtab = true;
        shiftround = true;
        smartindent = true;
        signcolumn = "yes";
        scrolloff = 6;
        sidescrolloff = 5;
        ignorecase = true;
        smartcase = true;
        incsearch = true;
        hlsearch = true;
        backup = false;
        swapfile = false;
        writebackup = false;
        undofile = true;
        list = true;
        foldmethod = "indent";
        foldlevel = 99;
        foldenable = false;
      };
      keymaps = [
        {
          mode = "n";
          key = "<leader>e";
          action = "<cmd>Neotree toggle<CR>";
          options.silent = true;
        }
        {
          mode = "n";
          key = "<leader>gd";
          action = "<cmd>lua vim.lsp.buf.definition()<CR>";
          options.silent = true;
        }
        {
          mode = "n";
          key = "<leader>gD";
          action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
          options.silent = true;
        }
        {
          mode = "n";
          key = "<leader>gi";
          action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
          options.silent = true;
        }
        {
          mode = "n";
          key = "<leader>gr";
          action = "<cmd>lua vim.lsp.buf.references()<CR>";
          options.silent = true;
        }
        {
          mode = "n";
          key = "<leader>gh";
          action = "<cmd>lua vim.lsp.buf.hover()<CR>";
          options.silent = true;
        }
        {
          mode = "n";
          key = "<leader>et";
          action = "<cmd>Neotree toggle<CR>";
          options.silent = true;
        }
        {
          mode = "n";
          key = "<leader>ef";
          action = "<cmd>Neotree focus<CR>";
          options.silent = true;
        }
        {
          mode = "n";
          key = "<leader>r";
          action = "<cmd>Neotree reveal<CR>";
          options.silent = true;
        }
        {
          mode = "n";
          key = "<leader>ff";
          action = "<cmd>Telescope find_files<CR>";
          options.silent = true;
        }
        {
          mode = "n";
          key = "<leader>fg";
          action = "<cmd>Telescope live_grep<CR>";
          options.silent = true;
        }
        {
          mode = "n";
          key = "<leader>fb";
          action = "<cmd>Telescope buffers<CR>";
          options.silent = true;
        }
        {
          mode = "n";
          key = "<leader>gg";
          action = "<cmd>LazyGit<CR>";
          options.silent = true;
        }
      ];
      plugins = {
        alpha = {
          enable = true;
          theme = "dashboard";
        };
        bufferline = {
          enable = true;
        };
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings.sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
        colorizer = {
          enable = true;
        };
        conform-nvim = {
          enable = true;
        };
        friendly-snippets = {
          enable = true;
        };
        image = {
          enable = true;
        };
        indent-blankline = {
          enable = true;
        };
        lazygit = {
          enable = true;
          settings = {
            floating_window_winblend = 0;
            floating_window_scaling_factor = 0.9;
          };
        };
        lsp = {
          enable = true;
          servers = {
            biome.enable = true;
            cssls.enable = true;
            gopls.enable = true;
            jsonls.enable = true;
            lua_ls.enable = true;
            nil_ls.enable = true;
            nixd.enable = true;
            pyright.enable = true;
            ruff.enable = true;
            rust_analyzer = {
              enable = true;
              installCargo = true;
              installRustc = true;
            };
            zls.enable = false;
          };
        };
        lualine = {
          enable = true;
        };
        mini-icons = {
          enable = true;
        };
        #neorg = {
        #  enable = true;
        #  telescopeIntegration.enable = true;
        #  settings = {
        #    load = {
        #      "core.defaults" = { __empty = null; };
        #      "core.concealer" = {
        #        config = {
        #          icon_preset = "varied";
        #          icons = {
        #            delimiter = {
        #              horizontal_line = {
        #                highlight = "@neorg.delimiters.horizontal_line";
        #              };
        #            };
        #            code_block = {
        #              content_only = true;

        #              width = "content";

        #              padding = {
        #                left = 20;
        #                right = 20;
        #              };

        #              conceal = true;

        #              #nodes = { "ranged_verbatim_tag" };
        #              highlight = "CursorLine";
        #              insert_enabled = true;
        #            };
        #          };
        #        };
        #      };
        #      "core.dirman" = {
        #        config = {
        #          workspaces = {
        #            notes = "~/Documents/notes";
        #          };
        #        };
        #      };
        #    };
        #  }; 
        #};
        neo-tree = {
          enable = true;
          settings = {
            close_if_last_window = true;
            filesystem = {
              follow_current_file = {
                enabled = true;
                leave_dirs_open = true;
              };
            };
          };
        };
        noice = {
          enable = false;
        };
        nui = {
          enable = true;
        };
        nvim-surround = {
          enable = true;
        };
        orgmode = {
          enable = true;
          settings = {
            org_agenda_files = "~/Documents/Org/agenda/*";
            org_default_notes_file = "~/Documents/Org/notes/refile.org";
          };
        };
        precognition = {
          enable = true;
        };
        rainbow-delimiters = {
          enable = true;
        };
        render-markdown = {
          enable = true;
        };
        snacks = {
          enable = true;
        };
        spectre = {
          enable = true;
        };
        telescope = {
          enable = true;
          extensions."fzf-native" = {
            enable = true;
            settings = {
              fuzzy = true;
              case_mode = "smart_case";
              override_file_sorter = true;
              override_generic_sorter = true;
            };
          };
          settings = {
            pickers.find_files.hidden = true;
            defaults = {
              sorting_strategy = "ascending";
              layout_config = {prompt_position = "top";};
            };
          };
        };
        treesitter = {
          enable = true;
          #nixvimInjections = true;
          folding = false;
          settings = {
            indent.enable = true;
            highlight = {
              enable = true;
            };
            auto_install = true;

          };
        };
        treesitter-textobjects = {
          enable = true;
        };
        todo-comments = {
          enable = true;
        };
        trouble = {
          enable = true;
        };
        web-devicons = {
          enable = true;
        };
        which-key = {
          enable = true;
          settings = {
            delay = 200;
            expand = 1;
            notify = false;
            preset = true;
          };
        };
        yazi = {
          enable = true;
        };
        zellij = {
          enable = true;
        };
      };
    };
  };
}
