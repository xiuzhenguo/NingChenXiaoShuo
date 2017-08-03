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
 *  定时发布章节
 *
 */
-(void)dingShiPublishSectionWithSectionId:(NSString *)sectionId FictionId:(NSString *)FictionId UserId:(NSString *)UserId PublishTime:(NSString *)PublishTime success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

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

/**
 *  签约失败原因
 *
 */
-(void)faileApplySignNovelWithFictionId:(NSString *)fictionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  删除作品
 *
 */
-(void)deleteNovelWithFictionId:(NSString *)fictionId AuthorId:(NSString *)authorId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  删除章节
 *
 */
-(void)removeNovelSectionWithFictionId:(NSString *)fictionId SectionId:(NSString *)sectionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  预览章节
 *
 */
-(void)PreviewNovelSectionWithSectionid:(NSString *)sectionid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  新建章节
 *
 */
-(void)createNewNovelSectionWithFictionId:(NSString *)fictionId Title:(NSString *)title Content:(NSString *)content Remark:(NSString *)remark success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  修改章节
 *
 */
-(void)changeNovelSectionContentWithFictionId:(NSString *)fictionId SectionId:(NSString *)sectionId Title:(NSString *)title Content:(NSString *)content Remark:(NSString *)Remark success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

#pragma mark - 征文
/**
 *  征文集合
 *
 */
-(void)getZhengWenListWithPageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  征文详情
 *
 */
-(void)zhengWenDetailWithID:(NSString *)Id UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  征文作品
 *
 */
-(void)callForPapersListWithSolicitationId:(NSString *)SolicitationId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  获奖作品
 *
 */
-(void)AwardsNovelWithSolicitationId:(NSString *)solicitationId success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  可投小说
 *
 */
-(void)canTouNovelWithSolicitationId:(NSString *)SolicitationId UserId:(NSString *)userId success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  投递小说
 *
 */
-(void)DeliveryNovelWithSolicitationId:(NSString *)solicitationId UserId:(NSString *)userId FictionId:(NSString *)fictionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  退出征文
 *
 */
-(void)tuiChuCallForPapersWithID:(NSString *)Id SolicitationId:(NSString *)solicitationId UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

@end
