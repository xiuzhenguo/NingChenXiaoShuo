//
//  BookShelfModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/23.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookShelfModel : NSObject

@property (nonatomic, strong) NSString *FictionId;

@property (nonatomic, strong) NSString *FictionName;

@property (nonatomic, strong) NSString *FictionImage;

@property (nonatomic, strong) NSString *UserImage;

@property (nonatomic, strong) NSString *AuthorName;

@property (nonatomic, strong) NSString *CollectCount;

@property (nonatomic, strong) NSString *PostCount;

@property (nonatomic, strong) NSString *ReadCount;

@property (nonatomic, strong) NSString *BookStatusName;

@property (nonatomic, assign) NSInteger SectionIndex;

@property (nonatomic, assign) NSInteger SectionTotalCount;

@property (nonatomic, assign) NSInteger BookStatus;

@property (nonatomic, strong) NSString *ClassName;

@end
