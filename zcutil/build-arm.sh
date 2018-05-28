#!/bin/bash

set -eu -o pipefail

if [ "x$*" = 'x--help' ]
then
    cat <<EOF
Usage:

$0 --help
  Show this help message and exit.

$0 [ --enable-lcov ] [ MAKEARGS... ]
  Build Zcash and most of its transitive dependencies from
  source. MAKEARGS are applied to both dependencies and Zcash itself. If
  --enable-lcov is passed, Zcash is configured to add coverage
  instrumentation, thus enabling "make cov" to work.
EOF
    exit 0
fi

set -x
cd "$(dirname "$(readlink -f "$0")")/.."

# If --enable-lcov is the first argument, enable lcov coverage support:
LCOV_ARG=''
HARDENING_ARG='--disable-hardening'
if [ "x${1:-}" = 'x--enable-lcov' ]
then
    LCOV_ARG='--enable-lcov'
    HARDENING_ARG='--disable-hardening'
    shift
fi

# BUG: parameterize the platform/host directory:
PREFIX="$(pwd)/depends/aarch64-unknown-linux-gnu/"

HOST=aarch64-unknown-linux-gnu BUILD=aarch64-unknown-linux-gnu make "$@" -C ./depends/ V=1 NO_QT=1
./autogen.sh
./configure --prefix="${PREFIX}" --host=aarch64-unknown-linux-gnu --build=aarch64-unknown-linux-gnu --with-gui=no --enable-rust=no --disable-proton "$HARDENING_ARG" "$LCOV_ARG" CXXFLAGS='-fwrapv -fno-strict-aliasing -Werror -g'
make "$@" V=1
