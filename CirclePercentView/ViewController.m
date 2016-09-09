//
//  ViewController.m
//  CirclePercentView
//
//  Created by 王亮 on 16/7/28.
//  Copyright © 2016年 王亮. All rights reserved.
//

#import "ViewController.h"
#import "CirclePercentView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CirclePercentView *circleView = [[CirclePercentView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-200)/2.0, (self.view.frame.size.height-200)/2.0, 200, 200)];
    circleView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:circleView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [circleView startPercentAnimationWithValue:0.62];
    });

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
