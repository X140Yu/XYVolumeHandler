//
//  XYStatusBarNotificationViewController.m
//  Test
//
//  Created by X140Yu on 1/19/17.
//  Copyright © 2017 X140Yu. All rights reserved.
//

#import "XYStatusBarNotificationViewController.h"
#import "UIApplication+XYVolumeHandler.h"

@implementation XYStatusBarNotificationViewController

- (UIViewController*)mainController
{
    UIWindow *mainAppWindow = [[UIApplication sharedApplication] mainApplicationWindowIgnoringWindow:self.view.window];
    UIViewController *topController = mainAppWindow.rootViewController;

    while(topController.presentedViewController) {
        topController = topController.presentedViewController;
    }

    return topController;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return [[self mainController] shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (BOOL)shouldAutorotate {
    return [[self mainController] shouldAutorotate];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations {
#else
    - (UIInterfaceOrientationMask)supportedInterfaceOrientations {
#endif
        return [[self mainController] supportedInterfaceOrientations];
    }

    - (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
        return [[self mainController] preferredInterfaceOrientationForPresentation];
    }

    static BOOL JDUIViewControllerBasedStatusBarAppearanceEnabled() {
        static BOOL enabled = NO;
        static dispatch_once_t onceToken;

        dispatch_once(&onceToken, ^{
            enabled = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"UIViewControllerBasedStatusBarAppearance"] boolValue];
        });

        return enabled;
    }

    - (UIStatusBarStyle)preferredStatusBarStyle {
        if(JDUIViewControllerBasedStatusBarAppearanceEnabled()) {
            return [[self mainController] preferredStatusBarStyle];
        }

        return [[UIApplication sharedApplication] statusBarStyle];
    }

    - (BOOL)prefersStatusBarHidden {
        return NO;
    }

    - (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
        if(JDUIViewControllerBasedStatusBarAppearanceEnabled()) {
            return [[self mainController] preferredStatusBarUpdateAnimation];
        }
        return [super preferredStatusBarUpdateAnimation];
    }
    
    @end

