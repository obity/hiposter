#!/usr/bin/env bash
help()
{
 echo "Help:"
 echo "pack_xxxx.sh v0.0.x -- must have version!"
}
if [ "$1" = "" ]
then
 help
else
cd ../../
echo "cd $PWD"
wails build -clean

cd build/pack/
echo $PWD
TempDir="debian"
AppName="hiposter"
Version=$1
Machine=$(uname -r|cut -d '-' -f3)
OutFile=${AppName}_linux_${Machine}_${Version}.deb
rm -rf $TempDir
mkdir $TempDir
cp -r ../debian/arm64/* ./${TempDir} 
mkdir -p ${TempDir}/usr/bin
cp ../bin/${AppName} ${TempDir}/usr/bin 
dpkg -b ${TempDir} $OutFile && \
	echo "created: $PWD/$OutFile"
md5sum $OutFile > $OutFile.md5
fi
