//
//  BCWelcomHepler.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/8.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "BCWelcomHepler.h"
#import "MD5.h"

@implementation BCWelcomHepler

// 获取验证码
- (void)sendMobileCodeWithPhone:(NSString *)phoneNumber success:(ETResponseBlock)success
                          faild:(ETResponseErrorBlock) faild;{
    NSString *netPath = [NSString stringWithFormat:@"%@api/user/verification",kBaseURL];
    [self.manager GET:netPath parameters:@{@"phone":phoneNumber} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(responseObject);
            NSLog(@"%@",model.datas);
        }else{
            
            faild(@"",nil);
            NSLog(@"23456765432");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(error.description,error);
        NSLog(@"aaaaaaa");
    }];
    
    NSLog(@"%@",phoneNumber);
}

// 电话号码登录
- (void)loginWithPhoneNumber:(NSString *)phoneNum Code:(NSString *)code success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild;{

    NSString *sign = [NSString stringWithFormat:@"partner=jj123abcws&code=%@&phone=%@nc456wx",code,phoneNum];
    
    sign = [MD5 md5FromString:sign];
    
    NSLog(@"加密%@",sign);
    
    NSString *url = [NSString stringWithFormat:@"%@api/user/login/phone?partner=jj123abcws&sign=%@",kBaseURL,sign];
    NSLog(@"%@",url);
    
    NSDictionary *para = @{@"phone":phoneNum,@"code":code};
    [self.manager POST:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
            success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(error.description,nil);
    }];
}

// 账号登录
- (void)loginWithAccount:(NSString *)account Password:(NSString *)password success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild {
    NSString *sign = [NSString stringWithFormat:@"partner=jj123abcws&account=%@&password=%@nc456wx",account,password];

    sign = [MD5 md5FromString:sign];
    
    NSLog(@"加密%@",sign);
    
    NSString *url = [NSString stringWithFormat:@"%@api/user/login?partner=jj123abcws&sign=%@",kBaseURL,sign];
    NSLog(@"%@",url);
    
    NSDictionary *para = @{@"account":account,@"password":password};
    [self.manager POST:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(error.description,nil);
    }];
}

// 账号注册
- (void)registWithAccount:(NSString *)account Phone:(NSString *)phone Code:(NSString *)code Password:(NSString *)password success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{

    NSString *sign = [NSString stringWithFormat:@"partner=jj123abcws&account=%@&code=%@&password=%@&phone=%@nc456wx",account,code,password,phone];
    
    sign = [MD5 md5FromString:sign];
    
    NSLog(@"加密%@",sign);
    
    NSString *url = [NSString stringWithFormat:@"%@api/user/register?partner=jj123abcws&sign=%@",kBaseURL,sign];
    NSLog(@"%@",url);
    
    NSDictionary *para = @{@"account":account,@"phone":phone,@"code":code,@"password":password};
    [self.manager POST:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(error.description,nil);
    }];
}

// 忘记密码
- (void)forgeterWithCode:(NSString *)code NewPassword:(NSString *)newPassword Phone:(NSString *)phone UserName:(NSString *)username success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSString *sign = [NSString stringWithFormat:@"partner=jj123abcws&Code=%@&NewPassword=%@&Phone=%@&UserName=%@nc456wx",code,newPassword,phone,username];
    
    sign = [MD5 md5FromString:sign];
    
    NSLog(@"加密%@",sign);
    
    NSString *url = [NSString stringWithFormat:@"%@api/user/updatePwd?partner=jj123abcws&sign=%@",kBaseURL,sign];
    NSLog(@"%@",url);
    
    NSDictionary *para = @{@"Code":code,@"NewPassword":newPassword,@"Phone":phone,@"UserName":username};
    [self.manager POST:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(error.description,nil);
    }];
}

#pragma mark - 我的首页
-(void)mineHomeInfoWithUserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/mine/home/info",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
        }else{
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

@end
