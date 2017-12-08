#! /bin/bash
#
# setversion.sh:  build all docker images in this directory
#
# Usage: setversion.sh
#
# This script can be edited to customize it for its package.
#
set -x
prog=`basename $0`
execdir=`dirname $0`
[ "$execdir" = "" -o "$execdir" = "." ] && execdir=$PWD
PACKAGE_DIR=`(cd $execdir/.. > /dev/null 2>&1; pwd)`
set -e

## This is set by default via _setversion.sh; if necessary, uncomment 
#  and customize
# 
# PACKAGE_NAME=oar-build

. $PACKAGE_DIR/oar-build/_setversion.sh

version=$(determine_version)

# write the package name and version to file called VERSION
write_VERSION $PACKAGE_NAME $version

# inject the version string into the source code
#
[ -e "$PACKAGE_DIR/scripts/inject_version.sh" ] && {
    bash "$PACKAGE_DIR/scripts/inject_version.sh" $version $PACKAGE_NAME
}
