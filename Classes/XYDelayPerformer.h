#import <Foundation/Foundation.h>

typedef void (^XYVoidBlock)();

NS_ASSUME_NONNULL_BEGIN

@interface XYDelayPerformer : NSObject

/// 默认 0.3s
@property(nonatomic) NSTimeIntervals delayTimeIntervel;

- (void)delayPerform:(XYVoidBlock)action;
- (void)delayPerform:(XYVoidBlock)action delay:(NSTimeInterval)delay;
- (void)performImmediately;
- (void)cancelAction;

@end

NS_ASSUME_NONNULL_END
