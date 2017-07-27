//
//  NCWriteHelper.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/6.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ETBaseHelper.h"

@interface NCWriteHelper : ETBaseHelper

#pragma mark - 作品
/**
 *  作品集合
 *
 */
-(void)productionWithAuthorid:(NSString *)authorid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  作品信息
 *
 */
-(void)productionMessageWithFictionId:(NSString *)fictionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  章节列表
 *
 */
-(void)novelSectionListWithFictionId:(NSString *)fictionId pageIndex:(NSString *)pageIndex success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;


/**
 *  作品名字修改
 *
 */
-(void)changeNovelNameWithFictionId:(NSString *)fictionId FictionName:(NSString *)fictionName success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  代表作修改
 *
 */
-(void)daiBiaoZuoWithFictionId:(NSString *)fictionId UserId:(NSString *)userId Q:(NSString *)q success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  作品简介修改
 *
 */
-(void)novelIntroWithFictionId:(NSString *)fictionId Intro:(NSString *)intro success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  作品标签修改
 *
 */
-(void)novelShuXingWithFictionId:(NSString *)fictionId Key:(NSString *)key Category:(NSInteger)category success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  作品属性修改
 *
 */
-(void)changeNovelShuXingWithFictionId:(NSString *)fictionId Q:(NSString *)q success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  作品状态修改
 *
 */
-(void)changeNovelStatusWithFictionId:(NSString *)fictionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  发布章节
 *
 */
-(void)publishNovelSectionWithSectionId:(NSString *)sectionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  签约条件
 *
 */
-(void)signConditionWithFictionId:(NSString *)fictionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  申请签约
 *
 */
-(void)applySignNovelWithFictionId:(NSString *)fictionId AuthorId:(NSString *)authorId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

#pragma mark - 征文
/**
 *  征文集合
 *
 */
-(void)getZhengWenListWithPageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

@end
