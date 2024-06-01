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

# magic incantations to make Mullvad's package install work
# https://github.com/mullvad/mullvadvpn-app/issues/1570#issuecomment-602255731
RUN mkdir -p /var/opt
RUN ln -s '/usr/lib/opt/Mullvad VPN' '/var/opt/Mullvad VPN'

RUN rpm-ostree install -y \
  chromium \
  keepassxc \
  openssl \
  mullvad-vpn

RUN ostree container commit
