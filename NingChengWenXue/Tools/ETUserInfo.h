//
//  ETUserInfo.h
//  ETong_ios
//
//  Created by xiaocool on 16/7/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface ETUserInfo : NSObject
singleton_interface(ETUserInfo)
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *password;
@property (copy, nonatomic) NSString *usertype;
@property (copy, nonatomic) NSString *qq;
@property (copy, nonatomic) NSString *weixin;
@property (copy, nonatomic) NSString *photo;
@property (copy, nonatomic) NSString *from;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *shopid;
@property (copy, nonatomic) NSString *islocal;
@property (assign, nonatomic) BOOL isLogin;
@end
