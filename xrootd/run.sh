#!/bin/bash
# -*- sh-basic-offset: 2; indent-tabs-mode: nil -*-

prog="$1" ; shift
inst="$1" ; shift

case "$prog" in
  (xrootd|cmsd)
    ;;

  (*)
    printf >&2 'Only xrootd and cmsd are allowed.\n'
    exit 1
    ;;
esac

CMD=("/usr/bin/$prog" \
       -l "/var/log/xrootd/${prog}.log" \
       -c "/etc/xrootd/xrootd-${inst}.cfg" \
       -k fifo \
       -s "/run/xrootd/cmsd-${inst}.pid" \
       -n "$inst" \
       "$@")

id
pwd
echo >&2 "${CMD[@]}"
exec "${CMD[@]}"
