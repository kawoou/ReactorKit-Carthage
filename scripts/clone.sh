#!/bin/bash

mkdir Build
cd Build

git clone https://github.com/ReactorKit/ReactorKit.git -b "`cat ../version`" --single-branch --depth 1
cd ReactorKit

swiftenv local
swift --version

swift package generate-xcodeproj

swiftproj generate-xcconfig --podspec ReactorKit.podspec
swiftproj generate-xcodeproj --xcconfig-overrides Config.xcconfig
swiftproj configure-scheme --project ReactorKit.xcodeproj --scheme ReactorKit-Package --buildable-targets ReactorKit,ReactorKitRuntime
swiftproj remove-framework --project ReactorKit.xcodeproj --target ReactorKit --framework RxBlocking.framework
swiftproj remove-framework --project ReactorKit.xcodeproj --target ReactorKit --framework RxCocoa.framework
swiftproj remove-framework --project ReactorKit.xcodeproj --target ReactorKit --framework RxCocoaRuntime.framework
swiftproj remove-framework --project ReactorKit.xcodeproj --target ReactorKitRuntime --framework RxBlocking.framework
swiftproj remove-framework --project ReactorKit.xcodeproj --target ReactorKitRuntime --framework RxCocoa.framework
swiftproj remove-framework --project ReactorKit.xcodeproj --target ReactorKitRuntime --framework RxCocoaRuntime.framework

cd ../..