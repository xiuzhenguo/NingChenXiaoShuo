//
//  SearchListModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/17.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchListModel : NSObject

@property (nonatomic, strong) NSString *FictionId;

@property (nonatomic, strong) NSString *FictionName;

@property (nonatomic, strong) NSString *AuthorName;

@property (nonatomic, strong) NSString *Image;

@property (nonatomic, assign) NSInteger Reader;

@property (nonatomic, assign) NSInteger EvalauteIndex;

@property (nonatomic, assign) NSInteger Collect;

@property (nonatomic, strong) NSString *UserId;

@property (nonatomic, strong) NSString *AuthorImage;

@end
