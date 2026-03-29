# Lean 4 Development Shell

基于 Nix Flakes 的 Lean 4 开发环境。

## 🌟 特性

- **Lean 4** - 交互式定理证明器和编程语言
- **Lake** - Lean 4 的包管理器和构建系统

## 📁 项目结构

```
.
├── flake.nix              # Nix 开发环境配置
├── .envrc                 # direnv 配置
├── README.md              # 说明文档
├── lakefile.lean          # Lake 项目配置
└── Main.lean              # 主程序入口
```

## 🚀 快速开始

1. 进入目录自动激活环境（需安装 `direnv`）：
   ```bash
   direnv allow
   ```

2. 运行程序：
   ```bash
   lake build
   ./build/bin/hello
   # 或者
   lake run
   ```

3. 创建新项目（如果需要）：
   ```bash
   lake new my-project
   ```