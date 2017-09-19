//
//  NCHomePageHelper.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/9.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NCHomePageHelper.h"

@implementation NCHomePageHelper

#pragma mark - 举报
- (void)juBaoWithObjType:(NSString *)ObjType ObjId:(NSString *)ObjId ObjClass:(NSString *)ObjClass UserId:(NSString *)UserId OptionId:(NSString *)OptionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"ObjType":ObjType,@"ObjId":ObjId,@"ObjClass":ObjClass,@"UserId":UserId,@"OptionId":OptionId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/report/obj",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 系统消息的获取
- (void)SysMessageWithSuccess:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters =[[NSDictionary alloc] init];
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/home/SysMessage",kBaseURL];
    
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 书籍推荐与排行榜的获取
- (void)recommendAndRankListWithSuccess:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = [[NSDictionary alloc] init];
    NSString *netPath = [NSString stringWithFormat:@"%@api/home/recommend/ficRank",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 首页轮播图的获取
- (void)CarouselPictrueWithSuccess:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = [[NSDictionary alloc] init];
    NSString *netPath = [NSString stringWithFormat:@"%@api/home/CirFic",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"首页轮播图%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 订阅小说的获取
- (void)subscribeNovelWithId:(NSString *)Id KeyClass:(NSString *)keyClass Sex:(NSString *)sex PageIndex:(NSString *)pageIndex Success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"Id":Id,@"KeyClass":keyClass,@"Sex":sex,@"PageIndex":pageIndex};

    NSString *netPath = [NSString stringWithFormat:@"%@api/home/UserPreferFic",kBaseURL];
    NSLog(@"%@",netPath);
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"订阅小说%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 更多类别小说的获取
- (void)fictionListWithGener:(NSString *)gener PageIndex:(NSString *)pageIndex Success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"gener":gener,@"PageIndex":pageIndex};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/gener/fictionlist",kBaseURL];
    NSLog(@"%@",netPath);
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"更多类别%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 订阅类别
- (void)getAllGenerWithUserId:(NSString *)userId Success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/Gener/getAllGener",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"订阅%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 偏爱类型设置
- (void)userPreferSetWithId:(NSString *)Id KeyClass:(NSString *)keyClass Sex:(NSString *)sex Success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"Id":Id,@"KeyClass":keyClass,@"Sex":sex};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/home/UserPreferSet",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 搜索默认小说名
- (void)hotdefaultWithSuccess:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/search/hotdefault",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 热门搜索数据的获取
- (void)hotsearchWithSuccess:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/search/hotsearch",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"热门搜索%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 搜索数据的获取
- (void)searchWithInputText:(NSString *)inputText PageIndex:(NSString *)pageIndex success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"inputText":inputText,@"pageIndex":pageIndex};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/search",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 搜索小说数据的获取
- (void)searchFictionWithInputText:(NSString *)inputText PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    
    NSDictionary *parameters = @{@"inputText":inputText,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/search/fiction",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
//            NSLog(@"热门搜索%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 排行榜数据的获取
- (void)rankingListWithType:(NSString *)type flag:(NSString *)flag pageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    
    NSDictionary *parameters = @{@"type":type,@"flag":flag,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/ranking/fic",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"排行榜%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 小说分类的获取
- (void)generWithsuccess:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = [[NSDictionary alloc] init];
    NSString *netPath = [NSString stringWithFormat:@"%@api/Gener/getAllClass",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"分类%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 小说分类列表的获取
- (void)generNovelListWithGener:(NSString *)gener orderby:(NSString *)orderby pageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"gener":gener,@"orderby":orderby,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/gener/fiction",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"分类%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 超精华小说的获取
- (void)chaojinghuaListWithUserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/fiction/topone",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"超精华%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}
#pragma mark - 推荐小说的获取
- (void)chaojinghuaListWithUserId:(NSString *)userId Status:(NSString *)status PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"pageIndex":pageIndex,@"status":status};
    NSString *netPath = [NSString stringWithFormat:@"%@api/fiction/toptwo",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"超精华%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark -小说详情的数据获取
- (void)novelDetailFictionWithID:(NSString *)Id UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"id":Id,@"userId":userId};
    
    NSString *netPath = [NSString stringWithFormat:@"%@/api/fiction/info",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"小说详情%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 小说点赞功能
- (void)novelClickZanWithFictionId:(NSString *)fictionId UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId,@"userId":userId};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/fiction/praise",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 小说目录的获取
- (void)novelMuluListWithID:(NSString *)Id UserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"id":Id,@"userId":userId,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/fiction/section/item",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"目录%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 章节书评列表的获取
- (void)sectionNovelPinglunListWithFictionId:(NSString *)fictionId SectionId:(NSString *)sectionId UserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId,@"sectionId":sectionId,@"userId":userId,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/evaluate/item/section",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"目录%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 直接点击阅读
- (void)clickReadNovelWithFictionId:(NSString *)fictionId UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId,@"userId":userId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/fiction/section/content/read",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"直接点击阅读%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 小说章节内容的获取
- (void)getNovelContentWithSectionId:(NSString *)sectionId UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"sectionId":sectionId,@"userId":userId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/fiction/section/content",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"小说章节内容%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 记录阅读章节
-(void)RecordsNovelSectionWithFictionId:(NSString *)fictionId SectionId:(NSString *)sectionId UserId:(NSString *)userId TextLength:(NSString *)textLength success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{

    NSDictionary *parameters = @{@"fictionId":fictionId,@"sectionId":sectionId,@"userId":userId,@"textLength":textLength};
    NSString *netPath = [NSString stringWithFormat:@"%@api/author/fiction/position",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 全部书评列表的获取
- (void)allNovelPinglunListWithFictionId:(NSString *)fictionId UserId:(NSString *)userId Flag:(NSString *)flag PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId,@"flag":flag,@"userId":userId,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/evaluate/item",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"全部书评%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 书评点赞功能
- (void)clickShuPingWithPostId:(NSString *)postId UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"postId":postId,@"userId":userId};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/evaluate/applaud",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 添加书评
- (void)addShuPingWithFictionId:(NSString *)fictionId UserId:(NSString *)userId SectionId:(NSString *)sectionId Content:(NSString *)Content success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"FictionId":fictionId,@"UserId":userId,@"SectionId":sectionId,@"Content":Content};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/evaluate/new",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 书评详情
- (void)shuPingDetailWithId:(NSString *)Id UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"id":Id,@"userId":userId};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/evaluate/iteminfo",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"书评信息%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 回复书评列表
- (void)replyShuPingListWithID:(NSString *)ID PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"id":ID,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/evaluate/item/reply",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"回复书评列表%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 回复书评
- (void)replyShuPingWithUserId:(NSString *)userId ReplyId:(NSString *)replyId PostId:(NSString *)postId Content:(NSString *)content success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"replyId":replyId,@"postId":postId,@"content":content};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/evaluate/reply",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
//            NSLog(@"书评信息%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 作者详情
- (void)autherDetailWithID:(NSString *)ID UserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"id":ID,@"pageIndex":pageIndex,@"userId":userId};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/author/info",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"作者详情%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 作者作品集合
- (void)autherNovelListWithID:(NSString *)Id PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"id":Id,@"pageIndex":pageIndex};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/author/fiction",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"作者作品集合%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 作者动态集合
-(void)autherDongTaiListWithID:(NSString *)Id PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"id":Id,@"pageIndex":pageIndex};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/author/condition",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"作者作品集合%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 作者个人资料
- (void)autherPersonWithAnthorId:(NSString *)anthorId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"anthorId":anthorId};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/author/info/comm",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"作者个人资料%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 粉丝集合
- (void)fansWithUserId:(NSString *)userId AuthorId:(NSString *)authorId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"authorId":authorId,@"pageIndex":pageIndex};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/author/fans",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"粉丝集合%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 关注集合
- (void)attionWithUserId:(NSString *)userId AuthorId:(NSString *)authorId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"authorId":authorId,@"pageIndex":pageIndex};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/author/firends",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"关注集合%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 留言集合
- (void)leacveYanWithUserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"pageIndex":pageIndex};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/author/leave",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"留言集合%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 留言详情
- (void)leaveMessageDetailWithLeaveId:(NSString *)leaveId PageIndex:(NSString *)pageIndex success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"leaveId":leaveId,@"pageIndex":pageIndex};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/author/leave/info",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"留言详情%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 添加留言
-(void)AddleacveYanWithUserId:(NSString *)userId LeaveUserId:(NSString *)leaveUserId Content:(NSString *)content success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"leaveUserId":leaveUserId,@"content":content};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/author/leave/new",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 回复留言
- (void)replyLeaveMessageWithUserId:(NSString *)userId ReplyId:(NSString *)replyId LeaveId:(NSString *)leaveId Content:(NSString *)content success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"replyId":replyId,@"leaveId":leaveId,@"content":content};
    
    NSString *netPath = [NSString stringWithFormat:@"%@api/author/leave/reply",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            //            NSLog(@"书评信息%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 用户卡片集合
- (void)userCardsWithUserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/author/info/card",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"用户卡片%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 校园联盟首页数据的获取
- (void)communityHomeWithPageIndex:(NSString *)pageIndex userId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"pageIndex":pageIndex,@"userId":userId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/Community/item",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"联盟首页%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 校园联盟搜索数据的获取
- (void)communitySearchWithInputstring:(NSString *)inputstring pageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"inputstring":inputstring,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/community/search",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
//            NSLog(@"搜索%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 获取社团信息详情
- (void)communityDetailWithID:(NSString *)ID userId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"id":ID,@"userId":userId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/Community/item/info",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
                        NSLog(@"社团信息详情%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 获取社团信息资料
- (void)communityDataWithID:(NSString *)ID success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"id":ID};
    NSString *netPath = [NSString stringWithFormat:@"%@api/community/data",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            //            NSLog(@"社团资料%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 判断是否已加入社团
- (void)checkjoinCommunityWithUserid:(NSString *)userid Commid:(NSString *)commid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userid":userid,@"commid":commid};
    NSString *netPath = [NSString stringWithFormat:@"%@api/community/user/checkjoin",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 申请加入社团
- (void)applyjoinCommunityWithUserId:(NSString *)UserId CommunityId:(NSString *)CommunityId QQ:(NSString *)QQ Year:(NSString *)Year Name:(NSString *)Name Reason:(NSString *)Reason success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"UserId":UserId,@"CommunityId":CommunityId,@"QQ":QQ,@"Year":Year,@"Name":Name,@"Reason":Reason};
    NSString *netPath = [NSString stringWithFormat:@"%@api/community/item/user/apply",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            //            NSLog(@"社团资料%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 取消申请加入社团
-(void)CancelApplyCommunityWithUserId:(NSString *)userId CommunityId:(NSString *)communityId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"communityId":communityId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/community/item/user/apply/remove",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
//        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
//        if (model.StatusCode == 200) {
//            success(model.Result);
//            //            NSLog(@"社团资料%@",task.currentRequest.URL);
//        }else{
//            faild(@"",nil);
//            [SVProgressHUD showErrorWithStatus:model.Message];
//        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 社团作品的获取
- (void)getCommunityNovelWithID:(NSString *)ID Inputstring:(NSString *)inputstring PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"id":ID,@"inputstring":inputstring,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/community/search/fictions",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"社团作品%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 社团成员的获取
- (void)getCommunityPersonWithID:(NSString *)ID UserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"id":ID,@"userId":userId,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/community/users",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"社团成员%@",task.currentRequest.URL);
            
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 关注好友
- (void)attentionUserWithUserId:(NSString *)UserId AppentionId:(NSString *)AppentionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"UserId":UserId,@"AppentionId":AppentionId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/friend/AttentionUser",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

- (void)createCommunityWithuserId:(NSString *)userId schoolName:(NSString *)schoolName communitIntro:(NSString *)communitIntro email:(NSString *)email address:(NSString *)address wechat:(NSString *)wechat quantity:(NSString *)quantity introduceName:(NSString *)introduceName presidentName:(NSString *)presidentName phone:(NSString *)phone qq:(NSString *)qq teacher:(NSString *)teacher communityName:(NSString *)communityName success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"schoolName":schoolName,@"communitIntro":communitIntro,@"email":email,@"address":address,@"wechat":wechat,@"quantity":quantity,@"introduceName":introduceName,@"presidentName":presidentName,@"phone":phone,@"qq":qq,@"teacher":teacher,@"communityName":communityName};
    NSString *netPath = [NSString stringWithFormat:@"%@api/community/new",kBaseURL];
    [self.manager POST:netPath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            //            NSLog(@"社团资料%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 社团创建失败原因
- (void)createCmomunityFaildWithID:(NSString *)ID success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"id":ID};
    NSString *netPath = [NSString stringWithFormat:@"%@api/community/new/refuse/msg",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 获取我的社团
- (void)getMineCommunityWithUserId:(NSString *)userId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/Community/item/user",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"我的社团%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 设置社团成员角色
- (void)shezhiCommunityRoleWithUserId:(NSString *)userId CommunityId:(NSString *)communityId OptionId:(NSString *)optionId Role:(NSString *)role success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"communityId":communityId,@"optionId":optionId,@"role":role};
    NSString *netPath = [NSString stringWithFormat:@"%@api/community/item/user/role",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
           
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];

}

#pragma mark - 移除社团成员
- (void)removeCommunityPersonWithUserId:(NSString *)userId CommunityId:(NSString *)communityId OptionId:(NSString *)optionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"userId":userId,@"communityId":communityId,@"optionId":optionId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/community/item/user/remove",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

@end
