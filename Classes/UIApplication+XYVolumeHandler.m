//
//  UIApplication+XYVolumeHandler.m
//  Test
//
//  Created by X140Yu on 1/19/17.
//  Copyright © 2017 X140Yu. All rights reserved.
//

#import "UIApplication+XYVolumeHandler.h"

@implementation UIApplication (XYVolumeHandler)

- (UIWindow*)mainApplicationWindowIgnoringWindow:(UIWindow *)ignoringWindow {
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (!window.hidden && window != ignoringWindow) {
            return window;
        }
    }
    return nil;
}

@end
