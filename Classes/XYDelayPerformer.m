#import "XYDelayPerformer.h"

@interface XYDelayPerformer ()

@property (nonatomic, nullable) NSTimer *delayTimer;
@property (nonatomic, copy, nullable) XYVoidBlock action;

@end

@implementation XYDelayPerformer

- (void)dealloc {
    [self cancelAction];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delayTimeIntervel = 0.3;
    }
    return self;
}

- (void)delayPerform:(XYVoidBlock)action {
    [self delayPerform:action delay:self.delayTimeIntervel];
}

- (void)delayPerform:(XYVoidBlock)action delay:(NSTimeInterval)delay {
    [self cancelAction];
    self.action = action;
    self.delayTimer = [NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(performAction:) userInfo:nil repeats:NO];
}

- (void)performImmediately {
    if (self.action) {
        self.action();
    }
    [self cancelAction];
}

- (void)cancelAction {
    [self.delayTimer invalidate];
    self.delayTimer = nil;
    self.action = nil;
}


- (void)performAction:(NSTimer *)timer {
    if (timer != self.delayTimer) {
        return;
    }
    if (self.action) {
        self.action();
    }
    self.action = nil;
    self.delayTimer = nil;
}

@end
