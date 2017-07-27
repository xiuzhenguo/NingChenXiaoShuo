//
//  UnionModel.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/26.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "UnionModel.h"

@implementation UnionModel

+ (NSDictionary *)objectClassInArray{
    return @{
             @"CommunityIndexList" : @"UnionHomeModel",
             @"CommunityUserList" : @"UserItemModel"
             
             };
    
}

@end
