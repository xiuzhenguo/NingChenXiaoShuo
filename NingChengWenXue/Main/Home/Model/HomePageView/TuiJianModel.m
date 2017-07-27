//
//  TuiJianModel.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/12.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "TuiJianModel.h"

@implementation TuiJianModel

+ (NSDictionary *)objectClassInArray{
    return @{
             @"Collect" : @"BookListModel",
             @"DaShang" : @"BookListModel",
             @"MaWang" : @"BookListModel",
             @"TuHao" : @"BookListModel",
             @"FictionClassItem" : @"BookListModel"
             
             };
}

@end
