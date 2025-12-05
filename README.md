## 快速开始

### Windows 用户

直接下载 Releases 执行即可。只需要登录一次，登录成功会保存缓存数据。

### docker使用指南

```
docker run -d \
  --name ctyun \
  -e APP_USER="你的账号" \
  -e APP_PASSWORD='你的密码' \
  su3817807/ctyun:latest

```

#### 可选环境变量

```
# 使用登录缓存（不写为不使用，1为使用）
-e LOAD_CACHE='1'

# 指定要保活的云电脑ID（精确匹配）
-e DESKTOP_ID='你的云电脑ID'

# 或者通过索引选择（从1开始，例如1表示第一台）
-e DESKTOP_INDEX='1'

# 注意：如果同时设置了 DESKTOP_ID 和 DESKTOP_INDEX，优先使用 DESKTOP_ID
# 如果都不设置，默认选择第一台云电脑
```

#### 完整示例

```
docker run -d \
  --name ctyun \
  -e APP_USER="你的账号" \
  -e APP_PASSWORD='你的密码' \
  -e LOAD_CACHE='1' \
  -e DESKTOP_INDEX='2' \
  su3817807/ctyun:latest
```

### 查看日志检查是否登录并连接成功

```bash
docker logs -f ctyun
```

---

## Docker 构建指南

### 方法一：使用构建脚本（推荐）

**Windows:**
```bash
build.bat
```

**Linux/Mac:**
```bash
chmod +x build.sh
./build.sh
```

### 方法二：手动构建

```bash
# 构建镜像
docker build -f CtYun/Dockerfile.multistage -t ctyun:latest ./CtYun

# 运行容器
docker run -d \
  --name ctyun \
  -e APP_USER="你的账号" \
  -e APP_PASSWORD='你的密码' \
  -e DESKTOP_INDEX='1' \
  ctyun:latest
```

### 方法三：使用 Docker Compose

1. 复制 `.env.example` 为 `.env` 并填入你的信息
2. 运行：
```bash
docker-compose up -d
```

详细说明请查看 [DOCKER_BUILD.md](DOCKER_BUILD.md)


