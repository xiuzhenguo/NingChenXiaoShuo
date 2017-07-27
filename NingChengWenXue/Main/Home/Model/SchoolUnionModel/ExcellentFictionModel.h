//
//  ExcellentFictionModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExcellentFictionModel : NSObject

@property (nonatomic, assign) NSInteger BookStatus;

@property (nonatomic, strong) NSString *Image;

@property (nonatomic, strong) NSString *addtime;

@property (nonatomic, strong) NSString *timeinfo;

@property (nonatomic, strong) NSString *FictionId;

@property (nonatomic, strong) NSString *FictionName;

@property (nonatomic, strong) NSString *AuthorName;

@property (nonatomic, assign) NSInteger Reader;

@property (nonatomic, assign) NSInteger EvalauteIndex;

@property (nonatomic, assign) NSInteger Collect;

@end
