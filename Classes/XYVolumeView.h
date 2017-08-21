//
//  XYVolumeView.h
//  Test
//
//  Created by X140Yu on 1/18/17.
//  Copyright © 2017 X140Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XYVolumeStyle.h"

@interface XYVolumeView : UIView

+ (instancetype)viewWithVolume:(CGFloat)volume style:(XYVolumeStyle *)style;

- (void)updateProgress:(CGFloat)progress style:(XYVolumeStyle *)style;

@end

