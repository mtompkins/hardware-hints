# Hardware Hints
A collection of handy information for various relevant hardware components.

## Sections ##
- [Conky](https://github.com/mtompkins/hardware-hints/tree/master/conky) Conky monitoring artifacts
- [Conky](./conky) Conky monitoring artifacts
- [Filesystems](https://github.com/mtompkins/hardware-hints/tree/master/filesystems) Filesystem maintenance utilities and scripts
- [Interfaces](https://github.com/mtompkins/hardware-hints/tree/master/interfaces) Network interface controllers and configurations
- [Wireless Info](https://github.com/UbuntuForums/wireless-info/tree/4faf33e831ac9de1d25fb2736e4d81bf0546b35f) Script to provide wifi diagnostics and information
- [Voip Info](https://gist.github.com/mtompkins/3636b1d403f982d4d67c114d48584dea) Trivial script to check **Packet** `Latency`, `Jitter` and `Loss`

## Setup ##
This repository uses submodules
```
git clone --recursive https://github.com/mtompkins/hardware-hints.git
```

## Update ##
The submodules require an extra step
```
git pull
git submodule update --remote --merge
```
