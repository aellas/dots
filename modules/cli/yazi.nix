{ pkgs, lib, ... }:

{
  programs.yazi = {
    enable = true;

    # Creates the `yy` shell command.
    #
    # Unlike plain `yazi`, exiting `yy` changes your shell into the
    # directory you were viewing.
    shellWrapperName = "yy";

    enableZshIntegration = true;
    enableBashIntegration = true;

    # Programs used by Yazi for searching, previews, archives, navigation,
    # media information and opening files.
    extraPackages = with pkgs; [
      # Searching/navigation
      fd
      ripgrep
      fzf
      zoxide

      # Archives
      file
      p7zip
      unzip
      ouch

      # Documents and text previews
      bat
      glow
      poppler-utils

      # Images, SVG and media previews
      imagemagick
      resvg
      ffmpeg
      mediainfo

      # Miscellaneous
      jq
      exiftool
    ];

    settings = {
      mgr = {
        ratio = [
          1
          4
          3
        ];

        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        sort_translit = true;

        linemode = "size";
        show_hidden = true;
        show_symlink = true;
        scrolloff = 5;

        title_format = "Yazi: {cwd}";
      };

      preview = {
        wrap = "yes";
        tab_size = 2;

        max_width = 1200;
        max_height = 1800;

        image_delay = 30;
        image_filter = "triangle";
        image_quality = 90;

        cache_dir = "";
        ueberzug_scale = 1;
        ueberzug_offset = [
          0
          0
          0
          0
        ];
      };

      opener = {
        edit = [
          {
            run = ''emacsclient -c "$@"'';
            desc = "Edit in Emacs";
            block = false;
            for = "unix";
          }
          {
            run = ''nvim "$@"'';
            desc = "Edit in Neovim";
            block = true;
            for = "unix";
          }
        ];

        open = [
          {
            run = ''xdg-open "$1"'';
            desc = "Open";
            for = "linux";
          }
        ];

        reveal = [
          {
            run = ''nemo "$(dirname "$1")"'';
            desc = "Reveal in Nemo";
            for = "linux";
          }
        ];

        play = [
          {
            run = ''mpv --force-window "$@"'';
            orphan = true;
            for = "unix";
          }
          {
            run = ''mediainfo "$1"; echo "Press enter to close"; read'';
            block = true;
            desc = "Show media information";
            for = "unix";
          }
        ];

        extract = [
          {
            run = ''ouch d -y "$@"'';
            desc = "Extract here";
            for = "unix";
          }
        ];
      };

      open = {
        prepend_rules = [
          {
            name = "*.org";
            use = [ "edit" ];
          }
          {
            name = "*.nix";
            use = [ "edit" ];
          }
          {
            name = "*.el";
            use = [ "edit" ];
          }
          {
            name = "*.lua";
            use = [ "edit" ];
          }
          {
            name = "*.sh";
            use = [ "edit" ];
          }
          {
            mime = "text/*";
            use = [ "edit" ];
          }
          {
            mime = "image/*";
            use = [
              "open"
              "reveal"
            ];
          }
          {
            mime = "video/*";
            use = [
              "play"
              "reveal"
            ];
          }
          {
            mime = "audio/*";
            use = [
              "play"
              "reveal"
            ];
          }
          {
            mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip2}";
            use = [
              "extract"
              "reveal"
            ];
          }
        ];
      };

      tasks = {
        micro_workers = 10;
        macro_workers = 25;
        bizarre_retry = 5;
        image_alloc = 536870912;
        image_bound = [
          0
          0
        ];
        suppress_preload = false;
      };

      input = {
        cursor_blink = true;
      };

      confirm = {
        trash_title = "Move {n} selected file{s} to the trash?";
        trash_origin = "center";
        trash_offset = [
          0
          0
          70
          20
        ];

        delete_title = "Permanently delete {n} selected file{s}?";
        delete_origin = "center";
        delete_offset = [
          0
          0
          70
          20
        ];

        overwrite_title = "Overwrite file?";
        overwrite_content = "Will overwrite the following file:";
        overwrite_origin = "center";
        overwrite_offset = [
          0
          0
          70
          20
        ];

        quit_title = "Quit Yazi?";
        quit_origin = "center";
        quit_offset = [
          0
          0
          50
          15
        ];
      };

      pick = {
        open_title = "Open with:";
        open_origin = "hovered";
        open_offset = [
          0
          1
          50
          7
        ];
      };

      which = {
        sort_by = "key";
        sort_sensitive = false;
        sort_reverse = false;
        sort_translit = true;
      };
    };

    keymap = {
      mgr.prepend_keymap = [
        # Plugin controls
        {
          on = [ "l" ];
          run = "plugin smart-enter";
          desc = "Enter directory or open file";
        }
        {
          on = [ "<Enter>" ];
          run = "plugin smart-enter";
          desc = "Enter directory or open file";
        }
        {
          on = [ "T" ];
          run = "plugin toggle-pane max-preview";
          desc = "Maximise or restore preview";
        }
        {
          on = [ "M" ];
          run = "plugin mount";
          desc = "Manage mounted drives";
        }
        {
          on = [
            "c"
            "m"
          ];
          run = "plugin chmod";
          desc = "Change file permissions";
        }
        {
          on = [
            "g"
            "c"
          ];
          run = "plugin vcs-files";
          desc = "Show Git-changed files";
        }

        # Navigation
        {
          on = [
            "g"
            "h"
          ];
          run = "cd ~";
          desc = "Go home";
        }
        {
          on = [
            "g"
            "c"
          ];
          run = "cd ~/.config";
          desc = "Go to config";
        }
        {
          on = [
            "g"
            "o"
          ];
          run = "cd ~/org";
          desc = "Go to Org directory";
        }
        {
          on = [
            "g"
            "d"
          ];
          run = "cd ~/Downloads";
          desc = "Go to downloads";
        }
        {
          on = [
            "g"
            "D"
          ];
          run = "cd ~/Documents";
          desc = "Go to documents";
        }
        {
          on = [
            "g"
            "p"
          ];
          run = "cd ~/Documents/GitHub";
          desc = "Go to projects";
        }

        # Search and navigation tools
        {
          on = [ "f" ];
          run = "search --via=fd";
          desc = "Search filenames";
        }
        {
          on = [ "F" ];
          run = "search --via=rg";
          desc = "Search file contents";
        }
        {
          on = [ "z" ];
          run = "plugin zoxide";
          desc = "Jump with zoxide";
        }
        {
          on = [ "Z" ];
          run = "plugin fzf";
          desc = "Jump with fzf";
        }

        # File operations
        {
          on = [ "C" ];
          run = "copy path";
          desc = "Copy file path";
        }
        {
          on = [ "<C-y>" ];
          run = "copy filename";
          desc = "Copy filename";
        }
        {
          on = [ "<C-n>" ];
          run = ''shell 'nemo "$PWD"' --orphan'';
          desc = "Open current directory in Nemo";
        }
        {
          on = [ "<C-t>" ];
          run = ''shell 'kitty --directory "$PWD"' --orphan'';
          desc = "Open terminal here";
        }

        # Display
        {
          on = [ "." ];
          run = "hidden toggle";
          desc = "Toggle hidden files";
        }
        {
          on = [ "<C-p>" ];
          run = "spot";
          desc = "Inspect file";
        }
      ];

      tasks.prepend_keymap = [
        {
          on = [ "<Esc>" ];
          run = "close";
          desc = "Close task manager";
        }
      ];

      select.prepend_keymap = [
        {
          on = [ "<Esc>" ];
          run = "close";
          desc = "Cancel selection";
        }
      ];

      input.prepend_keymap = [
        {
          on = [ "<Esc>" ];
          run = "close";
          desc = "Cancel input";
        }
      ];
    };

    plugins = {
      full-border = {
        package = pkgs.yaziPlugins.full-border;
        setup = true;
      };

      git = {
        package = pkgs.yaziPlugins.git;
        setup = true;
      };

      smart-enter = pkgs.yaziPlugins.smart-enter;
      toggle-pane = pkgs.yaziPlugins.toggle-pane;
      chmod = pkgs.yaziPlugins.chmod;
      mount = pkgs.yaziPlugins.mount;
      vcs-files = pkgs.yaziPlugins.vcs-files;
    };

    initLua = ''
      -- Show the username and hostname in Yazi's header.
      Header:children_add(function()
        if ya.target_family() ~= "unix" then
          return ui.Line {}
        end

        return ui.Line {
          ui.Span(ya.user_name() .. "@" .. ya.host_name())
            :fg("blue")
            :bold(),
          ui.Span(" "),
        }
      end, 500, Header.LEFT)

      -- Show the number of selected files in the status bar.
      Status:children_add(function()
        local selected = #cx.active.selected

        if selected == 0 then
          return ui.Line {}
        end

        return ui.Line {
          ui.Span(" " .. selected .. " selected ")
            :fg("black")
            :bg("yellow")
            :bold()
        }
      end, 500, Status.RIGHT)
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
