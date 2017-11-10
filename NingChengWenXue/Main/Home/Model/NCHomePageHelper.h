//
//  NCHomePageHelper.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/9.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ETBaseHelper.h"

@interface NCHomePageHelper : ETBaseHelper

/**
 *  举报
 *
 */
-(void) juBaoWithObjType:(NSString *)ObjType ObjId:(NSString *)ObjId ObjClass:(NSString *)ObjClass UserId:(NSString *)UserId OptionId:(NSString *)OptionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  系统消息的获取
 *
 */

-(void)SysMessageWithSuccess:(ResponseBlock)success faild:(ETResponseErrorBlock) faild;

/**
 *  书籍推荐与排行榜的获取
 *
 */

-(void)recommendAndRankListWithSuccess:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  首页轮播图的获取
 *
 */
-(void)CarouselPictrueWithSuccess:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  订阅小说的获取
 *
 */
-(void)subscribeNovelWithId:(NSString *)Id KeyClass:(NSString *)keyClass Sex:(NSString *)sex PageIndex:(NSString *)pageIndex Success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  更多类别小说的获取
 *
 */
-(void)fictionListWithGener:(NSString *)gener PageIndex:(NSString *)pageIndex Success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  订阅类别
 *
 */
-(void)getAllGenerWithUserId:(NSString *)userId Success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  偏好类型设置
 *
 */
-(void)userPreferSetWithId:(NSString *)Id KeyClass:(NSString *)keyClass Sex:(NSString *)sex Success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  搜索默认小说名获取
 *
 */
-(void)hotdefaultWithSuccess:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  热门搜索的数据获取
 *
 */
-(void)hotsearchWithSuccess:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  搜索的数据获取
 *
 */
-(void)searchWithInputText:(NSString *)inputText PageIndex:(NSString *)pageIndex success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  搜索小说的数据获取
 *
 */
-(void)searchFictionWithInputText:(NSString *)inputText PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;
/**
 *  排行榜的数据获取
 *
 */
-(void)rankingListWithType:(NSString *)type flag:(NSString *)flag pageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  小说分类的数据获取
 *
 */
-(void)generWithsuccess:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  分类小说列表的数据获取
 *
 */
-(void)generNovelListWithGener:(NSString *)gener orderby:(NSString *)orderby pageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  超精华小说列表的数据获取
 *
 */
-(void)chaojinghuaListWithUserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;


/**
 *  推荐小说列表的数据获取
 *
 */
-(void)chaojinghuaListWithUserId:(NSString *)userId Status:(NSString *)status PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  小说详情信息的数据获取
 *
 */
-(void)novelDetailFictionWithID:(NSString *)Id UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  小说点赞功能
 *
 */
-(void)novelClickZanWithFictionId:(NSString *)fictionId UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  小说目录的数据获取
 *
 */
-(void)novelMuluListWithID:(NSString *)Id UserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  直接点击阅读
 *
 */
-(void)clickReadNovelWithFictionId:(NSString *)fictionId UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  小说内容的获取
 *
 */
-(void)getNovelContentWithSectionId:(NSString *)sectionId UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  记录阅读章节
 *
 */
-(void)RecordsNovelSectionWithFictionId:(NSString *)fictionId SectionId:(NSString *)sectionId UserId:(NSString *)userId TextLength:(NSString *)textLength success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  小说章节书评列表的数据获取
 *
 */
-(void)sectionNovelPinglunListWithFictionId:(NSString *)fictionId SectionId:(NSString *)sectionId UserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  小说全部书评列表的数据获取
 *
 */
-(void)allNovelPinglunListWithFictionId:(NSString *)fictionId UserId:(NSString *)userId Flag:(NSString *)flag PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  书评点赞功能
 *
 */
-(void)clickShuPingWithPostId:(NSString *)postId UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  添加书评
 *
 */
-(void)addShuPingWithFictionId:(NSString *)fictionId UserId:(NSString *)userId SectionId:(NSString *)sectionId Content:(NSString *)Content success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  书评信息详情
 *
 */
-(void)shuPingDetailWithId:(NSString *)Id UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  书评回复列表
 *
 */
-(void)replyShuPingListWithID:(NSString *)ID PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  回复书评
 *
 */
