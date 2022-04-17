//
//  SimulateAd.h
//  MRC_Playground
//
//  Created by Developer on 2022/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SimulateAdDelegate <NSObject>
@optional
- (void)sim_finishedRequest;
@end

@interface SimulateAd : NSObject
@property(nonatomic, assign, nullable)id<SimulateAdDelegate>delegate;
/**
 模拟广告请求，1s后回调结果
 */
- (void)requestAd;
@end

NS_ASSUME_NONNULL_END
