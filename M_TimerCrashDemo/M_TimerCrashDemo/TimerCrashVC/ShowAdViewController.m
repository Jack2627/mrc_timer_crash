//
//  ShowAdViewController.m
//  MRC_Playground
//
//  Created by Developer on 2022/3/31.
//

#import "ShowAdViewController.h"
#import "SimulateAd.h"
#import "JKTimer.h"

@interface ShowAdViewController ()<SimulateAdDelegate, JKTimerDelegate>

@end

@implementation ShowAdViewController{
    SimulateAd *_adObj;
    JKTimer *_safeTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Wait";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self actionRequestAd];
}

- (void)dealloc{
    NSLog(@"timerVC dealloc");
    if (_adObj) {
        _adObj.delegate = nil;
        [_adObj release]; _adObj = nil;
    }
    [self stopTimer];
    [super dealloc];
}

#pragma mark - Private
- (void)actionRequestAd{
    if (!_adObj) {
        _adObj = [[SimulateAd alloc] init];
        _adObj.delegate = self;
    }
    [_adObj requestAd];
    
    [self stopTimer];
    _safeTimer = [[JKTimer alloc] init];
    _safeTimer.delegate = self;
    [_safeTimer fireTimerWithInterval:3];
    
    self.title = @"Requesting";
}

- (void)stopTimer{
    if (_safeTimer) {
        [_safeTimer stopTimer];
        _safeTimer.delegate = nil;
        [_safeTimer release]; _safeTimer = nil;
    }
}

#pragma mark - SimulateAdDelegate
- (void)sim_finishedRequest{
    /*
     SimulateAd的回调方法
     正常情况下即页面没有退出，nav保持对ShowAdViewController(self)的持有，在广告结果回调中结束time是正确的流程
     如果页面已经pop，nav已经不会对self有强引用，调用stopTime会调用[_timer invalidate]此时runtime将释放对self的强引用，所以会进入dealloc流程
     */
    [self stopTimer];
    //如果已经完成dealloc流程再调用self.title即为访问悬垂指针，将会造成崩溃
    self.title = @"Success";
}

#pragma mark - JKTimerDelegate
- (void)jk_timeUp{
    [self stopTimer];
    if (_adObj) {
        _adObj.delegate = nil;
        [_adObj release]; _adObj = nil;
    }
    
    self.title = @"Timeout";
}
@end
