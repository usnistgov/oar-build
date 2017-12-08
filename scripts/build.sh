#! /bin/bash
#
# build.sh:  build the package
#
prog=`basename $0`
execdir=`dirname $0`
[ "$execdir" = "" -o "$execdir" = "." ] && execdir=$PWD
codedir=`(cd $execdir/.. > /dev/null 2>&1; pwd)`
distdir=$codedir/dist

mkdir -p $distdir

# ENTER BUILD COMMANDS HERE
#
# The build products should be written into the "dist" directory

