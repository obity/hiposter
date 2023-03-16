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
TempDir="macos"
AppName="hiposter"
Version=$1
Machine=$(uname -m)
rm -rf $TempDir
mkdir $TempDir
cp -r ../bin/${AppName}.app ./${TempDir} 
ln -sf /Applications macos/Applications
hdiutil create ./${AppName}_macos_${Machine}_${Version}.dmg -volname "$AppName" -fs HFS+ -srcfolder $TempDir -ov -format UDZO 
fi