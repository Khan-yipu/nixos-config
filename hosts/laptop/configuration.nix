# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, pkgs-stable, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.mangowm.nixosModules.mango
  ];

  nix.settings.trusted-users = [
    "root"
    "khanif"
  ];
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # 国内加速（永久生效）
  nix.settings = {
    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store" # 中科大（可优先）
      # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" # 清华
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 12;
  boot.loader.efi.canTouchEfiVariables = true;
  /*
    boot.loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  */

  networking.hostName = "khanixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # 系统级代理设置
  /*
    networking.proxy = {
      default = "http://127.0.0.1:7897";
      httpProxy = "http://127.0.0.1:7897";
      httpsProxy = "http://127.0.0.1:7897";
      noProxy = "localhost,127.0.0.1,::1,*.local";
    };
  */

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    QT5_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    /*
      http_proxy = "http://127.0.0.1:7897";
      https_proxy = "http://127.0.0.1:7897";
      no_proxy = "localhost,127.0.0.1,::1,*.local";
    */
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      qt6Packages.fcitx5-configtool
      qt6Packages.fcitx5-chinese-addons # 拼音、五笔等
      catppuccin-fcitx5
      # fcitx5-configtool
      # fcitx5-chinese-addons
    ];
  };

  /*
    console = {
      font = "Lat2-Terminus16";
      keyMap = lib.mkDefault "us";
      useXkbConfig = true; # use xkb.options in tty.
    };
  */

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    dejavu_fonts
    # sarasa-gothic
    iosevka
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [
          "Noto Sans"
          "Noto Sans CJK SC"
        ];
        sansSerif = [
          "Noto Serif"
          "Noto Serif CJK SC"
        ];
        monospace = [ 
          "Fira Code"
          "Iosevka" 
        ];
      };
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # enable wayland
  programs.xwayland.enable = true;

  # Use SDDM as Display Manager (Wayland compatible)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
  };
  # services.xserver.displayManager.lightdm.enable = true;
  # services.displayManager.gdm.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.desktopManager.gnome.enable = true;

  security.pam.services = {
    gtklock.enable = true;
    i3lock.enable = true;
    xss-lock.enable = true;
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;

  # XFCE
  # services.xserver.desktopManager.xfce.enable = true;

  # Niri
  programs.niri.enable = true;
  # 也可以使用 flake 安装 Niri

  programs.mango.enable = true;

  # LXQT(lxqt)
  services.xserver.desktopManager.lxqt.enable = false;

  # KDE Plasma 
  services.desktopManager.plasma6.enable = true;

  services.xserver.windowManager.dwm = {
    enable = true;
    package = pkgs.dwm.overrideAttrs {
      src = ../../modules/Desktop/dwm;
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
    # options = "eurosign:e,caps:escape";
  };

  # keyboard remapping 
  services.keyd.enable = true;
  /*
    意外情况
    在某些时候，错误的配置可能导致严重后果（例如键盘无法正常使用，或无法恢复配置）。当然，这属于极端情况。正常来讲，错误的配置要么无效，要么不影响下次修改。但一旦真的出现了极端情况，停止 keyd 进程就是恢复键盘的后路。结束 keyd 方法如下：
    同时按下 Backspace（空格）+ Enter + Esc 键，即可让 keyd 自动退出。一切配置都会失效。这时候你就可以轻易还原配置了。但有一个常见状况是：你无论如何发现 keyd 都结束不了（或结束后自动启动）。这往往是 init 程序的自动重启策略导致的。执行以下命令：
    systemctl cat keyd.service | grep Restart
    如果输出的 Restart 值为 always，那么我们就需要将其修改为 no。在 NixOS 中，添加如下配置：
    {
        # 紧急情况下允许 keyd 终止自身
        systemd.services.keyd.serviceConfig = {
            Restart = lib.mkForce "no"; 
        };
    }
    其它发行版手动编辑相关的 service 文件即可。
  */

  /*
  users.groups.keyd = {};
  # 紧急情况下允许 keyd 终止自身
  systemd.services.keyd.serviceConfig = {
    Restart = lib.mkForce "no"; 
  };
  # Optional, but makes sure that when you type the make palm rejection work with keyd
  # https://github.com/rvaiya/keyd/issues/723
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';
  */

  zramSwap.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.khanif = {
    isNormalUser = true;
    description = "khanif";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
      #  thunderbirsshd
    ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDSIrmA5gpjJ5aMqMPevdr53qcMZt7rVp7gI5BvoBQ9R2AU8tzKIWMPGfPVEjcwEUILIZHmlKZ0BXtfQh1UY912FoVFcSaohZQdTN8IbR6Y3QbjMDs+RuA10y9Ajjn4s1hWE9ZwbHk1zSRXm6Z83zW2ZmLXDUnLKIQengiblQh0NUYCcqI5JaO2X9kSQ0r6i77nv86HPAI/DgPe6HvBoLg8E+U5bsgdeqxLxTRavmectvAItoynzVzT7SpkPLqMP/kooUoGsDQjbmwGNIjUnEEZifzIPfkua1avzOdaQJzKQHkl4L/mOZWPBMBXx4oVJiuKmYyWP9Pw93mOvX20PhWqCacpZg3aXAwonRVN0leaUfoa4gVc4a8j4UOOZmEi0n08SFwboSsjjI/KTioEY24GAQUyFwVoUBYZVGEK35U/6ep8PgEVzLSR0ieF8hiGWB52tfF2WJ3tUBfg0o83L0Ve88Kzb+7HIu6FoF3dNytVGNdbPMFfRjkU7gpU06oU2r0= khwin@www"
    ];
  };

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  # Install firefox.
  programs.firefox.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # programs.opencode.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  programs.fuse = {
    enable = true;
    userAllowOther = true;
  };

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    flclash
    qq
    # qqmusic

    # CloudDrive:默认地址 http://127.0.0.1:19798/
    # clouddrive2
    fuse3 

    xwayland
    xwayland-satellite

    google-chrome
    firefox

    yazi
    file
    wget
    curl
    fastfetch

    ffmpeg
    libva
    libva-utils
    power-profiles-daemon
    bluez
    cachix
    pulseaudio
    pciutils

    git
    vim
    micro
    vscode

    python3
    uv
    nodejs
    claude-code
    mcp-nixos

    # Sublime Merge and Sublime Text
    # sublime4
    sublime-merge

    st
    tabbed

    keyd 
  ];

  programs.clash-verge = {
    enable = true;
    package = pkgs-stable.clash-verge-rev;
    # package = pkgs-unstable.clash-verge-rev;
    # package = pkgs.clash-verge-rev;
    # autostart = true;
    tunMode = true;
    serviceMode = true;
  };

  # services.vscode-server.enable = true;
  programs.nix-ld.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.timesyncd.enable = true;

  # U盘自动加载
  services.udisks2.enable = true;

  /*
    # garbage collection
    nix.gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 21d";
    };
  */

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  hardware = {
    enableAllFirmware = true; # 自动安装所有固件
    cpu.intel.updateMicrocode = true; # Intel CPU
    # cpu.amd.updateMicrocode = true; # AMD CPU
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      intel-vaapi-driver
    ];
  };

  hardware.opentabletdriver.enable = true;
  hardware.uinput.enable = true;
  boot.kernelModules = [ 
    "uinput" 
    "fuse" 
  ];

  # =========================================================================

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 19798 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "mihomo" ];
    # checkReversePath = "loose"; # or set to be false
    checkReversePath = false; # or set to be false
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
