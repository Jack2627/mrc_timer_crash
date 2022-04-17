//
//  ViewController.m
//  M_TimerCrashDemo
//
//  Created by JackPersonal on 2022/4/17.
//

#import "ViewController.h"
#import "ShowAdViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    ShowAdViewController *vc = [[ShowAdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release]; vc = nil;
}

@end
