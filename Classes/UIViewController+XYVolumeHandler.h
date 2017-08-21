#import <UIKit/UIKit.h>

@class XYVolumeStyle;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (XYVolumeHandler)

/// add a MPVolumeView to self.view
- (void)xy_setupVolumeView;

/// find the top most volumeStyle
- (XYVolumeStyle *)xy_topMostStyle;

/// find the toppest view controller
- (UIViewController *)xy_toppestViewController;

@end

NS_ASSUME_NONNULL_END
