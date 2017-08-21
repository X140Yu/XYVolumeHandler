#import "XYVolumeHandler.h"
#import "XYVolumeView.h"

@interface XYVolumeView ()

@property (nonatomic) CGFloat volume;

@property (nonatomic) UIProgressView *progressView;
@property (nonatomic) XYVolumeStyle *volumeStyle;

@end

@implementation XYVolumeView

- (instancetype)initWithFrame:(CGRect)frame volume:(CGFloat)volume style:(XYVolumeStyle *)style {
    if (self = [super initWithFrame:frame]) {
        _volume = volume;
        _volumeStyle = style;
        [self setupStyle];
    }
    return self;
}

+ (instancetype)viewWithVolume:(CGFloat)volume style:(XYVolumeStyle *)style {
    return [[XYVolumeView alloc] initWithFrame:CGRectZero volume:volume style:style];
}

- (void)updateProgress:(CGFloat)progress style:(XYVolumeStyle *)style {
    self.volume = progress;
    self.volumeStyle = style;
    self.backgroundColor = self.volumeStyle.notificationBackgroundColor;
    self.progressView.progressTintColor = self.volumeStyle.progressViewProgressTintColor;
    self.progressView.trackTintColor = self.volumeStyle.progressViewTrackTintColor;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.progressView.frame = self.bounds;
    CGFloat leftMargin = self.volumeStyle.progressViewLeftMargin;
    self.progressView.frame = CGRectMake(self.bounds.origin.x + leftMargin, self.bounds.origin.y + 8, self.bounds.size.width - leftMargin * 2, self.bounds.size.height);
    self.progressView.progress = self.volume;
}


#pragma mark - private

- (void)setupStyle {
    self.backgroundColor = self.volumeStyle.notificationBackgroundColor;

    self.progressView = ({
        UIProgressView *v = [UIProgressView new];
        v.progressTintColor = self.volumeStyle.progressViewProgressTintColor;
        v.trackTintColor = self.volumeStyle.progressViewTrackTintColor;
        [self addSubview:v];
        v;
    });
}


@end
