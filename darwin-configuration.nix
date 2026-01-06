{ config, pkgs, ... }:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-medium dvisvgm dvipng enumitem xifthen ifmtarg academicons multirow
      fontawesome fontawesome5 sourcesanspro sourcecodepro inconsolata tcolorbox
      environ trimspaces wrapfig amsmath ulem hyperref capt-of tikzfill moderncv
      arydshln;
    #(setq org-latex-compiler "lualatex")
    #(setq org-preview-latex-default-process 'dvisvgm)
  });

in {

  # List packages installed in system profile.
  # allow the unfree stuff
  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  home-manager.useUserPackages = true;

  # System packages
  environment.systemPackages = with pkgs; [
    # Applications
    bat
    clang
    cmake
    direnv
    docker
    docker-compose
    docker-compose-language-service
    editorconfig-core-c
    fd
    gcc
    git
    gimp
    glib
    gnumake
    google-cloud-sdk
    nix-direnv
    html-tidy
    inkscape
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
    ispell
    jq
    mark
    nasm
    pandoc
    postgresql
    python311
    qemu
    raylib
    rio
    tex
    tree-sitter
    utm
    wget
    wkhtmltopdf-bin
    yamlfmt
    yaml-language-server
    zsh
    zsh-powerlevel10k

  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-mono
    nerd-fonts.droid-sans-mono
  ];

  
  # Auto upgrade nix package and the daemon service.eg
  services = {
    
    nix-daemon.enable = true;

    tailscale = {
      enable = true;
      package = pkgs.tailscale;
    };


  };

  # System State Version
  
    system = {
    
    activationScripts.postUserActivation.text = ''
      # Following line should allow us to avoid a logout/login cycle
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
    
    stateVersion = 5;

    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.2;
        expose-animation-duration = 0.2;
        show-recents = false;
        launchanim = false;
        static-only = false;
        mouse-over-hilite-stack = true;
        orientation = "bottom";
        tilesize = 36;
        mru-spaces = false;
        persistent-apps =
          [
            "${pkgs.rio}/Applications/Rio.app"
          ];
        persistent-others = [ "/Users/martin.brignall/projects" ];
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        FXPreferredViewStyle = "clmv";
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = false;
        _FXSortFoldersFirst = true;
      };

      NSGlobalDomain = {
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        KeyRepeat = 1;
        InitialKeyRepeat = 18;
        "com.apple.sound.beep.volume" = 0.000;
        _HIHideMenuBar = true;
        NSWindowResizeTime = 0.001;
        NSTableViewDefaultSizeMode = 1;
      };
      
      
    };
    };
    
    programs.zsh.enable = true;
}
