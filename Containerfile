ARG BASE_IMAGE="ghcr.io/gbraad-devenv/fedora/systemd"
ARG BASE_VERSION=41

FROM ${BASE_IMAGE}:${BASE_VERSION}

USER root

RUN usermod -aG users gbraad \
    && dnf install -y \
        glibc.i686 libstdc++.i686 \
    && dnf clean all \
    && rm -rf /var/cache/yum \
    && mkdir -p /opt/steamcmd \
    && curl -fsSL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
        -o /opt/steamcmd/steamcmd.tar.gz \
    && mkdir -p /var/lib/steamcmd \
    && chgrp users /var/lib/steamcmd \
    && chmod 775 /var/lib/steamcmd

COPY scripts/steamcmd /usr/bin/

# ensure to become root for systemd
#USER root
#ENTRYPOINT ["/sbin/init"]
