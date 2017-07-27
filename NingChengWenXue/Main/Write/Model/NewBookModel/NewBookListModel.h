//
//  NewBookListModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/23.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewBookListModel : NSObject

@property (nonatomic, strong) NSString *FictionId;

@property (nonatomic, strong) NSString *FictionName;

@property (nonatomic, strong) NSString *FictionImage;

@property (nonatomic, strong) NSString *CategoryName;

@property (nonatomic, strong) NSString *Reader;

@property (nonatomic, strong) NSString *Collect;

@property (nonatomic, strong) NSString *Character;

@property (nonatomic, assign) NSInteger Publish;

@property (nonatomic, assign) NSInteger NotPublish;

@property (nonatomic, assign) NSInteger Category;

@property (nonatomic, strong) NSString *FictionKey;

@property (nonatomic, assign) BOOL IsPublish;

@property (nonatomic, strong) NSString *PublishName;

@property (nonatomic, assign) NSInteger FictionStatus;

@property (nonatomic, strong) NSString *FictionStatusName;

@property (nonatomic, assign) BOOL Authentiction;

@property (nonatomic, strong) NSString *Intro;

@end
