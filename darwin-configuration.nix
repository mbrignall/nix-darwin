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
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  
  home-manager.useUserPackages = true;

  # System packages
  environment.systemPackages = with pkgs; [
    # Applications
    alacritty
    bat
    black
    cmake
    colima
    ditaa
    direnv
    djlint
    docker
    docker-compose
    editorconfig-core-c
    fd
    gcc
    git
    gimp
    glib
    gnumake
    google-cloud-sdk
    go
    gopls
    nix-direnv
    html-tidy
    inkscape
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
    ispell
    jq
    lima
    mark
    nixd
    nixfmt
    nodejs
    nodePackages.bash-language-server
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.js-beautify
    nodePackages_latest.pnpm
    nodePackages.pyright
    nodePackages.stylelint
    nodePackages_latest.ts-node
    nodePackages.svgo
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.vscode-html-languageserver-bin
    pandoc
    postgresql
    python311
    python311Packages.black
    python311Packages.debugpy
    python311Packages.isort
    python311Packages.mypy
    python311Packages.rope
    python311Packages.pyflakes
    python311Packages.pylsp-mypy
    pipx
    remmina
    roswell
    ruff
    sbcl
    shellcheck
    shfmt
    sketchybar
    slack
    spotify
    stripe-cli
    syncthing
    terraform
    tex
    tree-sitter
    utm
    wget
    wkhtmltopdf-bin
    yamlfmt
    yaml-language-server
    yarn
    zellij
    zsh
    zsh-powerlevel10k

    #fonts
    fira-mono
    font-awesome
    font-awesome_5
    material-design-icons
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    terminus-nerdfont
    victor-mono
  ];
    
  # Auto upgrade nix package and the daemon service.eg
  services = {

    emacs = {
      enable = true;
      package = pkgs.emacs29-macport;
    };
    nix-daemon.enable = true;

    sketchybar = {
      enable = true;
      package = pkgs.sketchybar;
    };

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
        persistent-others = [ "~/projects" ];
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
