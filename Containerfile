ARG FEDORA_VERSION=41

FROM quay.io/fedora-ostree-desktops/silverblue:${FEDORA_VERSION}

ARG FEDORA_VERSION
ARG RPM_FUSION_FREE=https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_VERSION}.noarch.rpm
ARG RPM_FUSION_NONFREE=https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDORA_VERSION}.noarch.rpm

RUN rpm-ostree install -y \
  ${RPM_FUSION_FREE} \
  ${RPM_FUSION_NONFREE}

ADD --checksum=sha256:9d66079a772f2edb9f3a900ff66d09f22e55922a492c98a237966a4a32284227 \
  https://repository.mullvad.net/rpm/stable/mullvad.repo /etc/yum.repos.d/mullvad.repo

RUN rpm-ostree install -y \
  chromium \
  keepassxc \
  openssl \
  wireguard-tools \
  yubikey-manager \
  pam-u2f \
  pamu2fcfg \
  gnome-shell-extension-blur-my-shell \
  gnome-shell-extension-appindicator \
  mullvad-vpn

COPY rootfs/etc /etc
COPY rootfs/usr /usr

RUN ostree container commit
