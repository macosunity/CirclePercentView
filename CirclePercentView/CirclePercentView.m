//
//  CirclePercentView.m
//  ZhiTong
//
//  Created by 王亮 on 16/7/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CirclePercentView.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation CirclePercentView

- (instancetype)initWithFrame:(CGRect)frame andPercentValue:(double)percentValue {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        int percentMaxValue = (int)(percentValue * 100);
        
        for (int i=0; i<100; i++) {
            
            CGFloat degreeValue = 60+((300-60)/100.0)*i;
            CGFloat currAngle = DEGREES_TO_RADIANS(degreeValue);
            CGFloat imageOffsetX = self.frame.size.width/2.0+self.frame.size.width/2.0*sinf(currAngle);
            CGFloat imageOffsetY = self.frame.size.width/2.0+self.frame.size.width/2.0*cosf(currAngle);
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
            imageView.frame = CGRectMake(imageOffsetX, imageOffsetY, 2, 14);
            imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-degreeValue));
            imageView.layer.allowsEdgeAntialiasing = YES;
            [self addSubview:imageView];
            
            if (i <= (100-percentMaxValue)) {
                imageView.backgroundColor = [UIColor blueColor];
            }
            else {
                imageView.backgroundColor = [UIColor redColor];
            }
        }
    }
    return self;
}

@end
