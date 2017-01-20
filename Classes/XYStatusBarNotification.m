//
//  XYStatusBarNotification.m
//  Test
//
//  Created by X140Yu on 1/18/17.
//  Copyright © 2017 X140Yu. All rights reserved.
//

#import "XYStatusBarNotification.h"
#import "UIApplication+XYVolumeHandler.h"
#import "XYStatusBarNotificationViewController.h"
#import "XYVolumeHandler.h"

@interface XYStatusBarNotification ()

@property (nonatomic) UIWindow *overlayWindow;
@property (nonatomic) UIProgressView *progressView;
@property (nonatomic) UIView *topBar;
@property (nonatomic) NSTimer *dismissTimer;
@property (nonatomic) CGFloat progress;

@end

@implementation XYStatusBarNotification

+ (XYStatusBarNotification*)sharedInstance {
    static dispatch_once_t once;
    static XYStatusBarNotification *sharedInstance;
    dispatch_once(&once, ^ {
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)showAndDismissAfter:(NSTimeInterval)timeInterval {
    [[self sharedInstance] show];
    [self dismissAfter:timeInterval];
}

+ (void)dismiss {
    [self dismissAnimated:YES];
}

+ (void)dismissAnimated:(BOOL)animated {
    [[self sharedInstance] dismissAnimated:animated];
}

+ (void)dismissAfter:(NSTimeInterval)delay {
    [[self sharedInstance] setDismissTimerWithInterval:delay];
}

+ (void)showProgress:(CGFloat)progress {
    [self showAndDismissAfter:[XYVolumeHandler sharedInstance].dismissTimeInterval];
    [[self sharedInstance] setProgress:progress];
}

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willChangeStatusBarFrame:)
                                                     name:UIApplicationWillChangeStatusBarFrameNotification
                                                   object:nil];
    }

    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)show {

    [[NSRunLoop currentRunLoop] cancelPerformSelector:@selector(dismiss) target:self argument:nil];
    [self.topBar.layer removeAllAnimations];

    [self.overlayWindow setHidden:NO];

    self.topBar.backgroundColor = [XYVolumeHandler sharedInstance].notificationBackgroundColor;

    self.progress = 0.0;
    [UIView animateWithDuration:0.4 animations:^{
        self.topBar.alpha = 1.0;
        self.topBar.transform = CGAffineTransformIdentity;
    }];
}

- (void)setDismissTimerWithInterval:(NSTimeInterval)interval {
    [self.dismissTimer invalidate];
    self.dismissTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]
                                                 interval:0
                                                   target:self
                                                 selector:@selector(dismiss:)
                                                 userInfo:nil
                                                  repeats:NO];

    [[NSRunLoop currentRunLoop] addTimer:self.dismissTimer forMode:NSRunLoopCommonModes];
}

- (void)dismiss:(NSTimer*)timer {
    [self dismissAnimated:YES];
}

- (void)dismissAnimated:(BOOL)animated {
    [self.dismissTimer invalidate];
    self.dismissTimer = nil;

    BOOL animationsEnabled = YES;
    animated &= animationsEnabled;

    dispatch_block_t animation = ^{
        self.topBar.transform = CGAffineTransformMakeTranslation(0, -self.topBar.frame.size.height);
    };

    void(^complete)(BOOL) = ^(BOOL finished) {
        [self.overlayWindow removeFromSuperview];
        [self.overlayWindow setHidden:YES];
        _overlayWindow.rootViewController = nil;
        _overlayWindow = nil;
        _progressView = nil;
        _topBar = nil;
    };

    if (animated) {
        [UIView animateWithDuration:0.3 animations:animation completion:complete];
    } else {
        animation();
        complete(YES);
    }
}

- (void)setProgress:(CGFloat)progress {
    if (_topBar == nil) {
        return;
    }

    _progress = (CGFloat)MIN(1.0, MAX(0.0,progress));

    _progressView.frame = self.topBar.bounds;
    CGFloat leftMargin = [XYVolumeHandler sharedInstance].progressViewLeftMargin;
    _progressView.frame = CGRectMake(self.topBar.bounds.origin.x + leftMargin, self.topBar.bounds.origin.y + 8, self.topBar.bounds.size.width - leftMargin * 2, self.topBar.bounds.size.height);

    self.progressView.progressTintColor = [XYVolumeHandler sharedInstance].progressViewProgressTintColor;
    self.progressView.trackTintColor = [XYVolumeHandler sharedInstance].progressViewTrackTintColor;
    self.progressView.progress = progress;
}

- (UIWindow *)overlayWindow {
    if (_overlayWindow == nil) {
        _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayWindow.backgroundColor = [UIColor clearColor];
        _overlayWindow.userInteractionEnabled = NO;
        _overlayWindow.windowLevel = UIWindowLevelStatusBar;
        _overlayWindow.rootViewController = [[XYStatusBarNotificationViewController alloc] init];
        _overlayWindow.rootViewController.view.backgroundColor = [UIColor clearColor];
        [self updateWindowTransform];
        [self updateTopBarFrameWithStatusBarFrame:[[UIApplication sharedApplication] statusBarFrame]];
    }
    return _overlayWindow;
}

- (UIView *)topBar {
    if (_topBar == nil) {
        _topBar = [[UIView alloc] init];
        [self.overlayWindow.rootViewController.view addSubview:_topBar];
        self.topBar.transform = CGAffineTransformMakeTranslation(0, -self.topBar.frame.size.height);
    }
    return _topBar;
}

- (UIProgressView *)progressView {
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
        [self.topBar addSubview:_progressView];
    }
    return _progressView;
}

- (void)updateWindowTransform {
    UIWindow *window = [[UIApplication sharedApplication]
            mainApplicationWindowIgnoringWindow:self.overlayWindow];
    _overlayWindow.transform = window.transform;
    _overlayWindow.frame = window.frame;
}

- (void)updateTopBarFrameWithStatusBarFrame:(CGRect)rect {
    CGFloat width = MAX(rect.size.width, rect.size.height);
    CGFloat height = MIN(rect.size.width, rect.size.height);

    CGFloat yPos = 0;
    if (height > 20.0) {
        yPos = (CGFloat)(-height/2.0);
    }

    _topBar.frame = CGRectMake(0, yPos, width, height);
}

- (void)willChangeStatusBarFrame:(NSNotification*)notification {
    CGRect newBarFrame = [notification.userInfo[UIApplicationStatusBarFrameUserInfoKey] CGRectValue];
    NSTimeInterval duration = [[UIApplication sharedApplication] statusBarOrientationAnimationDuration];

    void(^updateBlock)() = ^{
        [self updateWindowTransform];
        [self updateTopBarFrameWithStatusBarFrame:newBarFrame];
        self.progress = self.progress;
    };

    [UIView animateWithDuration:duration animations:^{
        updateBlock();
    } completion:^(BOOL finished) {
        updateBlock();
    }];
}

@end
