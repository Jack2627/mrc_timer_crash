//
//  JKTimer.m
//  M_TimerCrashDemo
//
//  Created by JackPersonal on 2022/4/17.
//

#import "JKTimer.h"

@implementation JKTimer{
    NSTimer *_timer;
}

- (void)dealloc{
    NSLog(@"JKTimer dealloc");
    [super dealloc];
}

#pragma mark - Private
- (void)actionTimeUp{
    if (self.delegate && [self.delegate respondsToSelector:@selector(jk_timeUp)]) {
        [self.delegate jk_timeUp];
    }
    [self stopTimer];
}

#pragma mark - Public
- (void)fireTimerWithInterval:(NSTimeInterval)ti{
    if (ti <= 0) {
        return;
    }
    [self stopTimer];
    _timer = [[NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(actionTimeUp) userInfo:nil repeats:NO] retain];
}

- (void)stopTimer{
    if (_timer) {
        [_timer invalidate];
        [_timer release]; _timer = nil;
    }
}

@end
