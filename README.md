# workstation

The operating system image for my workstation.

## Backup

*Assumption: brand new machine just arrived, and you want to move to it.*

If you haven't done so already, you need to take a backup of your machine. Open the 'Files' window and open an external hard drives. Open another 'Files' window and open your Home directory.

Then, just copy folders over one by one until you've moved everything of value.

## Fresh installation

*Assumption: brand new machine is plugged in and ready to go.*

Install Fedora Silverblue:

- Download Flatpak
- Download Fedora Media Writer
- Flash Fedora Silverblue onto a flash drive
- Boot from the flash drive (Press F10 or similar during startup)
- Go through the installation wizard

**Important**: ensure that your username is `apatel`. There are a few things in the [dotfiles](https://github.com/apatel762/dotfiles) that depend on this (e.g. user profile picture).

Then follow the instructions in the [INSTALLATION](INSTALLATION.md) page to rebase onto this custom image.

## Rebase onto this image

*Assumption: brand new machine has got Fedora Silverblue installed onto it.*

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

Assumption: you have booted into a fresh installation of this custom workstation image.

## `systemd` integration

Run the command:

```bash
bootstrap1
```

to set up `systemd` integration with our custom units.

**You may want to double check the device UUID in [var-mnt-ssd1.mount](../rootfs/usr/etc/systemd/system/var-mnt-ssd1.mount)**

## Password manager

Copy the KeePass database from another device to this device using an external hard drive (recommended). If in a pinch, send it to yourself on WhatsApp and download it via WhatsApp Web.

Set stricter permissions on the files as well:

```bash
chmod u=r,go-rwx Key
chmod u=rw,go-rwx Passwords.kbdx
```

(Permissions settings are likely not necessary but might as well do them...)

You must have the password manager on your machine in order to install the dotfiles. This is because some of the dotfiles are templated, and we need to lookup secrets at runtime.

## Dotfiles

*Assumption: you want to enter a fresh workspace container.*

Delete the existing copy if exists:

```bash
distrobox rm --force workspace
```

Enter the [workspace](https://github.com/apatel762/workspace).

```bash
distrobox create --pull --image ghcr.io/apatel762/workspace workspace
distrobox enter workspace
```

The `chezmoi` app should be installed and ready to use. But first, in the KeePassXC GUI, find the SSH key entry and add it to the agent. (As of writing this, you just select the entry and hit `Ctrl+H`).

```bash
chezmoi init git@github.com:apatel762/dotfiles.git
```

## Setup GPG key

*Assumption: you have got access to the workstation backup.*

Copy the entire `~/.local/share/gnupg/` directory from the backup onto your machine.

Test that the key is available using:

```bash
gpg --list-secret-keys
```

You should see the key.
