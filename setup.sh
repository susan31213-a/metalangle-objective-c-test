git submodule update --init --recursive --force || (git submodule sync --recursive && git submodule update --init --recursive --force)
cd metalangle
sh ./ios/xcode/fetchDependencies.sh
cd ..
cp -r metalangle/third_party/ third_party/
cp -r metalangle/include/ include/
cp -r metalangle/src/ src/
cp -r metalangle/ios/xcode/MGLKit/ ios/HelloTriangle/MGLKit
cp metalangle/ios/xcode/Info.plist ios/HelloTriangle/Info.plist
