# 快速开始指南

## 最快方式（推荐）

### Windows 用户

1. 双击运行 `build.bat`
2. 选择 `1`（简化版，构建快）
3. 等待构建完成
4. 按照提示运行容器

### Linux/Mac 用户

```bash
chmod +x build.sh
./build.sh
# 选择 1（简化版）
```

---

## 一行命令构建运行

### 简化版（推荐，2-3分钟）

```bash
# 构建
docker build -f CtYun/Dockerfile.simple -t ctyun:latest ./CtYun

# 运行
docker run -d --name ctyun \
  -e APP_USER="你的账号" \
  -e APP_PASSWORD='你的密码' \
  -e DESKTOP_INDEX='1' \
  ctyun:latest

# 查看日志
docker logs -f ctyun
```

### NativeAOT 版（性能优化，5-10分钟）

```bash
# 构建（需要较长时间）
docker build -f CtYun/Dockerfile.multistage -t ctyun:latest ./CtYun

# 运行
docker run -d --name ctyun \
  -e APP_USER="你的账号" \
  -e APP_PASSWORD='你的密码' \
  -e DESKTOP_INDEX='1' \
  ctyun:latest

# 查看日志
docker logs -f ctyun
```

---

## 使用 Docker Compose

1. 复制环境变量文件：
```bash
cp .env.example .env
```

2. 编辑 `.env` 文件，填入你的账号密码

3. 启动：
```bash
docker-compose up -d
```

4. 查看日志：
```bash
docker-compose logs -f
```

---

## 两种构建方式对比

| 特性 | 简化版 | NativeAOT 版 |
|------|--------|-------------|
| 构建时间 | 2-3 分钟 | 5-10 分钟 |
| 镜像大小 | ~200MB | ~100MB |
| 启动速度 | 正常 | 更快 |
| 内存占用 | 正常 | 更少 |
| 推荐场景 | 日常使用 | 生产环境 |

**建议：** 首次使用选择简化版，如需优化性能再使用 NativeAOT 版。

---

## 常见问题

### Q: 构建失败怎么办？
A: 确保 Docker 正常运行，网络连接正常。如果使用 NativeAOT 版失败，改用简化版。

### Q: 如何选择要保活的云电脑？
A: 设置环境变量 `DESKTOP_INDEX=2` 选择第2台，或 `DESKTOP_ID=123456` 指定ID。

### Q: 如何更新容器？
A: 
```bash
docker rm -f ctyun
docker build -f CtYun/Dockerfile.simple -t ctyun:latest ./CtYun
docker run -d --name ctyun -e APP_USER="账号" -e APP_PASSWORD='密码' ctyun:latest
```

### Q: 如何保存登录缓存？
A: 添加卷挂载：`-v $(pwd)/cache:/app -e LOAD_CACHE='1'`
