ARG FEDORA_VERSION=41

FROM quay.io/fedora-ostree-desktops/silverblue:${FEDORA_VERSION}

ARG FEDORA_VERSION
ARG RPM_FUSION_FREE=https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_VERSION}.noarch.rpm
ARG RPM_FUSION_NONFREE=https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDORA_VERSION}.noarch.rpm

RUN rpm-ostree install -y \
  ${RPM_FUSION_FREE} \
  ${RPM_FUSION_NONFREE}

RUN rpm-ostree install -y \
  chromium \
  keepassxc \
  openssl \
  wireguard-tools \
  yubikey-manager \
  pam-u2f \
  pamu2fcfg \
  gnome-shell-extension-blur-my-shell \
  gnome-shell-extension-appindicator

COPY rootfs/etc /etc
COPY rootfs/usr /usr

RUN ostree container commit
