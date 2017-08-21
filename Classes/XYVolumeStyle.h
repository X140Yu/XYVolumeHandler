#import <Foundation/Foundation.h>

@interface XYVolumeStyle : NSObject

+ (nonnull instancetype)defaultStyle;

/**
 音量通知的背景颜色
 */
@property(nonnull, nonatomic) UIColor *notificationBackgroundColor;

/**
 progressView 有进度部分的背景颜色
 */
@property(nonnull, nonatomic) UIColor *progressViewProgressTintColor;

/**
 progreeView 没有进度部分的背景颜色
 */
@property(nonnull, nonatomic) UIColor *progressViewTrackTintColor;

/**
 progressView 距离屏幕边上的距离
 */
@property(nonatomic) CGFloat progressViewLeftMargin;

/**
 通知 dismiss 的时间，默认为 2.0s
 */
@property(nonatomic) NSTimeInterval dismissTimeInterval;

@property(nonnull, nonatomic) UIColor *progressViewProgressTintColorLight;
@property(nonnull, nonatomic) UIColor *progressViewTrackTintColorLight;

@end
