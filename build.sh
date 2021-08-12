apt install git aria2 rsync curl sudo wget zstd -y


echo "Download the source code"

wget -O - "https://github.com/Mikubill/transfer/releases/download/v0.4.11/transfer_0.4.11_linux_amd64.tar.gz" | tar -x --gzip -C /usr/bin/
transfer https://we.tl/t-rR6yeDNa4Y?src=dnl
tar axf orangfox.tar.zst

echo "Setting Up the Compile Environment "

git clone https://gitlab.com/OrangeFox/misc/scripts
bash scripts/setup/android_build_env.sh
bash scripts/setup/install_android_sdk.sh

echo "Start compiling "

cd fox_10.0
git clone https://github.com/lateautumn233/android_device_xiaomi_lmi-ofrp device/xiaomi/apollo
mkdir vendor/recovery/security/
wget https://gitlab.com/OrangeFox/vendor/recovery/-/raw/master/security/miui.x509.pem?inline=false -o vendor/recovery/security/miui.x509.pem
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL="C"
lunch omni_apollo-eng && mka recoveryimage
transfer wet /drone/src/fox_10.0/out/target/product/apollo/*.zip