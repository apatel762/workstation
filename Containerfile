FROM quay.io/fedora-ostree-desktops/silverblue:39

COPY rootfs/etc /etc
COPY rootfs/usr /usr

RUN ostree container commit
