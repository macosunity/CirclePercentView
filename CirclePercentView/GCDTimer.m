//
//  GCDTimer.m
//  ZhiTong
//
//  Created by 王亮 on 16/7/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GCDTimer.h"

@implementation GCDTimer

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.isTiming = NO;
    }
    
    return self;
}

- (void)startTimerWithInterval:(NSTimeInterval)interval andDuration:(NSTimeInterval)duration whenTiming:(TimingBlock)timingBlock whenTimingFinish:(TimingBlock)timingFinishBlock {
    
    //设置时间间隔
    uint64_t waitInterval = interval * NSEC_PER_SEC;
    dispatch_queue_t waitQueue = dispatch_queue_create("globalTimer queue", 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, waitQueue);
    if (_timer) {
        __block NSTimeInterval timeDuration = duration;
        dispatch_source_set_timer(_timer, dispatch_walltime(DISPATCH_TIME_NOW, 0), waitInterval, 0);
        dispatch_source_set_event_handler(_timer, ^(void){
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                timeDuration = timeDuration-interval;
                if (timeDuration >= 0) {
                    self.isTiming = YES;
                    timingBlock(timeDuration);
                }
                else {
                    [self stopTimer];
                    timingFinishBlock(timeDuration);
                }
            });
        });
        dispatch_resume(_timer);
    }
}

- (void)stopTimer {
    if (self.isTiming) {
        self.isTiming = NO;
        dispatch_source_cancel(_timer);
    }
}

@end
