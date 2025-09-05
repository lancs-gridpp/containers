ARG OS=rockylinux/rockylinux:8
ARG REMOTE=origin
ARG REPO=https://github.com/lancs-gridpp/udptun.git

FROM $OS AS build
ARG REMOTE
ARG REPO
ARG BRANCH
ARG COMMIT

RUN dnf update -y
RUN dnf install -y git epel-release gcc-c++ make findutils diffutils zlib-devel
RUN dnf install -y yaml-cpp-devel
RUN git clone --no-checkout \
    https://github.com/simpsonst/binodeps.git /tmp/binodeps
RUN git clone --no-checkout "${REPO}" /tmp/udptun
COPY config.mk /tmp/udptun/config.mk

RUN dnf update -y
LABEL git.commit=${COMMIT}
RUN dnf update -y

RUN git -C /tmp/binodeps fetch origin
RUN git -C /tmp/binodeps checkout master
RUN git -C /tmp/udptun fetch "${REMOTE}"
RUN git -C /tmp/udptun checkout "${COMMIT}"
RUN make -C /tmp/binodeps all install
RUN make PREFIX=/usr -C /tmp/udptun all install

FROM scratch
COPY --from=build /usr/bin/udptun /bin/udptun
