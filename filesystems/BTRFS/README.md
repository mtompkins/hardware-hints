![emblem](https://img.shields.io/badge/project-passive-lightgrey.svg) ![emblem](https://img.shields.io/badge/kernel-4.5.4-brightgreen.svg) ![emblem](https://img.shields.io/badge/btrfs--progs-4.5.3-brightgreen.svg)

# Maintenance utilities and scripts for the BTRFS file system

>BTRFS is **under heavy development** and as such users of the filesystem are urged (read: required) to stay as close to the most recent kernel 
release as possible. I advocate for this approach and target `stable`. The utilities and scripts provided below are on my systems.
Shields at the top of this README indicate what kernel I am on and the script's status based on my experience.
>
> If you want to update your kernel, these [scripts](https://github.com/mtompkins/linux-kernel-utilities) may be useful.

- `btrfs_scrub.sh` A script to automate `btrfs` user-space `scrub` maintenance. 
    - Works well with `systemd` timers for automating monthly scrubs.
    - The script makes use of [shlock](http://linux.die.net/man/1/shlock). If your distro does not have it,
it is part of the Linux `inn` package.
    - The script will email (using `mail`) the user account that runs the script (ordinarily root)
    after execution. This should help monitor for CSUM errors as a precursor to drive failure.
- `btrfs-scrub.service` Systemd service file for automating `btrfs` monthly scrubs.
    - You may need to update the path to `btrfs_scrub.sh`
- `btrfs-scrub-timer` Systemd timer file to trigger `btrfs-scrub.service`