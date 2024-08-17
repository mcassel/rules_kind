#!/usr/bin/env bash

COMMIT=$(git describe --always --dirty)
PREFIX="rules_kind-$COMMIT"
ARCHIVE="$PREFIX.tar.gz"

git archive --format=tar --prefix=$PREFIX/ HEAD | gzip > $ARCHIVE
shasum -a 256 $ARCHIVE > $ARCHIVE.sha256
