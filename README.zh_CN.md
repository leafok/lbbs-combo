# LBBS-combo - LeafOK BBS 所有组件的组合包

英文版本的README.md位于[README.md](README.md)

## 简介

本软件包提供了一个预配置的基于 Docker 的 LeafOK BBS 运行环境，包含 Web 版本和 Telnet 版本，适用于测试或演示目的。

## 安装

### 指定构建目标和运行版本的平台

两个变量均为可选，未设置时使用下面的默认值。
在非 amd64 主机上构建时，请将 `RUN_PLATFORM`（以及可选的 `DOCKERHUB_PLATFORMS`）设置为该主机的平台。
```bash
export DOCKERHUB_PLATFORMS="linux/amd64"
export RUN_PLATFORM="linux/amd64"
```

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

## 使用

| 服务        | 访问地址                      |
| ---------- | ----------------------------- |
| Web (HTTP) | <http://localhost:8080/bbs>   |
| SSH        | `ssh -p 2322 sysop@localhost` |
| Telnet     | `telnet localhost 2323`       |

数据库已预置示例数据。测试帐号为 `sysop`，临时密码为 `3anzHaNg`，首次登录后必须修改。
在 SSH 和 Telnet 上可使用帐号 `guest` 匿名访问。

### 根据需要或定期从数据库更新 Solr 数据
```bash
docker compose exec php /usr/local/bin/export_xml_to_solr.sh
```

### 停止应用程序
```bash
docker compose down
```

### 停止应用程序并删除所有持久化数据
```bash
docker compose down -v
```

## 版权

版权所有 (C) 2001-2026 Leaflet <leaflet@leafok.com>

## 许可证

本程序是自由软件；您可以依据自由软件基金会发布的 [GNU 通用公共许可证](LICENSE) 条款重新发布和/或修改本程序；许可证版本为第 3 版，或者（您可选）任何更高版本。
