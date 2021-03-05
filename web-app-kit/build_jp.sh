#!/usr/bin/env bash
mkdir -p /opt/projects
cd /opt/projects
git clone --depth 1 https://github.com/jmespath/jp.git
cd jp
go mod init
go mod tidy
go build
