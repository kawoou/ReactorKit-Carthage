#!/bin/bash -e
set -o pipefail

cd Build/ReactorKit

# Dynamic framework
rm -rf Carthage/
carthage build --no-skip-current --verbose | xcpretty -c
carthage archive ReactorKit ReactorKitRuntime
cp ReactorKit.framework.zip ../../ReactorKit.framework.zip

# Static framework
rm -rf Carthage/

cp ../../scripts/ld.py ./ld.py
xcconfig=$(mktemp /tmp/static.xcconfig.XXXXXX)
trap 'rm -f "$xcconfig"' INT TERM HUP EXIT

echo "LD = ${PWD}/ld.py" >> $xcconfig
echo "MACH_O_TYPE = staticlib" >> $xcconfig
echo "DEBUG_INFORMATION_FORMAT = dwarf" >> $xcconfig

export XCODE_XCCONFIG_FILE="$xcconfig"
carthage build --no-skip-current --verbose | xcpretty -c
mv Carthage/Build/Mac/Static/* Carthage/Build/Mac/
mv Carthage/Build/iOS/Static/* Carthage/Build/iOS/
mv Carthage/Build/tvOS/Static/* Carthage/Build/tvOS/
mv Carthage/Build/watchOS/Static/* Carthage/Build/watchOS/
carthage archive ReactorKit ReactorKitRuntime
cp ReactorKit.framework.zip ../../ReactorKit-Static.framework.zip

cd ../..
