{ config, pkgs, inputs, ... }:
{
  home.username = "nihoel";
  home.homeDirectory = "/home/nihoel";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    appimage-run
    steam-run

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    zed-editor
    discord
    steam
    lutris
    ungoogled-chromium
    antimicrox
    obs-studio
    obs-studio-plugins.input-overlay
    scrcpy
    tetrio-desktop
    godot
    kdePackages.kdenlive
    inkscape
    wl-clipboard-rs
    speedcrunch
    prismlauncher
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

  xdg.configFile = {
    "fontconfig/conf.d/09-user-fonts.conf".source = ./dotfiles/fontconfig.conf;
  };
  home.file = {
    ".local/bin/audio-toggle.sh".source = ./dotfiles/audio-toggle.sh;
  };
}
