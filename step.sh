#!/usr/bin/env bash

# 'read' has to be before 'set -e'
read -r -d '' UNAVAILABLE_MESSAGE << EOF_MSG
Bitrise Build Cache is not activated in this build.

It seems you don't have an activate Bitrise Build Cache Trial or Subscription for the current workspace yet.

You can activate a Trial at [app.bitrise.io/build-cache](https://app.bitrise.io/build-cache),
or contact us at [support@bitrise.io](mailto:support@bitrise.io) to activate it.
EOF_MSG

set -eo pipefail

echo "Checking whether Bitrise Build Cache is activated for this workspace ..."
if [ "$BITRISEIO_BUILD_CACHE_ENABLED" != "true" ]; then
  printf "\n%s\n" "$UNAVAILABLE_MESSAGE"
  set -x
  bitrise plugin install https://github.com/bitrise-io/bitrise-plugins-annotations.git
  bitrise :annotations annotate "$UNAVAILABLE_MESSAGE" --style error || {
    echo "Failed to create annotation"
    exit 3
  }
  exit 2
fi
echo "Bitrise Build Cache is activated in this workspace"

set -x

# download the Bitrise Build Cache CLI
export BITRISE_BUILD_CACHE_CLI_VERSION=${BITRISE_BUILD_CACHE_CLI_VERSION:="v0.15.0-alpha.17+xcode"}
curl --retry 5 -sSfL 'https://raw.githubusercontent.com/bitrise-io/bitrise-build-cache-cli/main/install/installer.sh' | sh -s -- -b /tmp/bin -d $BITRISE_BUILD_CACHE_CLI_VERSION

# the cli command without the -d flag
cmd="/tmp/bin/bitrise-build-cache restore-xcode-deriveddata --project-root $project_root_path"

if [ -n "$cache_key" ]; then
  cmd="$cmd --key $cache_key"
fi

if [ "$verbose" = "true" ]; then
  cmd="$cmd -d"
fi

$cmd
