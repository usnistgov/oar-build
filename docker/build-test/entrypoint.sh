#! /bin/bash
#
[ "$1" = "" ] && exec /bin/bash
set -e

case "$1" in
    build)
        scripts/makedist
        ;;
    test)
        scripts/makedist
        scripts/testall
        ;;
    bshell)
        scripts/makedist
        exec /bin/bash
        ;;
    shell)
        exec /bin/bash
        ;;
    *)
        echo Unknown command: $1
        echo Available commands:  build test bshell shell
        exit 100
        ;;
esac

EXCODE=$?

# This script must exit with a non-zero value if the build or testing fails
exit $EXCODE
