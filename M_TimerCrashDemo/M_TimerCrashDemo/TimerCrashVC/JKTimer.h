//
//  JKTimer.h
//  M_TimerCrashDemo
//
//  Created by JackPersonal on 2022/4/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JKTimerDelegate <NSObject>
@optional
- (void)jk_timeUp;
@end

@interface JKTimer : NSObject
@property(nullable ,nonatomic, assign)id<JKTimerDelegate>delegate;
- (void)fireTimerWithInterval:(NSTimeInterval)ti;
- (void)stopTimer;
@end

NS_ASSUME_NONNULL_END
