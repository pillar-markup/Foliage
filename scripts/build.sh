#!/usr/bin/env bash
# Bash3 Boilerplate. Copyright (c) 2014, kvz.io

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

# helper functions

function get_platform_identifier() {
  local TMP_OS=`uname | tr "[:upper:]" "[:lower:]"`
  if [[ "{$TMP_OS}" = *darwin* ]]; then
    echo "mac";
  elif [[ "{$TMP_OS}" = *linux* ]]; then
    echo "linux";
  elif [[ "{$TMP_OS}" = *win* ]]; then
    echo "win";
  elif [[ "{$TMP_OS}" = *mingw* ]]; then
    echo "win";
  elif [[ "{$TMP_OS}" = *msys* ]]; then
    echo "win";
  else
    echo "Unsupported OS";
    exit 1;
  fi
}

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__builddir="$(pwd)/build"
PHARO_VERSION="${PHARO_VERSION:-130}"

#Was changed by luc logic
PHARO="./pharo Pharo.image --no-default-preferences"

rm -rf "${__builddir}" && mkdir -p "${__builddir}" && cd "${__builddir}"

# I reverted luc changes because it breaks on my machine - no pharo anymore. 
wget -O - get.pharo.org/64/${PHARO_VERSION}+vm | bash

#if command -v pharo >/dev/null 2>&1; then
#  echo "pharo is in PATH"
#  PHARO_VM_BIN="pharo"
#  wget -O - get.pharo.org/64/${PHARO_VERSION} | bash
#else
#  echo "pharo not found in PATH"
#  PHARO_VM_BIN="./pharo"
#fi
# PHARO="$PHARO_VM_BIN Pharo.image --no-default-preferences"

REPOSITORY_PATH=${__dir}/../src
OS=$(get_platform_identifier)
if [ "$OS" == "win" ]; then
    REPOSITORY_PATH=$(cygpath $REPOSITORY_PATH --windows)
fi

${PHARO} st --quit --save "${__dir}/unload_md.st"

${PHARO} eval --save "Iceberg remoteTypeSelector: #httpsUrl. Metacello new baseline: 'Foliage'; repository: 'gitlocal://${REPOSITORY_PATH}'; load"

${PHARO} eval --save "Deprecation raiseWarning: false."
${PHARO} eval --save "Deprecation showWarning: false."
${PHARO} eval --save "StartupPreferencesLoader allowStartupScript: false."

# UserManager 
${PHARO} eval --save "PharoFilesOpener default unsetInformAboutReadOnlyChanges."
${PHARO} eval --save "Smalltalk logFileName: '/tmp/FoliageApp.log'"

cp "${__dir}/wrappers/"* "${__builddir}"
chmod +x "${__builddir}"/foliage
chmod +x "${__builddir}"/foliage-db
