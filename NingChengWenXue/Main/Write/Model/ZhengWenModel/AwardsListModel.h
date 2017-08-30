//
//  AwardsListModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/8/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AwardsListModel : NSObject

@property (nonatomic, strong) NSString *FictionId;

@property (nonatomic, strong) NSString *FictionName;

@property (nonatomic, strong) NSString *FictionImage;

@property (nonatomic, strong) NSString *AuthorName;

@property (nonatomic, assign) NSInteger ClickCount;

@property (nonatomic, assign) NSInteger Level;

@end
