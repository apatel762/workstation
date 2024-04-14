# workstation

The operating system image for my workstation.

## bootstrap0

Assumption: brand new machine.

Install Fedora Silverblue:

- Download Flatpak
- Download Fedora Media Writer
- Flash Fedora Silverblue onto a flash drive
- Boot from the flash drive (Press F10 or similar during startup)
- Go through the installation wizard

**Important**: ensure that your username is `apatel`. There are a few things in this workstation image that depend on this (e.g. user profile picture).

Then follow the instructions in the [INSTALLATION](INSTALLATION.md) page to rebase onto this custom image.

## bootstrap1

Assumption: you have booted into a fresh installation of this custom workstation image.

### Password manager

Copy the KeePass database from another device to this device using an external hard drive (recommended). If in a pinch, send it to yourself on WhatsApp and download it via WhatsApp Web.

Set stricter permissions on the files as well:

```bash
chmod u=r,go-rwx Key
chmod u=rw,go-rwx Passwords.kbdx
```

(Permissions settings are likely not necessary but might as well do them...)

You must have the password manager on your machine in order to install the dotfiles. This is because the dotfiles need to lookup secrets.

### Dotfiles

**TODO** need to verify these steps:

Get `chezmoi`:

```
cd "$(mktemp -d)"
sh -c "$(curl -fsLS get.chezmoi.io)"
```

The binary will be downloaded to `./bin/chezmoi` (relative to your current directory). This is nice because you can delete it when you're done installing the dotfiles.
