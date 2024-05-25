# Installation

[README](../README.md)

[Back](./BOOTSTRAP0.md)

Assumption: you are starting from a vanilla Fedora Silverblue (or similar) installation.

1. Remove layered packages

```bash
rpm-ostree reset
```

2. Reboot, and pin the deployment

```bash
sudo ostree admin pin 0
```

3. Populate `/etc/containers/policy.json` from [here](../rootfs/etc/containers/policy.json)
4. Populate `/etc/pki/containers/workstation.pub` from [here](../rootfs/etc/pki/containers/workstation.pub)
5. Populate `/etc/containers/registries.d/ghcr.io.yaml` from [here](../rootfs/etc/containers/registries.d/ghcr.io.yaml)
6. Rebase!

```bash
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/apatel762/workstation:latest
```

7. If all is well, you can un-pin your original deployment

```bash
# double-check the index using `rpm-ostree status -v`
sudo ostree admin pin --unpin 1
```