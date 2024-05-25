# bootstrap1

[Back](./README.md)

Assumption: you have booted into a fresh installation of this custom workstation image.

## `systemd` integration

Run the command:

```bash
bootstrap1
```

to set up `systemd` integration with our custom units.

**You may want to double check the device UUID in [var-mnt-ssd1.mount](./rootfs/usr/etc/systemd/system/var-mnt-ssd1.mount)**

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

Enter the [workspace](https://github.com/apatel762/workspace).

```bash
distrobox create --pull --image ghcr.io/apatel762/workspace workspace
distrobox enter workspace
```

The `chezmoi` app should be installed and ready to use. But first, in the KeePassXC GUI, find the SSH key entry and add it to the agent. (As of writing this, you just select the entry and hit `Ctrl+H`).

```bash
chezmoi init git@github.com:apatel762/dotfiles.git
```

TODO: next step is to set up GPG key. I think I finally need to confront the fact that I need to move files from my laptop to my new workstation.

copied over files following this: https://askubuntu.com/questions/545655/backup-your-home-directory-with-rsync-and-skip-useless-folders/545676#545676 need to document it