ARG OS=rockylinux/rockylinux:8
ARG REMOTE=origin
ARG REPO=https://github.com/xrootd/xrootd.git
ARG XROOTD_GID=110000
ARG XROOTD_UID=110000


FROM $OS AS base
ARG REMOTE
ARG REPO
ARG XROOTD_GID
ARG XROOTD_UID
ARG COMMIT

RUN dnf update -y && \
    dnf install -y epel-release && \
    dnf --enablerepo=powertools install -y \
    diffutils \
    python3-setuptools \
    file \
    python3 \
    readline \
    libbsd \
    tinyxml \
    voms \
    scitokens-cpp \
    python3-libs \
    libmacaroons \
    json-c \
    fuse-libs \
    zlib \
    systemd-libs \
    openssl-libs \
    isa-l \
    libxml2 \
    libuuid \
    krb5-libs \
    davix-libs

COPY ./run.sh /
RUN groupadd --gid "${XROOTD_GID}" xrootd
RUN useradd --base-dir /var/spool --create-home --shell /bin/bash \
    --uid "${XROOTD_UID}" --gid xrootd --no-user-group xrootd

## Create a stage for building from source.
FROM base AS build
ARG COMMIT
ARG REPO
ARG REMOTE

ARG BUILD_DEPS="git gcc-c++ make cmake yasm libtool krb5-devel libuuid-devel libxml2-devel openssl-devel systemd-devel zlib-devel libcurl-devel fuse-devel json-c-devel readline-devel isa-l-devel libbsd-devel tinyxml-devel voms-devel scitokens-cpp-devel python3-devel libmacaroons-devel davix-devel cppunit-devel gtest-devel libcurl-devel"

## These are required for building, and can be removed later.
RUN dnf --enablerepo=powertools install -y $BUILD_DEPS

RUN git clone --no-checkout "${REPO}" /tmp/xrootd/src
LABEL git.commit=${COMMIT}
RUN git -C /tmp/xrootd/src fetch "${REMOTE}"
RUN git -C /tmp/xrootd/src checkout "${COMMIT}"

RUN cmake -S /tmp/xrootd/src -B /tmp/xrootd/build \
    -Wno-dev \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DENABLE_TESTS=TRUE \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_CXX_FLAGS="-D_GLIBCXX_ASSERTIONS" && \
    cmake --build /tmp/xrootd/build && \
    cmake --install /tmp/xrootd/build
RUN rm -rf /tmp/xrootd && \
    dnf remove -y $BUILD_DEPS


## Create a final stage using the generated files
FROM base
COPY --from=build / /

USER xrootd
WORKDIR /var/spool/xrootd
ENTRYPOINT [ "/run.sh" ]
