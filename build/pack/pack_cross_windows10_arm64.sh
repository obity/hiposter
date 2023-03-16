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
wails build -clean -platform windows/arm64 -nsis
echo "cd $PWD"
cd build/pack/
TempDir="windows10"
AppName="hiposter"
Version=$1
Machine="arm64"
OutFile=${TempDir}/${AppName}_windows10+_${Machine}_${Version}.exe
rm -rf $TempDir
mkdir $TempDir
cp -r ../bin/${AppName}*installer.exe ./${TempDir} 
mv ./${TempDir}/*installer.exe $OutFile
echo "created: $PWD/$OutFile"
md5 $OutFile > $OutFile.md5
fi