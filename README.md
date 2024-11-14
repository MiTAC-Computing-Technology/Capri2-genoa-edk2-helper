# Capri2-edk2-helper

This is source code setup repository for MiTAC Capri2 of Genoa/OpenSIL/EDK2.


## Clone Repositories

1. Execute init.sh to clone source codes and apply patches
2. The repositories and folder structure will be:
  - AGCL-R (Branch: genoa_poc)
  - amd_firmwares (Branch: genoa_poc)
  - AmdOpenSilPkg
    - opensil-uefi-interface (Branch: genoa_poc)
      - OpenSIL (Branch: genoa_poc)
  - edk2 (Branch: edk2-stable202205)
  - edk2-platforms (Tag: b8ffb76b471dae5e24badcd9e04033e8c9439ce3)
  - Patches
  - Platform (Branch: genoa_poc)


## Build and Deploy

1. Execute ./dbuild.sh capri2 --edk2args="-b DEBUG" to build debug rom
2. Deploy Rc200000000N.FD to 32MB SPI flash of Capri2


## Progress

- With these repositories, Capri2 + Genoa can boot to EDK2 Shell successfully
- Debug messages are available through FCH MMIO
- Only verify in Linux build environment


## Reference

- All OpenSIL related repositories are forked from https://github.com/openSIL
- Aspeed Driver version is 1.13.05 from Aspeed website (BmcGopDxe)