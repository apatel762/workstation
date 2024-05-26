ARG FEDORA_VERSION=40

FROM quay.io/fedora-ostree-desktops/silverblue:${FEDORA_VERSION}

ARG FEDORA_VERSION
ARG RPM_FUSION_FREE=https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_VERSION}.noarch.rpm
ARG RPM_FUSION_NONFREE=https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_VERSION}.noarch.rpm

# Add RPM Fusion repos
RUN rpm-ostree install -y ${RPM_FUSION_FREE} ${RPM_FUSION_NONFREE}

# Install a web browser, password manager, a toolbox app, and a better shell
RUN rpm-ostree install -y chromium keepassxc distrobox fish

COPY rootfs/etc /etc
COPY rootfs/usr /usr

RUN ostree container commit
