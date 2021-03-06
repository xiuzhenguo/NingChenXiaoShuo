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

#pragma mark - 获取验证码
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

#pragma mark - 电话号码登录
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

#pragma mark - 账号登录
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

#pragma mark - 账号注册
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

#pragma mark - 忘记密码
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
            NSLog(@"我的首页%@",task.currentRequest.URL);
        }else{
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 合成卡片集合
-(void)compoundCardListWithUserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/author/info/card/compound/list",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"合成卡片集合%@",task.currentRequest.URL);
        }else{
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil, nil);
    }];
}

#pragma mark - 合成卡片
-(void)compoundCardWithUserId:(NSString *)userId CardId:(NSString *)cardId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"cardId":cardId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/author/info/card/compound",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 收件箱集合
- (void)receivedMessageBoxListWithUserId:(NSString *)userId PageIndex:(NSString *)pageIndex successs:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/messsage/consignee",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"收件箱集合%@",task.currentRequest.URL);
        }else{
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 收件箱详情
- (void)receivedMessageBoxDetailWithUserId:(NSString *)userId MsgId:(NSString *)msgId MsgGener:(NSInteger)msgGener SendId:(NSString *)sendId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"msgId":msgId,@"msgGener":@(msgGener),@"sendId":sendId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/messsage/consignee/info",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"收件箱详情%@",task.currentRequest.URL);
        }else{
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 发件箱集合
- (void)sendMessageBoxListWithUserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/messsage/outbox",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"发件箱集合%@",task.currentRequest.URL);
        }else{
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 个人资料的获取
- (void)minePersonInformationWithUserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/mine/home/Personal",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"个人资料%@",task.currentRequest.URL);
        }else{
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 收件人集合
- (void)getReceivePersonListWithUserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/messsage/find/users",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"shoujianren集合%@",task.currentRequest.URL);
        }else{
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 写信息、回复信息
- (void)wirteMessageWithUserId:(NSString *)userId ReceiveId:(NSString *)receiveId ReceiveName:(NSString *)receiveName MsgGene:(NSString *)msgGene Title:(NSString *)title Content:(NSString *)content success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"receiveId":receiveId,@"receiveName":receiveName,@"msgGener":msgGene,@"title":title,@"content":content};
    NSString *netPath = [NSString stringWithFormat:@"%@api/messsage/user/send",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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

#pragma mark - 发件箱详情
- (void)sendMessageDetailWithMsgId:(NSString *)msgId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"msgId":msgId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/messsage/outbox/info",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"发件箱详情%@",task.currentRequest.URL);
        }else{
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 性别修改
- (void)changeMineSexWithUserId:(NSString *)userId UserSex:(NSString *)userSex success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"userSex":userSex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/mine/home/sex",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 名字修改
- (void)changeMineNameWithUserId:(NSString *)userId UserName:(NSString *)userName success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"userName":userName};
    NSString *netPath = [NSString stringWithFormat:@"%@api/mine/home/name",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 个性签名修改
- (void)changeMineSignWithUserId:(NSString *)userId UserSign:(NSString *)userSign success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"userSign":userSign};
    NSString *netPath = [NSString stringWithFormat:@"%@api/mine/home/sign",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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

#pragma mark - 生日修改
-(void)changeMineBirthdayWithUserId:(NSString *)userId UserBirthday:(NSString *)userBirthday success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"userBirthday":userBirthday};
    NSString *netPath = [NSString stringWithFormat:@"%@api/mine/home/birthday",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}


#pragma mark - 商城首页轮播图
-(void)getLunBoPictureWithSuccess:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = [[NSDictionary alloc] init];
    NSString *netPath = [NSString stringWithFormat:@"%@api/shop/CirFic",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"商城轮播图%@",task.currentRequest.URL);
        }else{
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 商城首页商品
-(void)getShopProductListWithType:(NSString *)type PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"type":type,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/shop/Product",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"商城首页商品%@",task.currentRequest.URL);
        }else{
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

@end
