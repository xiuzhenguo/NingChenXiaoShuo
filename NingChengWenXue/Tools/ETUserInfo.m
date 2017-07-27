//
//  ETUserInfo.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETUserInfo.h"

@implementation ETUserInfo

singleton_implementation(ETUserInfo)
-(void)setId:(NSString *)Id{
    if(Id&&Id.length > 0)
    _isLogin = true;
    _Id = Id;
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"Id" : @"id",
             };
}

//- (void)setName:(NSString *)name{
//    
//    
//}
//
//- (void)setPhoto:(NSString *)photo{
//    
//}

//- (BOOL)isLogin{
//    return [[NSUserDefaults standardUserDefaults] boolForKey:@"login"];
//}
//- (NSString *)name{
//    return [[NSUserDefaults standardUserDefaults] stringForKey:USERNAME];
//}


//- (NSString *)photo{
//    return [[NSUserDefaults standardUserDefaults]stringForKey:USER_PHOTO];
//}

@end
