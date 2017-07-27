//
//  ExceedListModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/21.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExceedListModel : NSObject

@property (nonatomic, assign) NSInteger Index;

@property (nonatomic, strong) NSString *FictionId;

@property (nonatomic, strong) NSString *FictionName;

@property (nonatomic, strong) NSString *FictionImage;

@property (nonatomic, strong) NSString *AuthorName;

@property (nonatomic, strong) NSString *CharacterCount;

@property (nonatomic, strong) NSString *ClickCount;

@property (nonatomic, strong) NSString *IsCollect;

@property (nonatomic, strong) NSArray *Keys;

@end
