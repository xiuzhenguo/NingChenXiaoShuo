//
//  ETTimeManager.h
//  ETong_ios
//
//  Created by xiaocool on 16/7/26.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ETTimerHandle)(NSInteger timeInterVal);

@interface ETTimeManager : NSObject
singleton_interface(ETTimeManager)
@property (strong, nonatomic) NSMutableDictionary *taskDic;

/**
 *  计时器管理类开始计时
 *
 *  @param key           任务标示
 *  @param interval      时间
 *  @param processHandle 倒计时回调
 *  @param finshHandle   结束回调
 */
- (void)beginTimeTaskWithOwner:(id)owner Key:(NSString *)key timeInterval:(NSInteger)interval process:(ETTimerHandle)processHandle finish:(ETTimerHandle)finshHandle;
@end

@interface ETTimeTask : NSObject

- (instancetype)configureTaskWithOwner:(id)owner Key:(NSString *)key timeIntaval:(NSInteger)intaval process:(ETTimerHandle)processHandle finish:(ETTimerHandle)finishHandle;
/**
 *  配置时间任务
 *
 *  @param owner         持有任务对象
 *  @param processHandle 计时回调
 *  @param finishHandle  结束回调
 */
- (void)setTaskWithOwner:(id)owner process:(ETTimerHandle)processHandle finish:(ETTimerHandle)finishHandle;
@end
