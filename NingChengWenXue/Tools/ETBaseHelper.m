//
//  ETBaseHelper.m
//  ETong_ios
//
//  Created by xiaocool on 16/7/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

#import "ETBaseHelper.h"

@implementation ETBaseHelper

+(instancetype)helper;{
    return [[self alloc]init];
}

-(instancetype)init{
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    }
    return self;
}
//- (void)updataUserInfo:(ETResponseBlock)handle;{
//    NSDictionary *para = @{@"a":@"getuserinfo",@"userid":[ETUserInfo sharedETUserInfo].Id};
//    [self.manager GET:kURL_HEAD parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
//        if ([model.status isEqualToString:@"success"]) {
//            [ETUserInfo mj_objectWithKeyValues:model.data];
//        }
//        handle(nil);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//         handle(nil);
//    }];
//
//}
@end
