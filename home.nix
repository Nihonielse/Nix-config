{ config, pkgs, inputs, ... }:
{
  home.username = "nihoel";
  home.homeDirectory = "/home/nihoel";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    appimage-run
    steam-run

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    discord
    steam
    lutris
    ungoogled-chromium
    antimicrox
    scrcpy
    tetrio-desktop
    godot
    kdePackages.kdenlive
    inkscape
    wl-clipboard-rs
    speedcrunch
    prismlauncher

    vscode-extensions.vadimcn.vscode-lldb.adapter
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Nihonielse";
      user.email = "146614313+Nihonielse@users.noreply.github.com";
      init.defaultBranch = "main";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./dotfiles;
        file = "p10k.zsh";
      }
    ];
  };

  programs.zed-editor = {
    enable = true;
    userSettings = {
      dap.CodeLLDB.binary = "${pkgs.vscode-extensions.vadimcn.vscode-lldb.adapter}/bin/codelldb";
      show_whitespaces = "trailing";
      indent_guides = {
        background_coloring = "indent_aware";
        coloring = "indent_aware";
      };
      restore_on_startup = "launchpad";
      project_panel.dock = "left";
      theme = "Ayu Dark";
      sticky_scroll.enable = true;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      input-overlay
      obs-livesplit-one
    ];
  };

  xdg.configFile = {
    "fontconfig/conf.d/09-user-fonts.conf".source = ./dotfiles/fontconfig.conf;
  };
  home.file = {
    ".local/bin/audio-toggle.sh".source = ./dotfiles/audio-toggle.sh;
  };
}
