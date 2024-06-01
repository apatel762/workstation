ARG FEDORA_VERSION=40

FROM quay.io/fedora-ostree-desktops/silverblue:${FEDORA_VERSION}

COPY rootfs/etc /etc
COPY rootfs/usr /usr

ARG FEDORA_VERSION
ARG RPM_FUSION_FREE=https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_VERSION}.noarch.rpm
ARG RPM_FUSION_NONFREE=https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_VERSION}.noarch.rpm

RUN rpm-ostree install -y \
  ${RPM_FUSION_FREE} \
  ${RPM_FUSION_NONFREE}

RUN rpm-ostree install -y \
  chromium \
  keepassxc \
  openssl \
  mullvad-vpn

RUN ostree container commit
