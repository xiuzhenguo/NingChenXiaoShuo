//
//  BCWelcomHepler.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/8.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ETBaseHelper.h"

@interface BCWelcomHepler : ETBaseHelper

/**
 *  发送验证码
 *  @param phoneNumber 手机号
 */
- (void)sendMobileCodeWithPhone:(NSString *)phoneNumber success:(ETResponseBlock)success
                          faild:(ETResponseErrorBlock) faild;

/**
 *  电话号登录
 *  @param phoneNum 手机号
 *  @param pwd      密码
 */
- (void)loginWithPhoneNumber:(NSString *)phoneNum
                    Code:(NSString *)code
                     success:(ETResponseBlock)success
                       faild:(ETResponseErrorBlock)faild;

/**
 *  帐号登录
 *  @param account 账号号
 *  @param password  密码
 */
-(void)loginWithAccount:(NSString *)account Password:(NSString *)password success:(ETResponseBlock)success faild:(ETResponseErrorBlock) faild;

/**
 *  帐号注册
 *  @param account 账号
 *  @param phone  手机号
 *  @param code 验证码
 *  @param password  密码
 */

-(void) registWithAccount:(NSString *)account Phone:(NSString *)phone Code:(NSString *)code Password:(NSString *)password success:(ETResponseBlock)success faild:(ETResponseErrorBlock) faild;

/**
 *  忘记密码
 *  @param UserName 用户名
 *  @param Phone  手机号
 *  @param Code 验证码
 *  @param NewPassword  新密码
 */
-(void) forgeterWithCode:(NSString *)code NewPassword:(NSString *)newPassword Phone:(NSString *)phone UserName:(NSString *)username success:(ETResponseBlock)success faild:(ETResponseErrorBlock) faild;

#pragma mark - 我的首页
/**
 *  我的首页
 *
 */
-(void)mineHomeInfoWithUserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  合成卡片集合
 *
 */
-(void)compoundCardListWithUserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  合成卡片
 *
 */
-(void)compoundCardWithUserId:(NSString *)userId CardId:(NSString *)cardId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  收件箱集合
 *
 */
-(void)receivedMessageBoxListWithUserId:(NSString *)userId PageIndex:(NSString *)pageIndex successs:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  收件箱详情
 *
 */
-(void)receivedMessageBoxDetailWithUserId:(NSString *)userId MsgId:(NSString *)msgId MsgGener:(NSInteger)msgGener success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  发件箱集合
 *
 */
-(void)sendMessageBoxListWithUserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  个人资料
 *
 */
-(void)minePersonInformationWithUserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  收件人集合
 *
 */
-(void)getReceivePersonListWithUserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  写信息、回复信息
 *
 */
-(void)wirteMessageWithUserId:(NSString *)userId ReceiveId:(NSString *)receiveId ReceiveName:(NSString *)receiveName MsgGene:(NSString *)msgGene Title:(NSString *)title Content:(NSString *)content success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;

/**
 *  发件箱详情
 *
 */
-(void)sendMessageDetailWithMsgId:(NSString *)msgId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;



@end
