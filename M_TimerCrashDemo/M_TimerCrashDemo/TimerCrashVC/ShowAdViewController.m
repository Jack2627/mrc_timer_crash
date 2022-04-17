//
//  ShowAdViewController.m
//  MRC_Playground
//
//  Created by Developer on 2022/3/31.
//

#import "ShowAdViewController.h"
#import "SimulateAd.h"

@interface ShowAdViewController ()<SimulateAdDelegate>

@end

@implementation ShowAdViewController{
    NSTimer *_timer;
    SimulateAd *_adObj;
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
    //隐性的[self retain]
    _timer = [[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(actionTimeout:) userInfo:nil repeats:NO] retain];
    
    self.title = @"Requesting";
}

- (void)actionTimeout:(NSTimer *)timer{
    [self stopTimer];
    if (_adObj) {
        _adObj.delegate = nil;
        [_adObj release]; _adObj = nil;
    }
    
    self.title = @"Timeout";
}

- (void)stopTimer{
    if (_timer) {
        [_timer invalidate];    //隐性的[self release],如果此时self没有其他的引用，将进入dealloc，所以在stopTimer后再调用self即是对已经释放过的对象发送消息，造成崩溃
        [_timer release]; _timer = nil;
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
@end
