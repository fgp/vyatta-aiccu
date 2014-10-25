#!/bin/bash
set -e

nextversion="$1"

echo "Checking if the working copy contains uncommited changes..."
test "$(git status -s | wc -l)" = "0" || exit 1

if [ "$nextversion" != "" ]; then
	git-dch --new-version="$nextversion" --full --auto --snapshot
else
	git-dch --full --auto --snapshot
fi
git-buildpackage --git-ignore-new; result=$?
git checkout debian/changelog
exit $result
