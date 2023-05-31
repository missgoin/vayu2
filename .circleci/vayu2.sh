#!/usr/bin/env bash
 # Script For Building Android Kernel

# Bail out if script fails
set -e

##--------------------------------------------------------##

# Basic Information
KERNEL_DIR="$(pwd)"
VERSION=10
MODEL=Xiaomi
DEVICE=vayu
DEFCONFIG=${DEVICE}_defconfig
IMAGE=$(pwd)/out/arch/arm64/boot/Image
DTBO=$(pwd)/out/arch/arm64/boot/dtbo.img
DTB=$(pwd)/out/arch/arm64/boot/dts/qcom
#C_BRANCH=$(git branch --show-current)

##----------------------------------------------------------##
## Export Variables and Info
function exports() {
  export ARCH=arm64
  export SUBARCH=arm64
  #export LOCALVERSION="-${C_BRANCH}"
  export KBUILD_BUILD_HOST=Pancali
  export KBUILD_BUILD_USER="unknown"
  export PROCS=$(nproc --all)
  export DISTRO=$(source /etc/os-release && echo "${NAME}")
  #export LC_ALL=C && export USE_CCACHE=1
  #ccache -M 100G

# Variables
KERVER=$(make kernelversion)
COMMIT_HEAD=$(git log --oneline -1)
DATE=$(TZ=Asia/Jakarta date +"%Y%m%d-%T")
TANGGAL=$(date +"%F%S")

# Compiler and Build Information
TOOLCHAIN=trb # List (clang = zycrom | azure | aosp | nexus15 | proton )
#LINKER=ld # List ( ld.lld | ld.bfd | ld.gold | ld )
VERBOSE=0
ClangMoreStrings=AR=llvm-ar NM=llvm-nm AS=llvm-as STRIP=llvm-strip OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf

FINAL_ZIP=SUPER.KERNEL-${TANGGAL}.zip
FINAL_ZIP_ALIAS=Kernulvay-${TANGGAL}.zip

}

##----------------------------------------------------------##

## Telegram Bot Integration

##----------------------------------------------------------##

## Get Dependencies
function clone() {
# Get Toolchain
if [[ $TOOLCHAIN == "azure" ]]; then
       git clone --depth=1 https://gitlab.com/Panchajanya1999/azure-clang -b main clang
elif [[ $TOOLCHAIN == "nexus14" ]]; then
       git clone --depth=1 https://gitlab.com/Project-Nexus/nexus-clang.git -b nexus-14 clang
elif [[ $TOOLCHAIN == "proton" ]]; then
       git clone --depth=1 https://github.com/kdrag0n/proton-clang -b master clang
elif [[ $TOOLCHAIN == "nexus15" ]]; then
       git clone --depth=1 https://gitlab.com/Project-Nexus/nexus-clang.git -b nexus-15 clang
elif [[ $TOOLCHAIN == "neutron" ]]; then
       bash <(curl -s https://raw.githubusercontent.com/Neutron-Toolchains/antman/main/antman) -S=latest
       sudo apt install libelf-dev libarchive-tools
       bash -c "$(wget -O - https://gist.githubusercontent.com/dakkshesh07/240736992abf0ea6f0ee1d8acb57a400/raw/e97b505653b123b586fc09fda90c4076c8030732/patch-for-old-glibc.sh)"
elif [[ $TOOLCHAIN == "trb" ]]; then
       git clone --depth=1 https://gitlab.com/varunhardgamer/trb_clang.git -b 17 clang
fi

# Get AnyKernel3
git clone --depth=1 https://github.com/missgoin/AnyKernel3.git -b Vayu/Bhima AK3

# Set PATH
PATH="${KERNEL_DIR}/clang/bin:${PATH}"

# Export KBUILD_COMPILER_STRING
export KBUILD_COMPILER_STRING=$(${KERNEL_DIR}/clang/bin/clang --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//')

}

##----------------------------------------------------------------##

function compile() {
START=$(date +"%s")

# Generate .config
make O=out ARCH=arm64 ${DEFCONFIG} LLVM=1 LLVM_IAS=1

# Start Compilation
if [[ "$TOOLCHAIN" == "azure" ]]; then
     make -j$(nproc --all) O=out ARCH=$ARCH CC=clang CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi- LLVM=1 LLVM_IAS=1 AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip CONFIG_NO_ERROR_ON_MISMATCH=y V=$VERBOSE 2>&1 | tee error.log
elif [[ "$TOOLCHAIN" == "proton" ]]; then
     make -j$(nproc --all) O=out ARCH=$ARCH CC=clang CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi- LLVM=1 LLVM_IAS=1 AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip V=$VERBOSE 2>&1 | tee error.log
elif [[ "$TOOLCHAIN" == "nexus" ]]; then
     make -j$(nproc --all) O=out ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabi- LLVM=1 LLVM_IAS=1 V=$VERBOSE 2>&1 | tee error.log
elif [[ "$TOOLCHAIN" == "neutron" ]]; then 
     make -j$(nproc --all) O=out ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi- LLVM=1 LLVM_IAS=1 AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip CONFIG_NO_ERROR_ON_MISMATCH=y V=$VERBOSE 2>&1 | tee error.log
elif [[ "$TOOLCHAIN" == "trb" ]]; then
     make -j$(nproc --all) O=out ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi- LLVM=1 LLVM_IAS=1 $ClangMoreStrings V=$VERBOSE 2>&1 | tee error.log
fi
	
}

##----------------------------------------------------------------##

function zipping() {
# Copy Files To AnyKernel3 Zip
cp $IMAGE AK3
cp $DTBO AK3
cp $DTBO AK3/dtb

# Zipping and Upload Kernel
cd AK3 || exit 1
zip -r9 ${FINAL_ZIP_ALIAS} *
MD5CHECK=$(md5sum "$FINAL_ZIP_ALIAS" | cut -d' ' -f1)
echo "Zip: $FINAL_ZIP_ALIAS"
curl -T $FINAL_ZIP_ALIAS https://oshi.at; echo

cd ..

}

##----------------------------------------------------------##

# Functions
exports
clone
compile
zipping

##------------------------*****-----------------------------##
