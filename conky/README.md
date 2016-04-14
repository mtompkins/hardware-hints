# Conky #
Conky monitoring artifacts

## Descriptions ##
- `colorize.sh` A script to generate hex color codes for gradient colorization from GREEN to RED based on supplied `MIN` `MAX` and `sample` parametric values.
- `btrfsStatus.sh` A script to return the status of any active btrfs maintenance activities

>**Note:** Conky is executed within the user space, however the `btrfsStatus.sh` script needs `sudo` permissions to operate correctly. To allow this with the least amount of security compromise, edit the `/etc/sudoers` file adding a **Command Alias** allowing your user permission to execute the script.
>
>For example:
> ```
> ...
>
> # Command Alias specification
> Cmnd_Alias BTRFS_CONKY = /your/path/to/btrfsStatus.sh
>
> # Enable Command Alias for specific user
>userName       ALL=NOPASSWD:   BTRFS_CONKY
>
>...
> ```
