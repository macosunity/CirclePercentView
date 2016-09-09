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

/**
 *  设置百分比
 *
 *  @param percentValue 要显示的百分比(0.00 ~ 1.00之间的两位小数)
 */
- (void)setPercentValue:(double)percentValue;


/**
 *  开始百分比动画
 *
 *  @param percentValue 要显示的百分比(0.00 ~ 1.00之间的两位小数)
 */
- (void)startPercentAnimationWithValue:(double)percentValue;

//结束百分比动画
- (void)stopPercentAnimation;

@end
