#import <UIKit/UIKit.h>

#import "XYVolumeStyle.h"

@interface XYVolumeView : UIView

+ (instancetype)viewWithVolume:(CGFloat)volume style:(XYVolumeStyle *)style;

- (void)updateProgress:(CGFloat)progress style:(XYVolumeStyle *)style;

@end
