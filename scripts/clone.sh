#!/bin/bash

mkdir Build
cd Build

git clone https://github.com/ReactorKit/ReactorKit.git -b "`cat ../version`" --single-branch --depth 1
cd ReactorKit

swiftenv local
swift --version

swift package generate-xcodeproj

cd ../..