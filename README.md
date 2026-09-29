# LBBS-combo - Combination of all LeafOK BBS components

Chinese version of README.md is located at [README.zh_CN.md](README.zh_CN.md)

## Introduction

This package provides a pre-configured Docker-based running environment of LeafOK BBS, including both web version and telnet version, for testing or demo purposes.

## Installation

### Specify platforms of building targets and runtime version

Both variables are optional; the values below are used as defaults when they are not set.
When building on a non-amd64 host, set `RUN_PLATFORM` (and optionally `DOCKERHUB_PLATFORMS`)
to the platform of that host.
```bash
export DOCKERHUB_PLATFORMS="linux/amd64"
export RUN_PLATFORM="linux/amd64"
```

### Option 1: Build from source
```bash
sh -x build.sh
```

### Option 2: Pull Docker image
```bash
docker compose pull
```

### Start the application
```bash
docker compose up -d
```

## Usage

| Service    | Endpoint                      |
| ---------- | ----------------------------- |
| Web (HTTP) | <http://localhost:8080/bbs>   |
| SSH        | `ssh -p 2322 sysop@localhost` |
| Telnet     | `telnet localhost 2323`       |

The database is pre-loaded with sample data. The test account is `sysop` with the
temporary password `3anzHaNg`, which must be changed upon the first login.
Anonymous access is available with the user name `guest` on SSH and Telnet.

### Update Solr data from database, on demand or periodically
```bash
docker compose exec php /usr/local/bin/export_xml_to_solr.sh
```

### Stop the application
```bash
docker compose down
```

### Stop the application and remove all persistent data
```bash
docker compose down -v
```

## Copyright

Copyright (C) 2001-2026 Leaflet <leaflet@leafok.com>

## License

This program is free software; you can redistribute it and/or modify it under the terms of the [GNU General Public License](LICENSE) as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
