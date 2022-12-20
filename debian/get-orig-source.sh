#!/bin/sh
set -e
export TAR_OPTIONS='--owner root --group root --mode a+rX'
export GZIP_OPTIONS='-9n'
pwd=$(pwd)
version="$1"
if [ -z "$version" ]
then
    printf 'Usage: %s <version>\n' "$0"
    exit 1
fi
cd "$(dirname "$0")/../"
tmpdir=$(mktemp -t -d get-orig-source.XXXXXX)
uscan --noconf --force-download --rename --download-version="$version" --destdir="$tmpdir"
cd "$tmpdir"
unzip -q libb64*.zip
rm libb64*.zip
mv libb64*/ libb64-${version}.orig
tar -czvvf "$pwd/libb64_${version}.orig.tar.gz" libb64-*.orig/
cd ..
rm -rf "$tmpdir"

# vim:ts=4 sw=4 et
