#!/usr/bin/env bash
set -e

LATEST_VERSION=$(curl -s https://api.github.com/repos/containers/bubblewrap/releases/latest | jq -r .tag_name | sed 's/v//')
echo "LATEST_VERSION=$LATEST_VERSION"
TAR_FNAME="bubblewrap-${LATEST_VERSION}.tar.xz"
SRC_DIR='src'

if [ -f "$TAR_FNAME" ]; then
    echo "File $TAR_FNAME already exists. Skipping download."
else
    echo "Downloading $TAR_FNAME..."
    curl -L "https://github.com/containers/bubblewrap/releases/download/v${LATEST_VERSION}/$TAR_FNAME" -o "$TAR_FNAME"
fi

# Remove existing 'src' directory if it exists
if [ -d "$SRC_DIR" ]; then
    echo "Removing existing $SRC_DIR directory..."
    rm -rf "$SRC_DIR"
fi

# Extract the tarball
echo "Extracting $TAR_FNAME to $SRC_DIR..."
mkdir "$SRC_DIR"
tar -xf "$TAR_FNAME" --strip-components=1 -C "$SRC_DIR"

echo "Extraction complete."

pushd "$SRC_DIR"

meson setup _builddir
meson compile -C _builddir
meson test -C _builddir

popd

if [ -d release ]; then
    echo "Removing existing release directory..."
    rm -rf release
fi
mkdir release
cp "$SRC_DIR/_builddir/bwrap" release
