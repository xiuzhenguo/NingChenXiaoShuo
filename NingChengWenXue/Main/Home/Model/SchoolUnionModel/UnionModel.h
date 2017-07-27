//
//  UnionModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/26.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnionModel : NSObject

@property (nonatomic, assign) NSInteger AppyStatus;

@property (nonatomic, strong) NSArray *CommunityIndexList;

@property (nonatomic, assign) NSInteger Role;

@property (nonatomic, strong) NSArray *CommunityUserList;

@end
