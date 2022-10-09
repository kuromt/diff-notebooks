#!/usr/bin/env bash
set -ex

if [ -n $1 ]; then
    echo "set new base"
    BASE="origin/${GITHUB_BASE_REF}"
else
    echo "use default base"
    BASE=$1
fi
REMOTE=$2
PORT=$3
EXPORT_DIR=$4
NBDIFF_WEB_EXPORTER_OPTIONS=$5

mkdir -p $EXPORT_DIR
git diff $BASE $REMOTE --name-only| grep '.ipynb$'|xargs -L 1 nbdiff-web-exporter --port $PORT --export-dir $EXPORT_DIR $BASE $REMOTE 
echo "::set-output name=export_dir::$EXPORT_DIR"
