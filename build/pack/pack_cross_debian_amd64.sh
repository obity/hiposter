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
wails build -clean  -platform linux/amd64

cd build/pack/
echo $PWD
TempDir="debian"
AppName="hiposter"
Version=$1
Machine="amd64"
rm -rf $TempDir
mkdir $TempDir
cp -r ../debian/amd64/* ./${TempDir} 
mkdir -p ${TempDir}/usr/bin
cp ../bin/${AppName} ${TempDir}/usr/bin 
dpkg -b ${TempDir} ${AppName}_linux_${Machine}_${Version}.deb && \
	echo "created: $PWD/${AppName}_linux_${Machine}_${Version}.deb"
md5sum ${AppName}_linux_${Machine}_${Version}.deb > ${AppName}_linux_${Machine}_${Version}.deb.md5
fi
