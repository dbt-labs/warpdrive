#!/usr/bin/env bash

#
# Copyright (C) 2020-2022 Dremio Corporation
#
# See “license.txt” for license information.

# This script is to facilitate building the Driver on Linux

set -e

mkdir -p _build
cd _build

ARROW_GIT_REPOSITORY="${ARROW_GIT_REPOSITORY:=https://github.com/apache/arrow}"
ARROW_GIT_TAG="${ARROW_GIT_TAG:=b050bd0d31db6412256cec3362c0d57c9732e1f2}"
ODBCABSTRACTION_REPO="${ODBCABSTRACTION_REPO:=/opt/flightsql-odbc}"
ODBCABSTRACTION_GIT_TAG="${ODBCABSTRACTION_GIT_TAG:=e065ed04971f56f28e12e503487ac0718a1422bb}"

cmake \
  -GNinja \
  -DOPENSSL_INCLUDE_DIR=/usr/include/openssl \
  -DODBCABSTRACTION_REPO=$ODBCABSTRACTION_REPO \
  -DODBCABSTRACTION_GIT_TAG=$ODBCABSTRACTION_GIT_TAG \
  -DARROW_GIT_REPOSITORY=$ARROW_GIT_REPOSITORY \
  -DARROW_GIT_TAG=$ARROW_GIT_TAG \
  ..
# Ninja should be called at most four times for clean builds
ninja || ninja || ninja || ninja
