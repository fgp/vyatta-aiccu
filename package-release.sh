#!/bin/bash
set -e

version="$1"

if [ "$nextversion" = "" ]; then
	echo "Usage: $0 <version>" >&2
fi

echo "Checking if the working copy contains uncommited changes..."
test "$(git status -s | wc -l)" = "0" || exit 1

git-dch --new-version="$version" --release
git commit -m "Updated changelog for release of $version" debian/changelog
git-buildpackage --git-tag
