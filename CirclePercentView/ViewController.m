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
    
    CirclePercentView *view = [[CirclePercentView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-200)/2.0, (self.view.frame.size.height-200)/2.0, 200, 200) andPercentValue:0.95];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
