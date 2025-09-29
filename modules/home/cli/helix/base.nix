{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.mods.cli.helix.base;
in
{
  options.mods.cli.helix.base.enable = mkEnableOption "Base Helix Module";
  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      extraPackages = with pkgs; [
        bash-language-server
        biome
        clang-tools
        docker-compose-language-service
        dockerfile-language-server
        golangci-lint
        golangci-lint-langserver
        gopls
        gotools
        helix-gpt
        marksman
        nil
        nixd
        nixpkgs-fmt
        nodePackages.prettier
        nodePackages.typescript-language-server
        sql-formatter
        ruff
        (python3.withPackages (
          p:
          (with p; [
            python-lsp-ruff
            python-lsp-server
          ])
        ))
        rust-analyzer
        taplo
        taplo-lsp
        tailwindcss-language-server
        vscode-langservers-extracted
        yaml-language-server
        zls
      ];
      settings = {
        theme = "catppuccin_mocha";
        editor = {
          line-number = "relative";
          cursorline = true;
          bufferline = "multiple";
          color-modes = true;
          auto-save = {
            focus-lost = true;
            after-delay.enable = true;
          };

          soft-wrap = {
            enable = true;
          };

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          indent-guides = {
            character = "┊";
            render = true;
            skip-levels = 1;
          };

          lsp = {
            display-messages = true;
            display-inlay-hints = true;
          };
          end-of-line-diagnostics = "hint";
          inline-diagnostics.cursor-line = "warning";

          statusline = {
            left = [
              "mode"
              "file-name"
              "spinner"
              "read-only-indicator"
              "file-modification-indicator"
            ];
            right = [
              "diagnostics"
              "selections"
              "register"
              "file-type"
              "file-line-ending"
              "position"
            ];
            mode.normal = "";
            mode.insert = "I";
            mode.select = "S";
          };
        };
        keys = {
          insert = {
            C-u = [
              "extend_to_line_bounds"
              "delete_selection_noyank"
              "open_above"
            ];
            C-w = [
              "move_prev_word_start"
              "delete_selection_noyank"
            ];
            C-space = "completion";
            S-tab = "move_parent_node_start";
          };
        };
      };
      languages = {
        language-server.biome = {
          command = "biome";
          args = [ "lsp-proxy" ];
        };
        language-server.rust-analyzer.config.check = {
          command = "clippy";
        };
        language = [
          {
            name = "zig";
          }
          {
            name = "css";
            language-servers = [
              "vscode-css-language-server"
              "tailwindcss-ls"
              "biome"
            ];
            auto-format = true;
          }
          {
            name = "go";
            language-servers = [
              "gopls"
              "golangci-lint-lsp"
            ];
            formatter = {
              command = "goimports";
            };
            auto-format = true;
          }
          {
            name = "html";
            language-servers = [
              "vscode-html-language-server"
              "tailwindcss-ls"
            ];
            formatter = {
              command = "prettier";
              args = [
                "--stdin-filepath"
                "file.html"
              ];
            };
            auto-format = true;
          }
          {
            name = "javascript";
            language-servers = [
              {
                name = "typescript-language-server";
                except-features = [ "format" ];
              }
              "biome"
            ];
            auto-format = true;
          }
          {
            name = "json";
            language-servers = [
              {
                name = "vscode-json-language-server";
                except-features = [ "format" ];
              }
              "biome"
            ];
            formatter = {
              command = "biome";
              args = [
                "format"
                "--indent-style"
                "space"
                "--stdin-file-path"
                "file.json"
              ];
            };
            auto-format = true;
          }
          {
            name = "jsonc";
            language-servers = [
              {
                name = "vscode-json-language-server";
                except-features = [ "format" ];
              }
              "biome"
            ];
            formatter = {
              command = "biome";
              args = [
                "format"
                "--indent-style"
                "space"
                "--stdin-file-path"
                "file.jsonc"
              ];
            };
            file-types = [
              "jsonc"
              "hujson"
            ];
            auto-format = true;
          }
          {
            name = "markdown";
            language-servers = [ "marksman" ];
            formatter = {
              command = "prettier";
              args = [
                "--stdin-filepath"
                "file.md"
              ];
            };
            auto-format = true;
          }
          {
            name = "nix";
            auto-format = true;
            formatter = {
              command = "nixpkgs-fmt";
            };
          }
          {
            name = "python";
            language-servers = [
              "pylsp"
            ];
            formatter = {
              command = "sh";
              args = [
                "-c"
                "ruff check --select I --fix - | ruff format --line-length 88 -"
              ];
            };
            auto-format = true;
          }
          {
            name = "rust";
            language-servers = [
              "rust-analyzer"
            ];
            auto-format = true;
          }
          {
            name = "sql";
            formatter = {
              command = "sql-formatter";
              args = [
                "-l"
                "postgresql"
                "-c"
                ''{"keywordCase": "lower", "dataTypeCase": "lower", "functionCase": "lower", "expressionWidth": 120, "tabWidth": 4}''
              ];
            };
            auto-format = true;
          }
          {
            name = "toml";
            language-servers = [ "taplo" ];
            formatter = {
              command = "taplo";
              args = [
                "fmt"
                "-o"
                "column_width=120"
                "-"
              ];
            };
            auto-format = true;
          }
          {
            name = "yaml";
            language-servers = [ "yaml-language-server" ];
            formatter = {
              command = "prettier";
              args = [
                "--stdin-filepath"
                "file.yaml"
              ];
            };
            auto-format = true;
          }
        ];
      };
    };
  };
}
