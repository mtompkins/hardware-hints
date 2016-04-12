# Filesystems #
Filesystem maintenance utilities and scripts

## Descriptions ##
- `btrfs_scrub.sh` A script to automate `btrfs` user-space `scrub` maintenance. Works well with `systemd` timers for automating monthly maintenance.

Note: The script makes use of [shlock](http://linux.die.net/man/1/shlock). If your distro does not have it, it is part of the Linux `inn` package.
