//
//  NewBookModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/6.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewBookModel : NSObject

@property (nonatomic, assign) NSInteger Complete;

@property (nonatomic, assign) NSInteger NotComplete;

@property (nonatomic, strong) NSArray *Item;

@property (nonatomic, assign) NSInteger FictionApplyStatus;

@property (nonatomic, strong) NSArray *Msg;

@property (nonatomic, strong) NSString *ResultMsg;

@property (nonatomic, assign) BOOL IsSatisfy;

@property (nonatomic, assign) NSInteger SignType;

@property (nonatomic, assign) NSInteger Count;

@property (nonatomic, strong) NSArray *SectionItem;

@end
