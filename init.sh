WORK_DIR=$PWD

OPENSIL_PKG_DIR=AmdOpenSilPkg
OPENSIL_INTERFACE_DIR=opensil-uefi-interface
OPENSIL_DIR=OpenSIL
AGESA_DIR=AGCL-R
AMD_PLATFORM_DIR=Platform
AMD_FW_DIR=amd_firmwares
EDK2_DIR=edk2
EDK2_PLATFORMS_DIR=edk2-platforms
CRB_PKG_DIR=CrbSupportPkg

REPO_URL=git@github.com:MiTAC-Computing-Technology
GENOA_BRANCH=genoa_poc
EDK2_BRANCH=edk2-stable202205
EDK2_PLATFORMS_TAG=b8ffb76b471dae5e24badcd9e04033e8c9439ce3

echo "=== Setup Start ==="
mkdir -p $WORK_DIR/$OPENSIL_PKG_DIR
cd $WORK_DIR/$OPENSIL_PKG_DIR

#
# Clone Source Code
#
echo "Clone OpenSIL"
git clone $REPO_URL/opensil-uefi-interface.git -b $GENOA_BRANCH $OPENSIL_INTERFACE_DIR
cd $OPENSIL_INTERFACE_DIR
git clone $REPO_URL/AMD-openSIL.git -b $GENOA_BRANCH $OPENSIL_DIR

cd $WORK_DIR
echo "Clone AgesaModule"
git clone $REPO_URL/AGCL-R.git -b $GENOA_BRANCH $AGESA_DIR

echo "Clone AMD platforms"
git clone $REPO_URL/EDKII-Platform-AMD.git -b $GENOA_BRANCH $AMD_PLATFORM_DIR

echo "Clone AMD PSP"
git clone $REPO_URL/amd_firmwares.git -b $GENOA_BRANCH $AMD_FW_DIR

echo "Clone EDK2"
git clone https://github.com/tianocore/edk2 $EDK2_DIR
cd $EDK2_DIR
git checkout $EDK2_BRANCH
git submodule update --init --recursive

cd $WORK_DIR
echo "Clone EDK2 Platforms"
git clone https://github.com/tianocore/edk2-platforms $EDK2_PLATFORMS_DIR
cd $EDK2_PLATFORMS_DIR
git checkout $EDK2_PLATFORMS_TAG
git submodule update --init --recursive

#
# Apply Patches
#
echo "Patch OpenSIL Interface"
cd $WORK_DIR/$OPENSIL_PKG_DIR/$OPENSIL_INTERFACE_DIR
git am $WORK_DIR/Patches/$OPENSIL_INTERFACE_DIR/*.patch --whitespace=fix

echo "Patch OpenSIL"
cd $WORK_DIR/$OPENSIL_PKG_DIR/$OPENSIL_INTERFACE_DIR/$OPENSIL_DIR
git am $WORK_DIR/Patches/$OPENSIL_DIR/*.patch --whitespace=fix

echo "Patch AgesaModule"
cd $WORK_DIR/$AGESA_DIR
git am $WORK_DIR/Patches/$AGESA_DIR/*.patch --whitespace=fix

echo "Patch AMD platforms"
cd $WORK_DIR/$AMD_PLATFORM_DIR
git am $WORK_DIR/Patches/$AMD_PLATFORM_DIR/*.patch --whitespace=fix

echo "Patch AMD PSP"
cd $WORK_DIR/$AMD_FW_DIR
git am $WORK_DIR/Patches/$AMD_FW_DIR/*.patch --whitespace=fix

echo "Patch EDK2 Platforms"
cd $WORK_DIR/$EDK2_PLATFORMS_DIR
git am $WORK_DIR/Patches/$EDK2_PLATFORMS_DIR/*.patch --whitespace=fix

echo "Copy Aspeed Driver"
cd $WORK_DIR
cp -r $WORK_DIR/Patches/$CRB_PKG_DIR .

#
# Link Build Script
#
cd $WORK_DIR
ln -s Platform/PlatformTools/root_dbuild.sh dbuild.sh
chmod 755 dbuild.sh

echo "=== Setup Finished ==="