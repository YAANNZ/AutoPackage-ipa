
DATE=`date +%Y%m%d_%H%M`

cd /Users/xxx/xxx.xcworkspace

git pull

xcodebuild -workspace /Users/xxx/xxx.xcworkspace -scheme xxx -destination generic/platform=iOS archive -configuration Release ONLY_ACTIVE_ARCH=NO -archivePath /Users/xxx/AutoPackage/xcarchive/xxx_$DATE

xcodebuild -exportArchive -archivePath /Users/xxx/AutoPackage/xcarchive/xxx_$DATE.xcarchive -exportPath /Users/xxx/AutoPackage/ipa/ipa_$DATE -exportOptionsPlist /Users/xxx/AutoPackage/c/exportOptionsPlist.plist

fir login -T 20da9c980e365eb85eca2cf464748a7a

fir publish /Users/xxx/AutoPackage/ipa/ipa_$DATE/xxx.ipa
