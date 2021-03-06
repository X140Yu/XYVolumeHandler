
#import "UIViewController+XYVolumeHandler.h"
#import "XYVolumeHandler.h"

@implementation UIViewController (XYVolumeHandler)

- (void)xy_addVolumeViewIfNeeded {

    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[MPVolumeView class]]) {
            return;
        }
    }

    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(-100, -100, 100, 100)];
    volumeView.clipsToBounds = YES;
    volumeView.showsRouteButton = NO;
    [self.view addSubview:volumeView];
    [[XYVolumeHandler sharedInstance] appendAddVolumeViewViewController:self];
}

- (XYVolumeStyle *)xy_topMostStyle {

    UIViewController *maybeVC = [self xy_toppestViewController];
    XYVolumeStyle *style = [XYVolumeHandler sharedInstance].volumeStyle;
    while (maybeVC.parentViewController) {
        if ([maybeVC conformsToProtocol:@protocol(XYVolumeHandlerCustomizable)] && [maybeVC respondsToSelector:@selector(volumeStyle)]) {
            UIViewController<XYVolumeHandlerCustomizable> *obj = (UIViewController<XYVolumeHandlerCustomizable> *)maybeVC;
            style = obj.volumeStyle;
            break;
        }
        maybeVC = maybeVC.parentViewController;
    }

    return style;
}

- (UIViewController *)xy_toppestViewController {
    if (self.presentedViewController) {
        return [self.presentedViewController xy_toppestViewController];
    } else {
        for (UIView *v in self.view.subviews) {
            id nextRes = v.nextResponder;
            if ([nextRes isKindOfClass:UINavigationController.class]) {
                UINavigationController *viewController = (UINavigationController *)nextRes;
                return [viewController.visibleViewController xy_toppestViewController];
            } else if ([nextRes isKindOfClass:UIViewController.class]) {
                UIViewController *viewController = (UIViewController *)nextRes;
                return [viewController xy_toppestViewController];
            }
        }
    }
    return self;
}

- (BOOL)xy_shouldShowSystemVolumeStyle {
    if ([self conformsToProtocol:@protocol(XYVolumeHandlerCustomizable)] &&
        [self respondsToSelector:@selector(useSystemVolumeView)]) {
        UIViewController<XYVolumeHandlerCustomizable> *protocolVC = (UIViewController<XYVolumeHandlerCustomizable> *)self;
        return [protocolVC useSystemVolumeView];
    }

    return NO;
}

- (void)xy_removeVolumeViewIfNeeded {
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:MPVolumeView.class]) {
            [v removeFromSuperview];
            break;
        }
    }
}

@end