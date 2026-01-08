# LBBS-combo - LeafOK BBS 所有组件的组合包

英文版本的README.md位于[README.md](README.md)

## 简介

本软件包提供了一个预配置的基于 Docker 的 LeafOK BBS 运行环境，包含 Web 版本和 Telnet 版本，适用于测试或演示目的。

## 安装

### 选项 1: 从源代码构建
```bash
sh -x build.sh
```

### 选项 2: 拉取 Docker 镜像
```bash
docker compose pull
```

### 启动应用程序
```bash
docker compose up -d
```

## 版权

版权所有 (C) 2004-2026 Leaflet <leaflet@leafok.com>

## 许可证

本程序是自由软件；您可以依据自由软件基金会发布的 [GNU 通用公共许可证](LICENSE) 条款重新发布和/或修改本程序；许可证版本为第 3 版，或者（您可选）任何更高版本。