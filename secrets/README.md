# Secrets 加密管理

本目录存放通过 [agenix](https://github.com/ryantm/agenix) + [age](https://github.com/FiloSottile/age) 加密的 API 密钥文件。

## 加密机制

- **加密工具**: `age`，基于公钥加密（X25519）
- **密钥来源**: 本机的 SSH ed25519 公钥，通过 `ssh-to-age` 转换为 age 公钥后用于加密
- **解密密钥**: 本机的 SSH ed25519 私钥 (`~/.ssh/id_ed25519`)
- **Nix 集成**: 通过 agenix home-manager 模块，`home-manager switch` 时自动解密到 `~/.config/ai-secrets/`

### 加密流程

```
原始密钥 → age encrypt -r <age公钥> → *.age 文件 → git 提交到仓库
                                              ↓
                         home-manager switch → agenix 自动解密 → ~/.config/ai-secrets/
```

### 当前加密文件

| 文件 | 用途 |
|------|------|
| `anthropic_api_key.age` | Anthropic / NewCLI Claude API Key |
| `chatanywhere_api_key.age` | ChatAnywhere API Key |
| `siliconflow_api_key.age` | SiliconFlow API Key |
| `deepseek_api_key.age` | DeepSeek API Key |
| `ark_api_key.age` | Ark (Volcengine) API Key |

## 日常操作

### 编辑密钥（自动解密 + 编辑 + 重新加密）

```bash
nix run github:ryantm/agenix -- -e secrets/anthropic_api_key.age
```

### 手动解密单个文件

```bash
nix run nixpkgs#age -- --decrypt -i ~/.ssh/id_ed25519 -o /tmp/key secrets/anthropic_api_key.age
```

### 重新加密所有密钥（更换 recipient 后）

```bash
for f in secrets/*.age; do
  plaintext=$(nix run nixpkgs#age -- --decrypt -i ~/.ssh/id_ed25519 "$f")
  echo "$plaintext" | nix run nixpkgs#age -- --encrypt -r <age公钥> -o "$f"
done
```

## 在新机器上解密

在新机器上使用此仓库前，需要确保该机器拥有对应的解密密钥。有两种方案：

### 方案 A：复制 SSH 私钥（推荐，最简单）

将本机的 SSH ed25519 私钥安全地复制到新机器：

```bash
# 从本机复制（使用 scp 或 U 盘等安全方式）
scp ~/.ssh/id_ed25519 newhost:~/.ssh/id_ed25519
scp ~/.ssh/id_ed25519.pub newhost:~/.ssh/id_ed25519.pub

# 在新机器上设置权限
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

之后在新机器上运行 `home-manager switch` 即可自动解密。

### 方案 B：添加新机器的公钥为额外 recipient

如果新机器有自己的 SSH 密钥且你不想复制旧私钥：

1. 在新机器上获取 age 公钥：
   ```bash
   nix run nixpkgs#ssh-to-age -- < ~/.ssh/id_ed25519.pub
   ```

2. 用新旧两个公钥重新加密所有密钥：
   ```bash
   # 查看当前 age 公钥
   OLD_PUB=$(nix run nixpkgs#ssh-to-age -- < ~/.ssh/id_ed25519.pub)
   NEW_PUB="age1xxxx..."  # 新机器的 age 公钥

   for f in secrets/*.age; do
     plaintext=$(nix run nixpkgs#age -- --decrypt -i ~/.ssh/id_ed25519 "$f")
     echo "$plaintext" | nix run nixpkgs#age -- --encrypt -r "$OLD_PUB" -r "$NEW_PUB" -o "$f"
   done
   ```

3. 提交更新后的 `.age` 文件。新旧机器均可解密。

> **建议**：长期维护多台机器时，可在仓库中维护一个 `.sops.yaml` 式的 recipient 列表，避免遗漏公钥。

### 方案 C：使用 age 自身密钥（不依赖 SSH）

如果不希望依赖 SSH 密钥：

```bash
# 生成 age 专用密钥对
nix run nixpkgs#age-keygen -- -o ~/.config/sops/age/keys.txt

# 获取公钥
nix run nixpkgs#age-keygen -- -y ~/.config/sops/age/keys.txt

# 在 agenix 配置中指定 identityPaths：
# age.identityPaths = [ "/home/cake/.config/sops/age/keys.txt" ];
```

然后在 `modules/secrets.nix` 或 `home.nix` 中设置 `age.identityPaths`。

## 安全注意事项

- `.age` 文件可以安全提交到 Git 公开仓库（只有拥有对应私钥的人才能解密）
- **永远不要**将解密后的明文密钥提交到 Git
- 更换 SSH 密钥后，务必用新公钥重新加密所有 `.age` 文件
- `~/.config/ai-secrets/` 目录（解密目标）已在 `.gitignore` 中排除
