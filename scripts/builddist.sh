#! /bin/bash
#
# builddist.sh:  build and bundle up the package build products
#
prog=`basename $0`
execdir=`dirname $0`
[ "$execdir" = "" -o "$execdir" = "." ] && execdir=$PWD
codedir=`(cd $execdir/.. > /dev/null 2>&1; pwd)`
distdir=$codedir/dist

true ${OAR_BUILD_DIR:=$codedir/oar-build}

set -ex
$execdir/build.sh
$OAR_BUILD_DIR/bundle_dist.sh


