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
wails build -clean -platform darwin/arm64
echo "cd $PWD"
cd build/pack/
TempDir="macos"
AppName="hiposter"
Version=$1
Machine="arm64"
rm -rf $TempDir
mkdir $TempDir
cp -r ../bin/${AppName}.app ./${TempDir} 
ln -sf /Applications macos/Applications
hdiutil create ./${AppName}_macos_${Machine}_${Version}.dmg -volname "$AppName" -fs HFS+ -srcfolder $TempDir -ov -format UDZO 
fi