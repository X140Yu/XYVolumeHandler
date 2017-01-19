//
//  UIViewController+XYVolumeHandler.m
//  Test
//
//  Created by X140Yu on 1/19/17.
//  Copyright © 2017 X140Yu. All rights reserved.
//

#import "UIViewController+XYVolumeHandler.h"
#import "XYVolumeHandler.h"

@implementation UIViewController (XYVolumeHandler)

- (void)xy_setupVolumeView {
    if (![self conformsToProtocol:@protocol(XYVolumeHandlerProtocol)]) {
        return;
    }

    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[MPVolumeView class]]) {
            return;
        }
    }

    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(-100, -100, 100, 100)];
    [self.view addSubview:volumeView];
}

@end
