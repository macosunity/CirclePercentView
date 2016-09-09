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
    
    CAIndexedLayer *_containerLayer;
    UILabel *_percentLabel;
}

@end

@implementation CirclePercentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
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
        
        CGFloat percentFontSize = 45;
        _percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, percentFontSize)];
        _percentLabel.font = [UIFont systemFontOfSize:percentFontSize];
        _percentLabel.textAlignment = NSTextAlignmentCenter;
        _percentLabel.textColor = [UIColor blueColor];
        _percentLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_percentLabel];
        _percentLabel.center = CGPointMake(_percentLabel.center.x, 63.5+percentFontSize/2.0);
        
        [self setPercentValue:0.0];
    }
    return self;
}

- (void)setPercentValue:(double)percentValue {
    
    int percentMaxValue = (int)(percentValue * 100);
    
    NSString *percentString = [NSString stringWithFormat:@"%d%%", percentMaxValue];
    _percentLabel.attributedText = [self generateAttributeString:percentString fontSize:45];
}

- (NSAttributedString *)generateAttributeString:(NSString *)srcString fontSize:(CGFloat)fontSize {
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:srcString];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, srcString.length)];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, srcString.length-1)];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(srcString.length-1, 1)];
    
    return attributeString;
}

- (void)resetPercentToZero {
    
    for (int i=1; i<=100; i++) {
        CAIndexedLayer *imageLayer = (CAIndexedLayer *)[_containerLayer layerWithIndex:i];
        imageLayer.contents = (id)[UIImage imageNamed:IMAGE_NAME_GRAY].CGImage;
        NSString *percentString = [NSString stringWithFormat:@"0%%"];
        _percentLabel.attributedText = [self generateAttributeString:percentString fontSize:45];
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
        
        GCDTimer *timer = [[GCDTimer alloc] init];
        //double计算后转成int的精度有问题，所以需要 +0.01
        int percentMaxValue = (int)(percentValue * 100 + 0.01);
        
        __block int layerIndex = 0;
        [timer startTimerWithInterval:0.02 andDuration:3 whenTiming:^(NSTimeInterval leftTime) {
            
            if (layerIndex < percentMaxValue) {
                CAIndexedLayer *imageLayer = (CAIndexedLayer *)[_containerLayer layerWithIndex:(100-layerIndex)-1];
                imageLayer.contents = (id)[UIImage imageNamed:IMAGE_NAME_PERCENT].CGImage;
                ++layerIndex;
                NSString *percentString = [NSString stringWithFormat:@"%d%%", layerIndex];
                _percentLabel.attributedText = [self generateAttributeString:percentString fontSize:45];
            }
            else {
                [timer stopTimer];
            }
        } whenTimingFinish:^(NSTimeInterval leftTime) {
            
        }];
    });
}

@end
