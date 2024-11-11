{ config, lib, pkgs, nixpkgs, ... }:
let
  p10kTheme = ./.config/p10k.zsh;
in
{
  home = {
    sessionVariables = { EDITOR = "emacsclient -t"; };
    stateVersion =
      "24.11";

    file.".config/alacritty/alacritty.toml".source = ./.config/alacritty/alacritty.toml;
    file.".config/sketchybar/sketchybarrc".source = ./.config/sketchybar/sketchybarrc;
    file.".config/sketchybar/sketchybarrc-laptop".source = ./.config/sketchybar/sketchybarrc-laptop;
    file.".config/sketchybar/plugins/battery.sh".source = ./.config/sketchybar/plugins/battery.sh;
    file.".config/sketchybar/plugins/clock.sh".source = ./.config/sketchybar/plugins/clock.sh;
    file.".config/sketchybar/plugins/front_app.sh".source = ./.config/sketchybar/plugins/front_app.sh;
    file.".config/sketchybar/plugins/spotify.sh".source = ./.config/sketchybar/plugins/spotify.sh;
    file.".p10k.zsh".source = ./.config/p10k.zsh;

    packages = with pkgs; [
      bat
      direnv
      zsh-powerlevel10k

    ];
  };

  programs = {

    emacs = {
      enable = true;
      package = pkgs.emacs29-macport;
      extraConfig = ''
        (setq standard-indent 2)
      '';
    };
    
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };


    bash.enable = true;

    home-manager.enable = true;
    
    zsh = {
      enable = true;
      initExtra = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      [ -n "$EAT_SHELL_INTEGRATION_DIR" ] && \
      source "$EAT_SHELL_INTEGRATION_DIR/zsh"
      PATH="/opt/homebrew/opt/libtool/libexec/gnubin:$PATH"

      eval "$(direnv hook zsh)"

      [[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ '
      export PATH="/Users/martin.brignall/.local/bin:$PATH"
      '';
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      shellAliases = {

        # Git
        g = "git";
        ga = "git add";
        gc = "git commit";
        gd = "git diff";
        gp = "git push";
        gs = "git status";

        # Productivity

        l = "ls -alh";
        ll = "ls -l";
        ls = "ls -la --color=tty";
        cat = "bat";
        ccat = "bat --color=always";

        # Nix

        build = "nix run nix-darwin -- switch --flake ~/git/nix-darwin/.";
        update = "nix flake update ~/git/nix-darwin/.";
        build-update = "nix run nix-darwin -- switch --flake ~/git/nix-darwin/. --update";

        # Python
        python = "python3";
        pip="pip3";
      };
      
      plugins = with pkgs; [{
        file = "powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }];
    };
  };
}
