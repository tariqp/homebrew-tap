#!/bin/sh
# Fills the sha256 of a released NotchControl zip into Casks/notchcontrol.rb.
# Usage: ./update-cask.sh 0.1.0
set -e
V="$1"; [ -n "$V" ] || { echo "usage: $0 <version>"; exit 1; }
URL="https://github.com/tariqp/notchcontrol/releases/download/v$V/NotchControl-$V.zip"
SHA=$(curl -sL "$URL" | shasum -a 256 | cut -d' ' -f1)
sed -i '' -e "s/^  version \".*\"/  version \"$V\"/" -e "s/^  sha256 \".*\"/  sha256 \"$SHA\"/" Casks/notchcontrol.rb
echo "notchcontrol $V sha256 $SHA"
