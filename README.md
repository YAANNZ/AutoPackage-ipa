# AutoPackage-ipa
.sh脚本自动化打包并上传到fir

##### 要实现的功能
* **update**代码
* 编译打包**app**
* 上传到**fir.im**

##### 命令
* 更新代码
> ` cd /Users/xxx/xxx.xcworkspace `
> ` git pull `

* xcodebuild打包Archive文件
> ` xcodebuild -workspace ${path to *.xcworkspace} -scheme ${scheme} -destination generic/platform=iOS archive -configuration Release ONLY_ACTIVE_ARCH=NO  -archivePath ${export path *.xcarichive} `
> * -workspace 对应`xxx.xcworkspace`
> * -scheme 对应 project的`scheme`
> * -configuration 对应`Debug、Release`
> * -archivePath 对应生成`xxx.xcarichive`的路径

* 导出ipa
> ` xcodebuild -exportArchive -archivePath ${path to *.xcarchive} -exportPath ${export path to dir} -exportOptionsPlist ${path to export options *.plist} `
> * -archivePath 对应`xxx.xcarchive`的路径
> * -exportPath 对应生成的`ipa`的路径
> * -exportOptionsPlist 对应导出`plist`格式的配置文件

* 上传到fir
> `fir login -T ${API token}`
` fir publish ${path to xxx.ipa}`

* [简书地址](https://www.jianshu.com/p/837dcb72c428)
