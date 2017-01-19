//
//  XYVolumeHandler.m
//  Test
//
//  Created by X140Yu on 1/18/17.
//  Copyright © 2017 X140Yu. All rights reserved.
//

#import "XYVolumeHandler.h"
#import <AVFoundation/AVFoundation.h>

#import "XYStatusBarNotification.h"

@implementation XYVolumeHandler

+ (instancetype)sharedInstance {
    static XYVolumeHandler *sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.notificationBackgroundColor = [UIColor whiteColor];
        sharedInstance.progressViewTintColor = [UIColor blackColor];
        sharedInstance.dismissTimeInterval = 2.0;
    });

    return sharedInstance;
}

- (void)dealloc {
    [self endMonitor];
}

- (void)startMonitor {
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [self registerNotification];
}

- (void)endMonitor {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(volumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification"
                                               object:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

- (void)volumeChanged:(NSNotification *)notification {

    float volume = [[notification userInfo][@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];

    UIViewController *vc = [XYVolumeHandler topViewController];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = ((UINavigationController *)vc).topViewController;
    }
    if (vc && [vc conformsToProtocol:@protocol(XYVolumeHandlerProtocol)]) {
        id<XYVolumeHandlerProtocol> protocolVC = (id<XYVolumeHandlerProtocol>)vc;
        if ([vc respondsToSelector:@selector(needShowVolumeHandlerNotification)]) {
            BOOL needShow = [protocolVC needShowVolumeHandlerNotification];

            if (needShow) {
                [XYStatusBarNotification showProgress:volume];
            }
        }
    }
}

+ (UIViewController *)topViewController {
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    while (rootVC.presentedViewController &&
           ![rootVC.presentedViewController isMovingFromParentViewController] &&
           ![rootVC.presentedViewController isBeingDismissed])
    {
        rootVC = rootVC.presentedViewController;
    }
    return rootVC;
}

@end
