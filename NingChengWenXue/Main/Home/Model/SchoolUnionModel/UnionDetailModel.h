//
//  UnionDetailModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnionDetailModel : NSObject

@property (nonatomic, strong) NSString *Id;

@property (nonatomic, strong) NSString *CommunityName;

@property (nonatomic, strong) NSString *SchoolName;

@property (nonatomic, strong) NSString *Image;

@property (nonatomic, assign) NSInteger Index;

@property (nonatomic, strong) NSString *Intro;

@property (nonatomic, assign) NSInteger UserCount;

@property (nonatomic, assign) NSInteger FictionCount;

@property (nonatomic, assign) NSInteger UserStatus;

@property (nonatomic, strong) NSArray *ExcellentFiction;

@property (nonatomic, strong) NSArray *UserItem;

@end
