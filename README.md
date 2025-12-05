## 快速开始

📖 **新手推荐阅读：** [快速开始指南](QUICK_START.md)

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

### 方法一：使用构建脚本（最简单）

**Windows:** 双击运行 `build.bat`

**Linux/Mac:**
```bash
chmod +x build.sh
./build.sh
```

### 方法二：一行命令（推荐）

```bash
# 构建（简化版，2-3分钟）
docker build -f CtYun/Dockerfile.simple -t ctyun:latest ./CtYun

# 运行
docker run -d --name ctyun \
  -e APP_USER="你的账号" \
  -e APP_PASSWORD='你的密码' \
  -e DESKTOP_INDEX='1' \
  ctyun:latest
```

### 方法三：使用 Docker Compose

```bash
cp .env.example .env  # 编辑 .env 填入信息
docker-compose up -d
```

📖 详细说明：[Docker 构建文档](DOCKER_BUILD.md) | [快速开始](QUICK_START.md)


