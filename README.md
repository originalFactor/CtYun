### windows用户直接下载Releases执行即可。

只需要登录一次即可，登录成功会保存缓存数据，

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

### 查看日志检查是否登录并连接成功。

```
docker logs -f ctyun

```


