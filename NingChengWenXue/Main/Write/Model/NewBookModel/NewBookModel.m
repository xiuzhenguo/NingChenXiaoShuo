//
//  NewBookModel.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/6.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NewBookModel.h"

@implementation NewBookModel

+ (NSDictionary *)objectClassInArray{
    return @{
             @"Item" : @"NewBookListModel",
             @"SectionItem":@"SectionListModel",
             @"Msg":@"SignNovelModel"
             };
}

@end
