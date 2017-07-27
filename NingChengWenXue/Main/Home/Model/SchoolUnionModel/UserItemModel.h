//
//  UserItemModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserItemModel : NSObject

@property (nonatomic, assign) NSInteger UserRole;

@property (nonatomic, assign) BOOL IsAuthentication;

@property (nonatomic, assign) BOOL Attention;

@property (nonatomic, strong) NSString *FictionName;

@property (nonatomic, strong) NSString *UserId;

@property (nonatomic, strong) NSString *AuthorName;

@property (nonatomic, strong) NSString *AuthorImage;


@end
