{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "helix";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Base Helix Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rustup
      zig
    ];
    programs = {
      uv.enable = true;
      ${module} = {
        enable = true;
        extraPackages = with pkgs; [
          bash-language-server
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
          tailwindcss-language-server
          vscode-langservers-extracted
          yaml-language-server
          zls
        ];
        settings = {
          theme = lib.mkForce "catppuccin_mocha";
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
          language-server.rust-analyzer.config.check = {
            command = "clippy";
          };
          language = [
            {
              name = "zig";
              language-servers = [
                "zls"
              ];
            }
            {
              name = "css";
              auto-format = true;
              language-servers = [
                "vscode-css-language-server"
                "tailwindcss-ls"
              ];
            }
            {
              name = "go";
              auto-format = true;
              language-servers = [
                "gopls"
              ];
              formatter = {
                command = "goimports";
              };
            }
            {
              name = "html";
              auto-format = true;
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
            }
            {
              name = "json";
              auto-format = true;
              language-servers = [
                {
                  name = "vscode-json-language-server";
                  except-features = [ "format" ];
                }
              ];
            }
            {
              name = "jsonc";
              auto-format = true;
              language-servers = [
                {
                  name = "vscode-json-language-server";
                  except-features = [ "format" ];
                }
              ];
              file-types = [
                "jsonc"
                "hujson"
              ];
            }
            {
              name = "markdown";
              auto-format = true;
              language-servers = [ "marksman" ];
              formatter = {
                command = "prettier";
                args = [
                  "--stdin-filepath"
                  "file.md"
                ];
              };
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
              auto-format = true;
              language-servers = [
                "pylsp"
                "ruff"
              ];
              formatter = {
                command = "sh";
                args = [
                  "-c"
                  "ruff check --select I --fix - | ruff format --line-length 88 -"
                ];
              };
            }
            {
              name = "rust";
              auto-format = true;
              language-servers = [
                "rust-analyzer"
              ];
            }
            {
              name = "sql";
              auto-format = true;
              formatter = {
                command = "sql-formatter";
                args = [
                  "-l"
                  "postgresql"
                  "-c"
                  ''{"keywordCase": "lower", "dataTypeCase": "lower", "functionCase": "lower", "expressionWidth": 120, "tabWidth": 4}''
                ];
              };
            }
            {
              name = "toml";
              auto-format = true;
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
            }
            {
              name = "yaml";
              auto-format = true;
              language-servers = [ "yaml-language-server" ];
              formatter = {
                command = "prettier";
                args = [
                  "--stdin-filepath"
                  "file.yaml"
                ];
              };
            }
          ];
        };
      };
    };
  };
}
