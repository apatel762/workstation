FROM quay.io/fedora-ostree-desktops/silverblue:39

COPY rootfs/etc /etc

RUN ostree container commit
