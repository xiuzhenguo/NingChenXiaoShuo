//
//  BookKeysModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/12.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookKeysModel : NSObject

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *FictionId;

@property (nonatomic, strong) NSString *FictionName;

@property (nonatomic, strong) NSString *FictionImage;

@property (nonatomic, strong) NSString *AuthorName;

@property (nonatomic, strong) NSString *FictionStatusName;

@property (nonatomic, assign) BOOL Sign;

@property (nonatomic, assign) NSInteger Reader;

@end
