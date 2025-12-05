# 云电脑保活功能使用说明

## Windows 用户

运行程序后，如果有多台云电脑，会显示列表供你选择：

```
可用的云电脑列表：
1. ID: 123456 | 名称: 我的云电脑1 | 状态: 运行中
2. ID: 789012 | 名称: 我的云电脑2 | 状态: 运行中

请选择要保活的云电脑（输入序号 1-2）：
```

输入对应的序号即可选择要保活的云电脑。

## Docker 用户

### 方式一：通过云电脑ID指定（推荐）

如果你知道云电脑的ID，可以直接指定：

```bash
docker run -d \
  --name ctyun \
  -e APP_USER="你的账号" \
  -e APP_PASSWORD='你的密码' \
  -e DESKTOP_ID='123456' \
  su3817807/ctyun:latest
```

### 方式二：通过索引选择

如果你不知道ID，可以通过索引选择（从1开始）：

```bash
docker run -d \
  --name ctyun \
  -e APP_USER="你的账号" \
  -e APP_PASSWORD='你的密码' \
  -e DESKTOP_INDEX='2' \
  su3817807/ctyun:latest
```

这会选择第2台云电脑进行保活。

### 方式三：默认选择

如果不设置任何参数，程序会自动选择第一台云电脑：

```bash
docker run -d \
  --name ctyun \
  -e APP_USER="你的账号" \
  -e APP_PASSWORD='你的密码' \
  su3817807/ctyun:latest
```

## 如何获取云电脑ID？

1. 首先不设置 `DESKTOP_ID` 运行一次
2. 查看日志：`docker logs ctyun`
3. 日志中会显示所有云电脑的ID和信息
4. 记下你想保活的云电脑ID，然后重新运行容器并设置 `DESKTOP_ID`

## 优先级说明

- `DESKTOP_ID` > `DESKTOP_INDEX` > 默认第一台
- 如果同时设置了 `DESKTOP_ID` 和 `DESKTOP_INDEX`，优先使用 `DESKTOP_ID`
