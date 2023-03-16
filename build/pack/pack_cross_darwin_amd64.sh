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
wails build -clean -platform darwin/amd64

cd build/pack/
TempDir="macos"
AppName="hiposter"
Version=$1
Machine="amd64"
OutFile=${AppName}_macos_${Machine}_${Version}.dmg
rm -rf $TempDir
mkdir $TempDir
cp -r ../bin/${AppName}.app ./${TempDir} 
ln -sf /Applications macos/Applications
hdiutil create ./$OutFile -volname "$AppName" -fs HFS+ -srcfolder $TempDir -ov -format UDZO 
md5 $OutFile> $OutFile.md5
fi
