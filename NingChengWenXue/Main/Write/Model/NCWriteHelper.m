//
//  NCWriteHelper.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/6.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NCWriteHelper.h"

@implementation NCWriteHelper

#pragma mark - 作品集和
- (void)productionWithAuthorid:(NSString *)authorid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"authorid":authorid};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"作品集合%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 作品信息
-(void)productionMessageWithFictionId:(NSString *)fictionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"作品信息%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 章节列表
-(void)novelSectionListWithFictionId:(NSString *)fictionId pageIndex:(NSString *)pageIndex success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/section",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"章节列表%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 作品名称修改
- (void)changeNovelNameWithFictionId:(NSString *)fictionId FictionName:(NSString *)fictionName success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId,@"fictionName":fictionName};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/name",kBaseURL];
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

#pragma mark - 代表作修改
- (void)daiBiaoZuoWithFictionId:(NSString *)fictionId UserId:(NSString *)userId Q:(NSString *)q success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId,@"userId":userId,@"q":q};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/at",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 作品简介修改
-(void)novelIntroWithFictionId:(NSString *)fictionId Intro:(NSString *)intro success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId,@"intro":intro};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/intro",kBaseURL];
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

#pragma mark - 作品标签修改
- (void)novelShuXingWithFictionId:(NSString *)fictionId Key:(NSString *)key Category:(NSInteger)category success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId,@"key":key,@"category":@(category)};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/label",kBaseURL];
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

#pragma mark - 作品属性修改
- (void)changeNovelShuXingWithFictionId:(NSString *)fictionId Q:(NSString *)q success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId,@"q":q};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/attribute",kBaseURL];
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

#pragma mark - 作品状态修改
- (void)changeNovelStatusWithFictionId:(NSString *)fictionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/status",kBaseURL];
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

#pragma mark - 发布章节
- (void)publishNovelSectionWithSectionId:(NSString *)sectionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"sectionId":sectionId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/section/publish",kBaseURL];
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

#pragma mark - 定时发布章节
-(void)dingShiPublishSectionWithSectionId:(NSString *)sectionId FictionId:(NSString *)FictionId UserId:(NSString *)UserId PublishTime:(NSString *)PublishTime success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"sectionId":sectionId,@"FictionId":FictionId,@"UserId":UserId,@"PublishTime":PublishTime};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/section/publish/time",kBaseURL];
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

#pragma mark - 签约条件
-(void)signConditionWithFictionId:(NSString *)fictionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/sign",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"签约条件%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 申请签约
- (void)applySignNovelWithFictionId:(NSString *)fictionId AuthorId:(NSString *)authorId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId,@"authorId":authorId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/applysign",kBaseURL];
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

#pragma mark - 申请失败原因
- (void)faileApplySignNovelWithFictionId:(NSString *)fictionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/sign/msg",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        NSLog(@"申请失败原因%@",task.currentRequest.URL);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 删除作品
- (void)deleteNovelWithFictionId:(NSString *)fictionId AuthorId:(NSString *)authorId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId,@"authorId":authorId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/remove",kBaseURL];
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

#pragma mark - 删除章节
-(void)removeNovelSectionWithFictionId:(NSString *)fictionId SectionId:(NSString *)sectionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId,@"sectionId":sectionId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/section/remove",kBaseURL];
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

#pragma mark - 预览章节
-(void)PreviewNovelSectionWithSectionid:(NSString *)sectionid success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"sectionid":sectionid};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/section/item",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"预览章节%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 新建章节
- (void)createNewNovelSectionWithFictionId:(NSString *)fictionId Title:(NSString *)title Content:(NSString *)content Remark:(NSString *)remark success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId,@"title":title,@"content":content,@"remark":remark};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/section/new",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 修改章节
-(void)changeNovelSectionContentWithFictionId:(NSString *)fictionId SectionId:(NSString *)sectionId Title:(NSString *)title Content:(NSString *)content Remark:(NSString *)Remark success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"fictionId":fictionId,@"sectionId":sectionId,@"title":title,@"content":content,@"Remark":Remark};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/fiction/section/change",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 征文集合
- (void)getZhengWenListWithPageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/Solicitation",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"征文集合%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 征文详情
-(void)zhengWenDetailWithID:(NSString *)Id UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"id":Id,@"userId":userId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/solicitation/infofic",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"征文详情%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 征文作品
- (void)callForPapersListWithSolicitationId:(NSString *)SolicitationId PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"SolicitationId":SolicitationId,@"pageIndex":pageIndex};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/solicitation/fiction",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"征文作品%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 获奖作品
- (void)AwardsNovelWithSolicitationId:(NSString *)solicitationId success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"solicitationId":solicitationId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/solicitation/prize/fiction",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"获奖作品%@",task.currentRequest.URL);
        }else{
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 可投作品
- (void)canTouNovelWithSolicitationId:(NSString *)SolicitationId UserId:(NSString *)userId success:(ResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"SolicitationId":SolicitationId,@"userId":userId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/solicitation/Tgfiction",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"可投作品%@",task.currentRequest.URL);
        }else{
            faild(@"",nil);
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 投递小说
-(void)DeliveryNovelWithSolicitationId:(NSString *)solicitationId UserId:(NSString *)userId FictionId:(NSString *)fictionId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"solicitationId":solicitationId,@"userId":userId,@"fictionId":fictionId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/solicitation/bookadd",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 退出征文
-(void)tuiChuCallForPapersWithID:(NSString *)Id SolicitationId:(NSString *)solicitationId UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"id":Id,@"solicitationId":solicitationId,@"userId":userId};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/solicitation/bookexit",kBaseURL];
    [self.manager POST:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

#pragma mark - 征文规则
-(void)callForPapersGuizeWithID:(NSString *)Id success:(ETResponseBlock)success faild:(ETResponseErrorBlock)faild{
    NSDictionary *parameters = @{@"solicitationId":Id};
    NSString *netPath = [NSString stringWithFormat:@"%@api/writing/solicitation/info/config",kBaseURL];
    [self.manager GET:netPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:responseObject];
        if (model.StatusCode == 200) {
            success(model.Result);
            NSLog(@"征文规则%@",task.currentRequest.URL);
        }else{
            [SVProgressHUD showErrorWithStatus:model.Message];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(nil,nil);
    }];
}

@end
