#!/bin/bash -e
set -o pipefail

cd Build/ReactorKit

# Dynamic framework
rm -rf Carthage/
carthage build --no-skip-current --verbose | xcpretty -c
carthage archive ReactorKit
cp ReactorKit.framework.zip ../../ReactorKit.framework.zip

# Static framework
rm -rf Carthage/

xcconfig=$(mktemp /tmp/static.xcconfig.XXXXXX)
trap 'rm -f "$xcconfig"' INT TERM HUP EXIT

cp ../../ld.py ./ld.py
echo "LD = ${PWD}/ld.py" >> $xcconfig
echo "DEBUG_INFORMATION_FORMAT = dwarf" >> $xcconfig

export XCODE_XCCONFIG_FILE="$xcconfig"
carthage build ReactorKit --no-skip-current --verbose | xcpretty -c
carthage archive ReactorKit
cp ReactorKit.framework.zip ../../ReactorKit-Static.framework.zip

cd ../..