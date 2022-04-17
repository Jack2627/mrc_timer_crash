//
//  SimulateAd.m
//  MRC_Playground
//
//  Created by Developer on 2022/3/31.
//

#import "SimulateAd.h"

@implementation SimulateAd

- (void)dealloc{
    self.delegate = nil;
    NSLog(@"sim dealloc");
    [super dealloc];
}

#pragma mark - Public
- (void)requestAd{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(sim_finishedRequest)]) {
            [self.delegate sim_finishedRequest];
        }
    });
}

@end
