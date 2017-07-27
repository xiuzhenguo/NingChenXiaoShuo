//
//  WriterDynModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/18.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DynFictionModel.h"

@interface WriterDynModel : NSObject

@property (nonatomic, strong) NSString *Id;

@property (nonatomic, strong) NSString *UserId;

@property (nonatomic, strong) NSString *Title;

@property (nonatomic, strong) NSString *FictionId;

@property (nonatomic, strong) NSString *FictionSectionId;

@property (nonatomic, strong) NSString *UserImage;

@property (nonatomic, strong) NSString *AuthorName;

@property (nonatomic, strong) NSString *AddTime;

@property (nonatomic, assign) NSInteger Number;

@property (nonatomic, strong) NSString *Content;

@property (nonatomic, assign) NSInteger ActionGener;

@property (nonatomic, strong) DynFictionModel *Fiction;

@end
