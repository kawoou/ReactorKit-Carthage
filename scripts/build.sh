#!/bin/bash -e
set -o pipefail

cd Build/ReactorKit

xcconfig="${PWD}/Config.xcconfig"
echo $xcconfig
echo "SWIFT_VERSION = 5.0" >> $xcconfig

# Dynamic framework
echo "Build: Dynamic framework"

rm -rf Carthage/

cat $xcconfig

carthage build --no-skip-current --verbose | xcpretty -c
carthage archive ReactorKit ReactorKitRuntime
cp ReactorKit.framework.zip ../../ReactorKit.framework.zip
rm ReactorKit.framework.zip

# Static framework
echo "Build: Static framework"

rm -rf Carthage/

cp ../../scripts/ld.py ./ld.py

echo "LD = ${PWD}/ld.py" >> $xcconfig
echo "MACH_O_TYPE = staticlib" >> $xcconfig
echo "DEBUG_INFORMATION_FORMAT = dwarf" >> $xcconfig

export XCODE_XCCONFIG_FILE="$xcconfig"

cat $xcconfig

carthage build --no-skip-current --verbose | xcpretty -c
cp -rf Carthage/Build/Mac/Static/* Carthage/Build/Mac/
cp -rf Carthage/Build/iOS/Static/* Carthage/Build/iOS/
cp -rf Carthage/Build/tvOS/Static/* Carthage/Build/tvOS/
cp -rf Carthage/Build/watchOS/Static/* Carthage/Build/watchOS/
carthage archive ReactorKit ReactorKitRuntime
cp ReactorKit.framework.zip ../../ReactorKit-Static.framework.zip
rm ReactorKit.framework.zip

cd ../..