-(void)replyShuPingWithUserId:(NSString *)userId ReplyId:(NSString *)replyId PostId:(NSString *)postId Content:(NSString *)content success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

#pragma mark - 作者页
/**
 *  作者详情
 *
 */
-(void)autherDetailWithID:(NSString *)ID UserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  作者作品集合
 *
 */
-(void)autherNovelListWithID:(NSString *)Id PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  作者动态集合
 *
 */
-(void)autherDongTaiListWithID:(NSString *)Id PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  作者个人资料
 *
 */
-(void)autherPersonWithAnthorId:(NSString *)anthorId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  粉丝集合
 *
 */
-(void)fansWithUserId:(NSString *)userId AuthorId:(NSString *)authorId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  关注集合
 *
 */
-(void)attionWithUserId:(NSString *)userId AuthorId:(NSString *)authorId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  留言集合
 *
 */
-(void)leacveYanWithUserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  留言详情
 *
 */
-(void)leaveMessageDetailWithLeaveId:(NSString *)leaveId PageIndex:(NSString *)pageIndex success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  添加留言
 *
 */
-(void)AddleacveYanWithUserId:(NSString *)userId LeaveUserId:(NSString *)leaveUserId Content:(NSString *)content success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  回复留言
 *
 */
-(void)replyLeaveMessageWithUserId:(NSString *)userId ReplyId:(NSString *)replyId LeaveId:(NSString *)leaveId Content:(NSString *)content success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  用户卡片集合
 *
 */
-(void)userCardsWithUserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

#pragma mark - 校园联盟
/**
 *  校园联盟首页的数据获取
 *
 */
-(void)communityHomeWithPageIndex:(NSString *)pageIndex userId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  校园联盟搜索的数据获取
 *
 */
-(void)communitySearchWithInputstring:(NSString *)inputstring pageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  社团信息详情的数据获取
 *
 */
-(void)communityDetailWithID:(NSString *)ID userId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  社团信息-资料的数据获取
 *
 */
-(void)communityDataWithID:(NSString *)ID success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  查看是否已加入社团
 *
 */
-(void)checkjoinCommunityWithUserid:(NSString *)userid Commid:(NSString *)commid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  申请加入社团
 *
 */
-(void)applyjoinCommunityWithUserId:(NSString *)UserId CommunityId:(NSString *)CommunityId QQ:(NSString *)QQ Year:(NSString *)Year Name:(NSString *)Name Reason:(NSString *)Reason success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  取消申请加入社团
 *
 */
-(void)CancelApplyCommunityWithUserId:(NSString *)userId CommunityId:(NSString *)communityId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  社团作品的数据获取
 *
 */
-(void)getCommunityNovelWithID:(NSString *)ID Inputstring:(NSString *)inputstring PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  社团成员的数据获取
 *
 */
-(void)getCommunityPersonWithID:(NSString *)ID UserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  关注好友
 *
 */
-(void)attentionUserWithUserId:(NSString *)UserId AppentionId:(NSString *)AppentionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  创建社团
 *
 */
-(void)createCommunityWithuserId:(NSString *)userId schoolName:(NSString *)schoolName communitIntro:(NSString *)communitIntro email:(NSString *)email address:(NSString *)address  wechat:(NSString *)wechat quantity:(NSString *)quantity introduceName:(NSString *)introduceName presidentName:(NSString *)presidentName phone:(NSString *)phone qq:(NSString *)qq teacher:(NSString *)teacher communityName:(NSString *)communityName success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  社团创建失败原因
 *
 */
-(void)createCmomunityFaildWithID:(NSString *)ID success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  获取我的社团
 *
 */
-(void)getMineCommunityWithUserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  设置社团成员角色
 *
 */
-(void)shezhiCommunityRoleWithUserId:(NSString *)userId CommunityId:(NSString *)communityId OptionId:(NSString *)optionId Role:(NSString *)role success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  移除社团成员
 *
 */
-(void)removeCommunityPersonWithUserId:(NSString *)userId  CommunityId:(NSString *)communityId OptionId:(NSString *)optionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

#pragma mark- 版本判断
-(void)changeIDWithType:(NSString *)type success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;


@end
