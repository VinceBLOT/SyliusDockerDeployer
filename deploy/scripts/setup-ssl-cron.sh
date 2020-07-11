#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE%/*}" )" >/dev/null 2>&1 && pwd )/deploy/scripts"
. "$DIR/functions.sh"

echo "Set ssl cert renewal request to crontab"
(crontab -l ; echo "@weekly cd ${STACK_PATH} && make -f Makefile.prod renew-ssl") 2> /dev/null | sort - | uniq - | crontab -

exit 0
