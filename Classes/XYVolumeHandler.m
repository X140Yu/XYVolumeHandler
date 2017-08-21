#import "XYVolumeHandler.h"
#import <AVFoundation/AVFoundation.h>
#import "XYVolumeView.h"

@import ReactiveObjC;
@import CWStatusBarNotification;

@interface XYVolumeHandler()

@property (nonatomic) XYVolumeView *volumeView;

@property (nonatomic) CWStatusBarNotification *noti;

@property (nonatomic) ZHDelayPerformer *delayPerformer;

@end

@implementation XYVolumeHandler

+ (instancetype)sharedInstance {
    static XYVolumeHandler *sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.volumeStyle = [XYVolumeStyle defaultStyle];
    });

    return sharedInstance;
}

- (void)dealloc {
    [self endMonitor];
}

- (void)startMonitor {
    [self endMonitor];
    [self registerNotification];
}

- (void)endMonitor {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(volumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification"
                                               object:nil];
}

- (void)volumeChanged:(NSNotification *)notification {

    NSString *parameter = notification.userInfo[@"AVSystemController_AudioCategoryNotificationParameter"];
    if ([parameter isEqualToString:@"Ringtone"]) {
        return;
    }

    float volume = [[notification userInfo][@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];

    /// 会先一直向上找到最顶部的，再向下找到第一个符合协议的，找不到会返回默认样式
    UIViewController *toppestViewController = [[UIApplication sharedApplication].keyWindow.rootViewController xy_toppestViewController];
    [toppestViewController xy_setupVolumeView];
    XYVolumeStyle *style = [toppestViewController xy_topMostStyle];

    if (!self.volumeView.superview) {
        [self.noti displayNotificationWithView:self.volumeView completion:nil];
    }

    @weakify(self);
    [self.delayPerformer delayPerform:^{
        @strongify(self);
        [self.noti dismissNotificationWithCompletion:^{
            @strongify(self);
            [self.volumeView removeFromSuperview];
        }];
    } delay:2];

    [self.volumeView updateProgress:volume style:style];
}

- (CWStatusBarNotification *)noti {
    if (!_noti) {
        _noti = [[CWStatusBarNotification alloc] init];
        _noti.notificationAnimationType = CWNotificationAnimationTypeOverlay;
        _noti.notificationAnimationInStyle = CWNotificationAnimationStyleTop;
        _noti.notificationAnimationOutStyle = CWNotificationAnimationStyleTop;
    }
    return _noti;
}

- (XYVolumeView *)volumeView {
    if (!_volumeView) {
        _volumeView = [XYVolumeView viewWithVolume:0 style:self.volumeStyle];
    }
    return _volumeView;
}

- (ZHDelayPerformer *)delayPerformer {
    if (!_delayPerformer) {
        _delayPerformer = [ZHDelayPerformer new];
    }
    return _delayPerformer;
}

@end
