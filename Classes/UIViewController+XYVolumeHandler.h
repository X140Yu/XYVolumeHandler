#import <UIKit/UIKit.h>

@class XYVolumeStyle;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (XYVolumeHandler)

/// add a MPVolumeView to self.view
- (void)xy_addVolumeViewIfNeeded;

/// find the top most volumeStyle
- (XYVolumeStyle *)xy_topMostStyle;

/// find the toppest view controller
- (UIViewController *)xy_toppestViewController;

- (BOOL)xy_shouldShowSystemVolumeStyle;

- (void)xy_removeVolumeViewIfNeeded;

@end

NS_ASSUME_NONNULL_END