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


@end
