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
@property (nonnull, nonatomic) UIColor *progressViewProgressTintColor;
@property (nonnull, nonatomic) UIColor *progressViewTrackTintColor;
@property (nonatomic) CGFloat progressViewLeftMargin;
@property (nonatomic) NSTimeInterval dismissTimeInterval;
@property (nonatomic, readonly) BOOL ignoreProtocol;

- (void)startMonitor:(BOOL)ignoreProtocol;

- (void)startMonitor;

- (void)endMonitor;

@end
