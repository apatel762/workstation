FROM quay.io/fedora-ostree-desktops/silverblue:39

COPY rootfs/etc /etc
COPY rootfs/usr /usr

# Install a web browser, password manager, and a toolbox app
RUN rpm-ostree install -y chromium keepass-xc distrobox

RUN ostree container commit
