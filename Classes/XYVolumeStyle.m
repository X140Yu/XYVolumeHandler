#import "XYVolumeStyle.h"

@implementation XYVolumeStyle

+ (instancetype)defaultStyle {
    XYVolumeStyle *style = [XYVolumeStyle new];
    style.notificationBackgroundColor = [UIColor whiteColor];
    style.progressViewProgressTintColor = [UIColor blackColor];
    style.progressViewTrackTintColor = [UIColor grayColor];
    style.progressViewLeftMargin = 10.0;
    style.dismissTimeInterval = 2.0;
    return style;
}

@end
