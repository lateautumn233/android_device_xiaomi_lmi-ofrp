# android_device_xiaomi_apollo
For building OFRP for Redmi k30S Ultra

OFRP device tree for Redmi k30S Ultra

Kernel and all blobs are extracted from [miui_APOLLO_V12.5.3.0.RJDCNXM_d98b4e09b5_11.0.zip](https://bigota.d.miui.com/V12.5.3.0.RJDCNXM/miui_APOLLO_V12.5.3.0.RJDCNXM_d98b4e09b5_11.0.zip) firmware.

Redmi k30S Ultra (codenamed _"apollo"_) is high-end smartphones from Redmi.

Redmi k30S Ultra was announced and released in February 2020.

## Device specifications

| Device       | Redmi k30S Ultra                       |
| -----------: | :------------------------------------------ |
| SoC          | Qualcomm SM8250 Snapdragon 865              |
| CPU          | 8x Qualcomm® Kryo™ 585 up to 2.84GHz        |
| GPU          | Adreno 630                                  |
| Memory       | 8GB / 12GB RAM (LPDDR5)                     |
| Shipped Android version | 10                               |
| Storage      | 128GB / 256GB UFS 3.1 flash storage |
| Battery      | Non-removable Li-Po 5000mAh                 |
| Dimensions   | 163.3 x 75.4 x 8.9 mm                          |
| Display      | 6.67 inches, 107.4 cm2 (~85.2% screen-to-body ratio)  |

## Device picture

![Redmi k30S Ultra](pictures/apollo.png)

## Features

**Works**

- Booting.
- [Decryption](https://github.com/simonsmh/android_bootable_recovery/commits/android-10.0).
- ADB
- MTP
- Super partition functions
- Vibration
- OTG


Redmi k30S Ultra is using Dynamic Partition! We need update from TWRP.

## Compile

Prepare the build environment

```
sudo apt update && sudo apt install git-core gnupg flex bison gperf zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache 
libgl1-mesa-dev libxml2-utils xsltproc unzip openjdk-8-jdk build-essential git repo fastboot adb
sudo apt install git aria2 -y
git clone https://gitlab.com/OrangeFox/misc/scripts
cd scripts
sudo bash setup/android_build_env.sh
sudo bash setup/install_android_sdk.sh
```

Configure ccache
```
# Enable ccache
export USE_CCACHE=1
# Change the ccache cache path
export CCACHE_DIR=~/.ccache
# Take effect
source ~/bashrc
# Configure ccache size
ccache -M 50G
```

First checkout minimal ofrp with omnirom tree:

```
mkdir ~/OrangeFox_10
cd ~/OrangeFox_10
rsync rsync://sources.orangefox.download/sources/fox_10.0 . --progress -a
```

Then add these projects to .repo/manifest.xml:

```xml
<project path="device/xiaomi/apollo" name="KyuoFoxHuyu/android_device_xiaomi_apollo-ofrp" remote="github" revision="R11.0" />
```

Finally execute these:

```
. build/envsetup.sh
lunch omni_apollo-eng
mka recoveryimage ALLOW_MISSING_DEPENDENCIES=true # Only if you use minimal twrp tree.
```

To test it:

```
fastboot boot out/target/product/apollo/recovery.img
```

## Thanks
- [FsCrypt fix by mauronofrio](https://github.com/mauronofrio/android_bootable_recovery)
- [Decryption by bigbiff](https://github.com/bigbiff/android_bootable_recovery)
- [Oneplus 8 TWRP by mauronofrio](https://github.com/mauronofrio/android_device_oneplus_instantnoodle_TWRP)
