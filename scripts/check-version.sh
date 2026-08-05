#!/usr/bin/env bash
set -euo pipefail

downloads_page_url="https://downloads.abacus.ch/en/downloads/abaclient/"

latest_version=$(curl -sL -A "Mozilla/5.0" "$downloads_page_url" \
  | grep -oE 'abaclient-[0-9]+(\.[0-9]+)*-en\.msi' \
  | sed -E 's/abaclient-([0-9.]+)-en\.msi/\1/' \
  | sort -V | tail -1)

if [ -z "$latest_version" ]; then
  echo "Could not find any AbaClient version on $downloads_page_url" >&2
  exit 1
fi
echo "Latest version on $downloads_page_url : $latest_version"

status_code=$(curl -sL -o /dev/null -w "%{http_code}" "https://community.chocolatey.org/packages/abaclient/$latest_version")

if [ "$status_code" = "200" ]; then
  echo "Version $latest_version is already released on Chocolatey, nothing to do."
else
  echo "Version $latest_version is not yet released on Chocolatey (status $status_code). New version available."
  echo "new_version=$latest_version" >> "$GITHUB_OUTPUT"
  echo "TAG=$latest_version" >> "$GITHUB_ENV"
fi
