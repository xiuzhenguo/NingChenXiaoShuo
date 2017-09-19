//
//  NCBookshelfHelper.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/23.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ETBaseHelper.h"

@interface NCBookshelfHelper : ETBaseHelper

/**
 *  书架集合
 *
 */
-(void)bookRackListWithUserid:(NSString *)userid PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock) faild;

/**
 *  收藏集合
 *
 *
 */
-(void)collectionListWithUserid:(NSString *)userid PageIndex:(NSString *)pageIndex success:(ResponseBlock)success faild:(ETResponseErrorBlock) faild;

/**
 *  添加、移除收藏小说
 *
 *
 */
-(void)removeNovelWithFictionId:(NSString *)fictionId UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock) faild;

/**
 *  移除书架小说
 *
 *
 */
-(void)removeBookShelfWithFictionId:(NSString *)fictionId UserId:(NSString *)userId success:(ETResponseBlock)success faild:(ETResponseErrorBlock) faild;

@end
