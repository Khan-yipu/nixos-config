{
  description = "Personal Nix development environment configuration";

  inputs = {
    flake-compat.url = "github:NixOS/flake-compat";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    picom.url = "github:yaocccc/picom";

    # nixpkgs.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixpkgs-unstable&shallow=1";
    # nixpkgs-stable.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-25.11&shallow=1";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      # url = "git+https://gitee.com/mirrors/home-manager-nix";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    /*
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    */

    /*
    winapps = {
      url = "github:winapps-org/winapps";
      inputs = {
        flake-compat.follows = "flake-compat";
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };
    */

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    preservation = {
      url = "github:nix-community/preservation";
    };

    /*
    solaar = {
      url = "github:Svenum/Solaar-Flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    */

    /*
    stylix = {
      url = "github:nix-community/stylix";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
    */

    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    /*
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    */

    # dwm.url = "github:yaocccc/dwm";
    st.url = "github:Khan-yipu/st?ref=kif-remote";

    /*
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    */
  };

  # 如果通过 flake 安装 dwm, 在下面的 outputs 加上 dwm
  outputs = { self, nixpkgs, home-manager, nixvim, agenix, st, nixpkgs-stable, picom, ... }@inputs:
    let
      system = "x86_64-linux";
      # 辅助函数：构建 pkgs
      mkPkgs = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      # ==========================================
      # 场景 1: 非 NixOS Linux (Ubuntu, WSL, Arch 等)
      # ==========================================
      # 使用命令: home-manager switch --flake .#cake
      homeConfigurations = {
        cake = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs system;
          
          modules = [
            agenix.homeManagerModules.default
            ./home.nix
            nixvim.homeModules.nixvim
          ];
          
          extraSpecialArgs = { inherit inputs self; };
        };
      };

      # ==========================================
      # 场景 2: NixOS 虚拟机
      # ==========================================
      # 使用命令: sudo nixos-rebuild switch --flake .#nixos
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          
          modules = [
            # 1. 导入这台机器特有的配置
            ./hosts/nixos-vm/configuration.nix

            # 2. 将 Home Manager 作为 NixOS 模块加载
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              
              # 复用根目录下的 home.nix
              home-manager.users.khanif = {
                imports = [
                  agenix.homeManagerModules.default
                  ./home.nix
                  nixvim.homeModules.nixvim
                ];
              };

              # 传递 inputs 给 home.nix
              home-manager.extraSpecialArgs = { inherit inputs self; };
            }
          ];
        };

      # ==========================================
      # 场景 3: Matebook 笔记本
      # ==========================================
      # 使用命令: sudo nixos-rebuild switch --flake .#matebook
        matebook = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          
          modules = [
            # 1. 导入这台机器特有的配置
            ./hosts/matebook/configuration.nix

            # 2. 将 Home Manager 作为 NixOS 模块加载
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              
              # 复用根目录下的 home.nix
              home-manager.users.khanif = {
                imports = [
                  agenix.homeManagerModules.default
                  ./home.nix
                  nixvim.homeModules.nixvim
                ];
              };

              # 传递 inputs 给 home.nix
              home-manager.extraSpecialArgs = { inherit inputs self; };
            }
          ];
        };

      # ==========================================
      # 场景 4: khanixos laptop wujie
      # ==========================================
      # 使用命令: sudo nixos-rebuild switch --flake .#khanixos
        khanixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { 
            inherit inputs; 
            pkgs-stable = import nixpkgs-stable {
              inherit system;
              # 为了拉取 chrome 等软件包，
              # 这里我们需要允许安装非自由软件
              config.allowUnfree = true;
            };
          };
          
          modules = [
            # 1. 导入这台机器特有的配置
            ./hosts/laptop/configuration.nix

            # 2. 将 Home Manager 作为 NixOS 模块加载
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              
              # 复用根目录下的 home.nix
              home-manager.users.khanif = {
                imports = [
                  agenix.homeManagerModules.default
                  ./home.nix
                  nixvim.homeModules.nixvim
                ];
              };

              # 传递 inputs 给 home.nix
              home-manager.extraSpecialArgs = { inherit inputs self; };
            }

            {
              nixpkgs.overlays = [ 
                st.overlays.default
                # dwm.overlays.default 
                picom.overlays.default
              ];

              # st and tabbed Installation is put in the configuration.nix
            }
          ];
        };

      };
    };
}
