!/usr/bin/env bash

find . ! -name 'nixbackup.sh' -type f -exec rm -f {} +
find . ! -name 'nixbackup.sh' -type d -exec rm -r {} +
