# Docker 构建和运行指南

## 方式一：使用现有 Dockerfile（需要先本地构建）

### 1. 构建项目

在项目根目录执行：

```bash
# 发布项目到 publish 目录
dotnet publish CtYun/CtYun.csproj -c Release -o CtYun/publish
```

### 2. 构建 Docker 镜像

```bash
# 进入 CtYun 目录
cd CtYun

# 构建镜像
docker build -t ctyun:latest .
```

### 3. 运行容器

```bash
docker run -d \
  --name ctyun \
  -e APP_USER="你的账号" \
  -e APP_PASSWORD='你的密码' \
  -e DESKTOP_INDEX='1' \
  ctyun:latest
```

### 4. 查看日志

```bash
docker logs -f ctyun
```

---

## 方式二：使用多阶段构建（推荐）

这种方式不需要本地安装 .NET SDK，所有构建都在容器内完成。

### 1. 创建多阶段 Dockerfile

我已经为你创建了 `Dockerfile.multistage`，内容如下：

```dockerfile
# 第一阶段：构建
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# 复制项目文件
COPY CtYun.csproj .
RUN dotnet restore

# 复制所有源代码
COPY . .
RUN dotnet publish -c Release -o /app/publish

# 第二阶段：运行
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

ENV APP_USER=defaultuser \
    APP_PASSWORD=defaultpass

ENTRYPOINT ["dotnet", "CtYun.dll"]
```

### 2. 构建镜像

在项目根目录执行：

```bash
docker build -f CtYun/Dockerfile.multistage -t ctyun:latest ./CtYun
```

### 3. 运行容器

```bash
docker run -d \
  --name ctyun \
  -e APP_USER="你的账号" \
  -e APP_PASSWORD='你的密码' \
  -e DESKTOP_INDEX='1' \
  ctyun:latest
```

---

## 常用 Docker 命令

### 查看容器日志
```bash
docker logs -f ctyun
```

### 停止容器
```bash
docker stop ctyun
```

### 启动容器
```bash
docker start ctyun
```

### 删除容器
```bash
docker rm -f ctyun
```

### 删除镜像
```bash
docker rmi ctyun:latest
```

### 重新运行（删除旧容器并创建新容器）
```bash
docker rm -f ctyun
docker run -d \
  --name ctyun \
  -e APP_USER="你的账号" \
  -e APP_PASSWORD='你的密码' \
  -e DESKTOP_INDEX='1' \
  ctyun:latest
```

---

## 环境变量说明

| 环境变量 | 必填 | 说明 | 示例 |
|---------|------|------|------|
| APP_USER | 是 | 天翼云账号 | `13800138000` |
| APP_PASSWORD | 是 | 天翼云密码 | `yourpassword` |
| DESKTOP_ID | 否 | 指定云电脑ID | `123456` |
| DESKTOP_INDEX | 否 | 指定云电脑索引（从1开始） | `1` |
| LOAD_CACHE | 否 | 是否使用登录缓存 | `1` |

---

## 使用持久化存储（保存登录缓存）

如果想保存登录缓存，避免每次重启都重新登录：

```bash
docker run -d \
  --name ctyun \
  -v $(pwd)/cache:/app \
  -e APP_USER="你的账号" \
  -e APP_PASSWORD='你的密码' \
  -e LOAD_CACHE='1' \
  -e DESKTOP_INDEX='1' \
  ctyun:latest
```

这样 `connect.txt` 会保存在本地 `cache` 目录中。

---

## Docker Compose 方式（可选）

创建 `docker-compose.yml`：

```yaml
version: '3.8'

services:
  ctyun:
    build:
      context: ./CtYun
      dockerfile: Dockerfile.multistage
    container_name: ctyun
    environment:
      - APP_USER=你的账号
      - APP_PASSWORD=你的密码
      - DESKTOP_INDEX=1
      - LOAD_CACHE=1
    volumes:
      - ./cache:/app
    restart: unless-stopped
```

运行：
```bash
docker-compose up -d
```

查看日志：
```bash
docker-compose logs -f
```
