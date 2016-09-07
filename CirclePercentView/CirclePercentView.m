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

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        for (int i=1; i<=100; i++) {
            
            CGFloat degreeValue = 58+((300-58)/100.0)*i;
            CGFloat currAngle = DEGREES_TO_RADIANS(degreeValue);
            CGFloat radiusWidth = self.bounds.size.width/2.0;
            CGFloat imageOffsetX = radiusWidth+radiusWidth*sinf(currAngle);
            CGFloat imageOffsetY = radiusWidth+radiusWidth*cosf(currAngle);
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
            imageView.frame = CGRectMake(imageOffsetX, imageOffsetY, 2, 14);
            imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-degreeValue));
            imageView.layer.allowsEdgeAntialiasing = YES;
            imageView.tag = 1000+i;
            [self addSubview:imageView];
            
            imageView.backgroundColor = [UIColor lightGrayColor];
        }

    }
    return self;
}

- (void)setPercentValue:(double)percentValue {
    
    int percentMaxValue = (int)(percentValue * 100);
    
    for (int i=1; i<=100; i++) {
        
        UIImageView *imageView = [self viewWithTag:1000+i];
        
        if (i <= (100-percentMaxValue)) {
            imageView.backgroundColor = [UIColor lightGrayColor];
        }
        else {
            imageView.backgroundColor = [UIColor redColor];
        }
    }
    
}
@end
