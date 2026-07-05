{ config, pkgs, ... }:
let
  fetchAppImage = { name, url, sha256 }:
  pkgs.writeShellScriptBin name ''
    exec ${pkgs.appimage-run}/bin/appimage-run ${pkgs.fetchurl { curlOpts="-L --retry 3 -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'"; inherit url sha256; }}
  '';
in
{
  home.username = "nihoel";
  home.homeDirectory = "/home/nihoel";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    zsh
    appimage-run
    steam-run
    
    zed-editor
    discord
    steam
    lutris
    wine
    winetricks
    ungoogled-chromium
    antimicrox
    obs-studio
    obs-studio-plugins.input-overlay
    scrcpy
    fastfetch
    tetrio-desktop
    godot
    kdePackages.kdenlive
    inkscape

    gcc
    gdb
    clang-tools
    vscode-extensions.vadimcn.vscode-lldb
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
  
      initContent = ''
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';
    };

  
  xdg.configFile = {
    "fontconfig/conf.d/09-user-fonts.conf".source = ./dotfiles/fontconfig.conf;
    "kglobalshortcutsrc".source = ./dotfiles/kde-global-shortcut;
    "kwinrc".source = ./dotfiles/kde-kwin-setting;
  };
}
