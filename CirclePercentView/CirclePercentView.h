//
//  CirclePercentView.h
//  ZhiTong
//
//  Created by 王亮 on 16/7/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CirclePercentView : UIView

/**
 *  初始化CirclePercentView
 *
 *  @param frame        CirclePercentView的frame
 *  @param percentValue 要显示的百分比(0.0 ~ 1.0之间)
 *
 *  @return CirclePercentView实例
 */
- (instancetype)initWithFrame:(CGRect)frame andPercentValue:(double)percentValue;

@end
