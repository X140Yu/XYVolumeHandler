#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "UIApplication+XYVolumeHandler.h"
#import "UIViewController+XYVolumeHandler.h"
#import "XYStatusBarNotification.h"
#import "XYStatusBarNotificationViewController.h"
#import "XYVolumeHandler.h"

FOUNDATION_EXPORT double XYVolumeHandlerVersionNumber;
FOUNDATION_EXPORT const unsigned char XYVolumeHandlerVersionString[];

