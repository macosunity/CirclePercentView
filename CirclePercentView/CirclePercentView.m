//
//  CirclePercentView.m
//  ZhiTong
//
//  Created by 王亮 on 16/7/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CirclePercentView.h"
#import "GCDTimer.h"

#define IMAGE_NAME_GRAY             @"gray"
#define IMAGE_NAME_PERCENT          @"percent"
#define DEGREES_TO_RADIANS(angle)   ((angle) / 180.0 * M_PI)

@interface CAIndexedLayer : CALayer

@property (nonatomic,assign) NSUInteger index;

- (CAIndexedLayer *)layerWithIndex:(NSUInteger)index;

@end


@implementation CAIndexedLayer

- (CALayer *)layerWithIndex:(NSUInteger)index {
    
    if (index >= [self.sublayers count]) {
        return nil;
    }
    
    return self.sublayers[index];
}

@end

@interface CirclePercentView() {
    
    GCDTimer *_timer;
    CAIndexedLayer *_containerLayer;
}

@end

@implementation CirclePercentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _timer = [[GCDTimer alloc] init];
        _containerLayer = [[CAIndexedLayer alloc] init];
        
        for (int i=1; i<=100; i++) {
            
            CGFloat degreeValue = 58+((300-58)/100.0)*i;
            CGFloat currAngle = DEGREES_TO_RADIANS(degreeValue);
            CGFloat radiusWidth = self.bounds.size.width/2.0;
            CGFloat imageOffsetX = radiusWidth+radiusWidth*sinf(currAngle);
            CGFloat imageOffsetY = radiusWidth+radiusWidth*cosf(currAngle);
            
            CAIndexedLayer *imageLayer = [[CAIndexedLayer alloc] init];
            imageLayer.anchorPoint = CGPointMake(0.5, 0.5);
            imageLayer.frame = CGRectMake(imageOffsetX, imageOffsetY, 2, 14);
            imageLayer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(-degreeValue), 0, 0, 1);
            imageLayer.allowsEdgeAntialiasing = YES;
            imageLayer.index = i;
            imageLayer.contents = (id)[UIImage imageNamed:IMAGE_NAME_GRAY].CGImage;
            
            [_containerLayer addSublayer:imageLayer];
        }
        
        [self.layer addSublayer:_containerLayer];
    }
    return self;
}

- (void)resetPercentToZero {
    
    for (int i=1; i<=100; i++) {
        CAIndexedLayer *imageLayer = (CAIndexedLayer *)[_containerLayer layerWithIndex:i];
        imageLayer.contents = (id)[UIImage imageNamed:IMAGE_NAME_GRAY].CGImage;
    }
}

//开始百分比动画
- (void)startPercentAnimationWithValue:(double)percentValue {
    
    //只有百分比大于0时才做动画
    if (! (percentValue > 0.0) ) {
        return;
    }
    
    [self resetPercentToZero];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        int percentMaxValue = (int)(percentValue * 100);
        
        __block int count = 100;
        __block int step = 3;
        __block int layerIndex = 0;
        [_timer startTimerWithInterval:0.02 andDuration:2 whenTiming:^(NSTimeInterval leftTime) {
            if (layerIndex <= percentMaxValue) {
                CAIndexedLayer *imageLayer = (CAIndexedLayer *)[_containerLayer layerWithIndex:(100-layerIndex)];
                imageLayer.contents = (id)[UIImage imageNamed:IMAGE_NAME_PERCENT].CGImage;
                ++layerIndex;
            }
            else {
                [_timer stopTimer];
            }
            count -= step;
        } whenTimingFinish:^(NSTimeInterval leftTime) {
            
        }];
    });
}


//结束百分比动画
- (void)stopPercentAnimation {
    [_timer stopTimer];
}

@end
