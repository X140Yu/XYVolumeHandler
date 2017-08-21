#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "UIViewController+XYVolumeHandler.h"
#import "XYVolumeStyle.h"

/// 如果你想要自定义音量调节 bar 的样式，请在对应的 ViewController 中实现该协议方法
@protocol XYVolumeHandlerCustomizable

- (nonnull XYVolumeStyle *)volumeStyle;

@end

@interface XYVolumeHandler : NSObject

+ (nonnull instancetype)sharedInstance;

/// 设置 default style
@property(nonatomic, nonnull) XYVolumeStyle *volumeStyle;

/// 开始监听音量变化的通知
- (void)startMonitor;

/// 关闭监听音量变化的通知
- (void)endMonitor;

@end
