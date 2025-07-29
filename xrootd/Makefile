all::

## Provide a version of $(abspath) that can cope with spaces in the
## current directory.
myblank:=
myspace:=$(myblank) $(myblank)
MYCURDIR:=$(subst $(myspace),\$(myspace),$(CURDIR)/)
MYABSPATH=$(foreach f,$1,$(if $(patsubst /%,,$f),$(MYCURDIR)$f,$f))

-include $(call MYABSPATH,config.mk)

CMP ?= cmp
CP ?= cp

OS=rockylinux/rockylinux:8
SITE=https://github.com/
ORG=xrootd
PROJ=xrootd
BRANCH=master
XROOTD_GID=110000
XROOTD_UID=110000

BRANCH=master

REPO=$(SITE)$(ORG)/$(PROJ).git

VWORDS:=$(shell ../git-info.sh '$(REPO)' '$(ORG)' '$(BRANCH)')
TAG:=$(word 1,$(VWORDS))
COMMIT:=$(word 2,$(VWORDS))

IMAGE=$(PROJ)$(TAG)

all::
	docker build \
	  --build-arg OS="$(OS)" \
	  --build-arg BRANCH="$(BRANCH)" \
	  --build-arg COMMIT="$(COMMIT)" \
	  --build-arg REPO="$(REPO)" \
	  -t "$(IMAGE)" .
