//
//  XYVolumeHandler.h
//  Test
//
//  Created by X140Yu on 1/18/17.
//  Copyright © 2017 X140Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "UIViewController+XYVolumeHandler.h"

@protocol XYVolumeHandlerProtocol <NSObject>

- (BOOL)needShowVolumeHandlerNotification;

@end

@interface XYVolumeHandler : NSObject

+ (nonnull instancetype)sharedInstance;

@property (nonnull, nonatomic) UIColor *notificationBackgroundColor;
@property (nonnull, nonatomic) UIColor *progressViewTintColor;
@property (nonatomic) NSTimeInterval dismissTimeInterval;

- (void)startMonitor;

- (void)endMonitor;

@end
