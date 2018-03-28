# XYVolumeHandler

[![Build Status](https://travis-ci.org/X140Yu/XYVolumeHandler.svg?branch=master)](https://travis-ci.org/X140Yu/XYVolumeHandler)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

🎶 Graceful handle the volume changes in your iOS apps like Instagram.

# Requirement
iOS 8+, Objective-C And Swift

# Installation
pod 'XYVolumeHandler'

# Usage
In the ViewController you want to be handled,

```swift
// ViewController.m
import XYVolumeHandler
```

```swift
override func viewDidLoad() {
   super.viewDidLoad()
   // Start monitor the volume taps     
   XYVolumeHandler.sharedInstance().startMonitor()
   self.xy_setupVolumeView()
}
```
now, you are ready to be handled.

If you want to do addition customizable things,

```swift
extension ViewController: XYVolumeHandlerCustomizable {
    // it you wish to disable the handler in certain viewController
    func useSystemVolumeView() -> Bool {
        return true
    }

    func volumeStyle() -> XYVolumeStyle {
        // return a different style than default style
    }
}
```

# Licence

MIT

