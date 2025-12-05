#!/bin/bash

echo "=== 天翼云电脑保活 Docker 构建脚本 ==="
echo ""

# 检查是否安装了 Docker
if ! command -v docker &> /dev/null; then
    echo "错误：未检测到 Docker，请先安装 Docker"
    exit 1
fi

echo "选择构建方式："
echo "1. 简化版（推荐，构建快）"
echo "2. NativeAOT 版（性能优化，构建慢）"
read -p "请选择 [1/2，默认1]: " choice

case $choice in
    2)
        echo ""
        echo "使用 NativeAOT 版本构建（需要较长时间）..."
        DOCKERFILE="CtYun/Dockerfile.multistage"
        ;;
    *)
        echo ""
        echo "使用简化版构建..."
        DOCKERFILE="CtYun/Dockerfile.simple"
        ;;
esac

echo "1. 构建 Docker 镜像..."
docker build -f $DOCKERFILE -t ctyun:latest ./CtYun

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ 镜像构建成功！"
    echo ""
    echo "2. 运行容器示例："
    echo ""
    echo "docker run -d \\"
    echo "  --name ctyun \\"
    echo "  -e APP_USER=\"你的账号\" \\"
    echo "  -e APP_PASSWORD='你的密码' \\"
    echo "  -e DESKTOP_INDEX='1' \\"
    echo "  ctyun:latest"
    echo ""
    echo "3. 查看日志："
    echo "docker logs -f ctyun"
else
    echo ""
    echo "✗ 构建失败，请检查错误信息"
    exit 1
fi
