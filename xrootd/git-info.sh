#!/bin/bash
# -*- sh-basic-offset: 2; indent-tabs-mode: nil -*-

REPO="$1" ; shift
ORG="$1" ; shift
BRANCH="$1" ; shift

while read COMMIT REF ; do
  if [ "$REF" = "refs/heads/$BRANCH" ] ; then
    echo ":${ORG}_${BRANCH}-${COMMIT:0:8}" "$COMMIT"
    break
  elif [ "$REF" = "refs/tags/$BRANCH" ] ; then
    echo ":${ORG}_${BRANCH}" "$COMMIT"
    break
  fi
done < <(git ls-remote "$REPO")
