//
//  GCDTimer.h
//  ZhiTong
//
//  Created by 王亮 on 16/7/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TimingBlock)(NSTimeInterval leftTime);

@interface GCDTimer : NSObject {
    dispatch_source_t _timer;
}

@property (nonatomic, assign) BOOL isTiming;

- (void)startTimerWithInterval:(NSTimeInterval)interval andDuration:(NSTimeInterval)duration whenTiming:(TimingBlock)timingBlock whenTimingFinish:(TimingBlock)timingFinishBlock;

- (void)stopTimer;

@end
