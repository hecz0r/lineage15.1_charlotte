#build lineage 15.1 charlotte

mkdir -p ~/bin
wget 'https://storage.googleapis.com/git-repo-downloads/repo' -P ~/bin
chmod +x ~/bin/repo
sudo apt-get update
sudo apt-get remove openjdk-* icedtea-*
sudo apt-get install git ccache lzop bison gperf build-essential zip curl zlib1g-dev g++-multilib python-networkx libxml2-utils bzip2 libbz2-dev libghc-bzlib-dev squashfs-tools pngcrush liblz4-tool optipng libc6-dev-i386 gcc-multilib libssl-dev gnupg flex lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev xsltproc unzip python-pip python-dev libffi-dev libxml2-dev libxslt1-dev libjpeg8-dev openjdk-8-jdk
sudo apt-get install openjdk-8-jdk android-tools-adb bc bison build-essential curl flex g++-multilib gcc-multilib gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev libesd0-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc yasm zip zlib1g-dev ccache
bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev

echo 'export PATH="$HOME/bin:$PATH"' >> ~/.profile
echo 'export USE_CCACHE=1' >> ~/.profile
echo 'export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx6G"' >> ~/.profile
ccache -M 50G
source ~/.profile

mkdir -p ~/android/lineage
cd ~/android/lineage
repo init -u https://github.com/LineageOS/android.git -b lineage-15.1

cat <<EOF > .repo/local_manifests/roomservice22.xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <project name="berkeley-dev/android_patcher" path="patcher" remote="github" />
  <project name="berkeley-dev/android_device_huawei_kirin970-common" path="device/huawei/kirin970-common" remote="github" />
  <project name="berkeley-dev/android_device_huawei_berkeley" path="device/huawei/berkeley" remote="github" />
  <project name="berkeley-dev/android_device_huawei_charlotte" path="device/huawei/charlotte" remote="github" />
  <project name="berkeley-dev/proprietary_vendor_huawei_kirin970-common" path="vendor/huawei/kirin970-common" remote="github" />
</manifest>
EOF

repo sync -j24 -c -f --force-sync --no-clone-bundle --no-tags

. build/envsetup.sh

repopick 217311 217312 207583 218437 218438 217313 217314
repopick 214316 -f 

./patcher/patch.sh

croot
brunch charlotte
cd $OUT

git remote add aosp https://android.googlesource.com/platform/build/kati
git fetch aosp && git merge android-8.1.0_r63
code /.x/
git add .
git commit -m "message"

#updated: 
/art 
/bionic
/bootable/recovery
/build/kati
/build/soong
/build/blueprint
/compatibility/cdd
/cts
/dalvik
/developers/build
/development
/frameworks/av
/frameworks/base
/frameworks/data-binding
/frameworks/ex
/packages/apps/Settings
dracu stie care sunt alea bune ma 
https://www.google.ro/search?q=refs/tags/android-8.1.0_r63

art/: discarding 10 commits
bionic/: discarding 8 commits
bootable/recovery/: discarding 5 commits
build/soong/: discarding 3 commits
compatibility/cdd/: discarding 1 commits
cts/: discarding 2 commits
dalvik/: discarding 3 commits
developers/build/: discarding 1 commits
development/: discarding 7 commits
frameworks/av/: discarding 45 commits
frameworks/base/: discarding 3 commits
frameworks/data-binding/: discarding 1 commits
frameworks/ex/: discarding 4 commits
frameworks/native/: discarding 1 commits
frameworks/opt/telephony/: discarding 2 commits
packages/apps/Camera2/: discarding 1 commits
packages/apps/Settings/: discarding 18 commits
packages/services/Telephony/: discarding 2 commits
system/core/: discarding 2 commits
