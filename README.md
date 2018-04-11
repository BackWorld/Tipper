### 要求
- Xcode8.3+
- Swift3.2+
- iOS8.0+

### 介绍
##### HUD
- 是最常用的一个网络请求提示控件，有一些开源的很优秀如[MBProgressHUD](https://github.com/jdg/MBProgressHUD)，但它是基于OC写的，且一直没有对应的Swift版本。
- 另外星数最多的一个HUD库为[SwiftNotice](https://github.com/johnlui/SwiftNotice)，但它UI实现太“粗糙”，所以我就打造了自己的一套提示库Tipper。

![TipperHUD](https://upload-images.jianshu.io/upload_images/1334681-6f48d35adea39e27.gif?imageMogr2/auto-orient/strip)
- 使用
```
public extension TipperHUD{
// 样式
	enum Style: Int {
	    case loading = 0, success = 1, warning = 2, failure = 3
    }
}
// 调用
Tipper.hud(style: style, delay: delay, message: "xxx")
// 注意delay为停留的时间，.loading样式下是无效的，得手动removeAll()
```

##### Toast
- Toast是模仿安卓系统自带的Toast提示控件的，用法简单

![TipperToast](https://upload-images.jianshu.io/upload_images/1334681-c75a96da431a9151.gif?imageMogr2/auto-orient/strip)

- 用法
```
Tipper.toast(message: "xxx", delay: delay)
```

##### SnackBar
- SnackBar是位于顶部或底部的局部提示控件，具有不打断当前操作的有点，相比HUD和Dialog，用户体验更好，如QQ音乐里的断网提示等。

![TipperSnackBar](https://upload-images.jianshu.io/upload_images/1334681-8e452bdf45046616.gif?imageMogr2/auto-orient/strip)

- 用法
```
public extension TipperSnackBar{
// 位置
	enum Position: Int {
		case top = 0, bottom = 1
	}
// 样式
	enum Style: Int {
		case `default`, success, warning, failure
}
}

// Action为右侧可交互按钮，支持icon和title两种显示方式，如果有action，则delay失效，需要手动removeAll()
struct Action {
		public typealias Handler = (() -> Void)
		public var handler: Handler!
		public var title: String?
		public var image: UIImage?
		
		public init(title: String, handler: @escaping Handler) {
			self.title = title
			self.handler = handler
		}
		
		public init(image: UIImage, handler: @escaping Handler) {
			self.image = image
			self.handler = handler
		}
}
// 调用
Tipper.snackBar(position: position, style: style, message: "xxx", delay: delay, action: action)
```

##### Bubble
- Bubble这个控件暂时只是一个静态提示的控件，附着于某个UIView而显示，并且目前箭头只支持向下，未做布局适配，是公司项目中比较特别的一个控件，大家按需使用。

![TipperBubble](https://upload-images.jianshu.io/upload_images/1334681-1d957891b33a8bbd.gif?imageMogr2/auto-orient/strip)

- 用法
```
Tipper.bubble(from: sender, message: "xxx")
```

### Carthage
- 目前该控件库已上传到github上，支持Carthage编译
- 用法
>1.在你的Cartfile中加入
`github "BackWorld/Tipper" "master"`

>2.在终端执行`carthage update`

> 3.将`Carthage/Build/iOS`目录下的`Tipper.framework`拖到你的项目中
![Tipper.framework](https://upload-images.jianshu.io/upload_images/1334681-4148c8aa39b48046.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> 4.在使用的swift文件中`import Tipper`即可

### 简书
https://www.jianshu.com/p/2530ec4df309

### iPhoneX适配
![iPhoneX适配](https://upload-images.jianshu.io/upload_images/1334681-0c0cb63965b264ba.gif?imageMogr2/auto-orient/strip)

> 如果对你有帮助，别忘了点个赞和关注~

