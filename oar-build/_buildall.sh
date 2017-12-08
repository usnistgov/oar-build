#! /bin/bash
#
# Processes command line arguments for buildall.sh and defines functions it
# can use.
#
set -e
true ${prog:=_buildall.sh}

[ -z "$codedir" ] && {
    echo "${prog}: \$codedir is not set."
    exit 10
}

true ${OAR_BUILD_DIR:=$codedir/oar-build}
true ${OAR_DOCKER_DIR:=$codedir/docker}
true ${PACKAGE_NAME:=`basename $codedir`}

[ -z "$DOCKER_IMAGE_DIRS" ] && {
    for item in `ls $OAR_DOCKER_DIR`; do
        [ -d "$item" -a -f "$item/Dockerfile" ] && \
            DOCKER_IMAGE_DIRS="$DOCKER_IMAGE_DIRS $item"
    done
}

LOGFILE=buildall.log
LOGPATH=$PWD/$LOGFILE
. $OAR_BUILD_DIR/_logging.sh

function sort_build_images {
    # Determine which images to build
    #
    # Input:  list of the requested images (on the command line)
    #
    
    if [ -z "$@" -o "$@" = ":" ]; then
        # no images are mentioned on the command line, build them all
        # 
        out=$DOCKER_IMAGE_DIRS

    else
        # make sure we build them in the right order
        # 
        out=
        for img in $DOCKER_IMAGE_DIRS; do
            (echo $@ | grep -qs ":${img}:") && \
                out="$out $img"
        done
    fi

    echo $out
}

function collect_build_opts {
    # No additional build options needed at the moment
    true
}

function setup_build {
    BUILD_IMAGES=`sort_build_images $do_BUILD_IMAGES`
    BUILD_OPTS=`collect_build_opts`
}

function help {
    helpfile=$OAR_BUILD_DIR/build_help.txt
    [ -f "$OAR_DOCKER_DIR/build_help.txt" ] && \
        helpfile=$OAR_DOCKER_DIR/build_help.txt
    sed -e "s/%PROG%/$prog/g" $helpfile
}

CL4LOG=$@

do_BUILD_IMAGES=":"
while [ "$1" != "" ]; do
    case "$1" in
        --logfile=*)
            LOGPATH=`echo $1 | sed -e 's/[^=]*=//'`
            ;;
        -l)
            shift
            LOGPATH=$1
            ;;
        --quiet|-q)
            QUIET=-q
            ;;
        --help|-h)
            help
            exit 0
            ;;
        -*)
            echo "${prog}: unsupported option:" $1 "(should this be placed after cmd?)"
            false
            ;;
        *)
            do_BUILD_IMAGES="${do_BUILD_IMAGES}${1}:"
            ;;
    esac
    shift
done

(echo $LOGPATH | egrep -qs '^/') || LOGPATH=$PWD/$LOGPATH

# Build from inside the docker dir
# 
cd $OAR_DOCKER_DIR
