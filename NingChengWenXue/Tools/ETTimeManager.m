//
//  ETTimeManager.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/26.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETTimeManager.h"
@implementation ETTimeManager
singleton_implementation(ETTimeManager)

-(NSMutableDictionary *)taskDic{
    if (!_taskDic) {
        _taskDic = [NSMutableDictionary dictionary];
    }
    return _taskDic;
}
- (void)beginTimeTaskWithOwner:(id)owner Key:(NSString *)key timeInterval:(NSInteger)interval process:(ETTimerHandle)processHandle finish:(ETTimerHandle)finshHandle;{
    if (self.taskDic[key]) {
        [self.taskDic[key] setTaskWithOwner:owner process:processHandle finish:finshHandle];
        return;
    }
    self.taskDic[key] = [[[ETTimeTask alloc]init] configureTaskWithOwner:owner Key:key timeIntaval:interval process:processHandle finish:finshHandle];
}
@end

@interface ETTimeTask()

@property (strong, nonatomic) NSString *key;
@property (weak,nonatomic) id taskOwner;
@property (strong, nonatomic) ETTimerHandle pHandle;
@property (strong, nonatomic) ETTimerHandle fHandle;
@property (assign, nonatomic) NSInteger leftTime;
@property (assign, nonatomic) NSInteger totolTime;
@property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundID;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ETTimeTask

- (instancetype)configureTaskWithOwner:(id)owner Key:(NSString *)key timeIntaval:(NSInteger)intaval process:(ETTimerHandle)processHandle finish:(ETTimerHandle)finishHandle;{
    self.key = key;
    self.taskOwner = owner;
    self.totolTime = intaval;
    self.leftTime = intaval;
    self.pHandle = processHandle;
    self.fHandle = finishHandle;
    self.backgroundID = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(sendHandle) userInfo:nil repeats:true];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    return self;
}
- (void)setTaskWithOwner:(id)owner process:(ETTimerHandle)processHandle finish:(ETTimerHandle)finishHandle;{
    self.taskOwner = owner;
    self.pHandle = processHandle;
    self.fHandle = finishHandle;
}
- (void) sendHandle{
    _leftTime -= 1;
    if (!_taskOwner) {
        _pHandle = nil;
        _fHandle = nil;
        return;
    }
    if (_leftTime>0) {
        
        if (_pHandle != nil) {
            _pHandle(_leftTime);
        }
    }else{
        [_timer invalidate];
        [[ETTimeManager sharedETTimeManager].taskDic removeObjectForKey:_key];
        if (_fHandle) {
            _fHandle(0);
        }
    }
}
@end