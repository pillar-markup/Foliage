#!/usr/bin/env bash
# Bash3 Boilerplate. Copyright (c) 2014, kvz.io

set -o errexit
set -o pipefail
set -o nounset

#does not work on osx __dir=`readlink -f $0` # resolve symlink i.e. works if ~/bin/pillar is a symlink to this file
#__dir=`dirname "$__dir"` #obtain dir of the resolved path

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


PHARO_VM="${__dir}/pharo"
FOLIAGE_IMAGE="${__dir}/Pharo.image"

# disable parameter expansion to forward all arguments unprocessed to the VM
set -f

# TODO: when Pharo knows how to return the correct "current working directory", we
# can remove the --baseDirectory from here. The current solution is
# problematic because it overrides any baseDirectory parameter of the
# pillar.conf file.
exec "${PHARO_VM}" "${FOLIAGE_IMAGE}" --no-default-preferences clap publish "$@"
