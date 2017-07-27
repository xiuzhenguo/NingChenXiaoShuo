//
//  NCBookshelfHelper.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/23.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NCBookshelfHelper.h"

@implementation NCBookshelfHelper

#pragma mark - 书架集合
- (void)bookRackListWithUserid:(NSString *)userid PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userid":userid,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/bookrack/readlog",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"书架集合%@",task.currentRequest.URL);
        }else{
            [SVProgressHUD showErrorWithStatus:model.Message];
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(error.description,error);
        
    }];
}

#pragma mark - 收藏集合的数据获取
- (void)collectionListWithUserid:(NSString *)userid PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userid":userid,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/bookrack/item",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"收藏集合%@",task.currentRequest.URL);
        }else{
            [SVProgressHUD showErrorWithStatus:model.Message];
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(error.description,error);
        
    }];
}

#pragma mark - 添加、移除收藏小说
- (void)removeNovelWithFictionId:(NSString *)fictionId UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    
    NSDictionary *para = @{@"fictionId":fictionId,@"userId":userId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/bookrack/item/addorremove",kBaseURL];
    
    [self.manager POST:netPath parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
        }else{
            [SVProgressHUD showErrorWithStatus:model.Message];
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        faild("")
    }];
}


@end
