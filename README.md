# LBBS-combo - Combination of all LeafOK BBS components

Chinese version of README.md is located at [README.zh_CN.md](README.zh_CN.md)

## Introduction

This package provides a pre-configured Docker-based running environment of LeafOK BBS, including both web version and telnet version, for testing or demo purposes.

## Installation

### Specify platforms of building targets and runtime version
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

## Copyright

Copyright (C) 2004-2026 Leaflet <leaflet@leafok.com>

## License

This program is free software; you can redistribute it and/or modify it under the terms of the [GNU General Public License](LICENSE) as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
