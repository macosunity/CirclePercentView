//
//  CirclePercentView.h
//  ZhiTong
//
//  Created by 王亮 on 16/7/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CirclePercentView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

//开始百分比动画
- (void)startPercentAnimationWithValue:(double)percentValue;

//结束百分比动画
- (void)stopPercentAnimation;

@end
