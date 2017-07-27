//
//  WriterDetailModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/18.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WriterDetailModel : NSObject

@property (nonatomic, strong) NSString *AuthorId;

@property (nonatomic, strong) NSString *AuthorName;

@property (nonatomic, strong) NSString *UUID;

@property (nonatomic, assign) NSInteger lv;

@property (nonatomic, assign) NSInteger Vlevel;

@property (nonatomic, assign) NSInteger Energy;

@property (nonatomic, strong) NSString *Martial;

@property (nonatomic, strong) NSString *Moral;

@property (nonatomic, strong) NSString *AuthotImage;

@property (nonatomic, assign) NSInteger FansCount;

@property (nonatomic, assign) NSInteger AttentionCount;

@property (nonatomic, assign) NSInteger LeaveCount;

@property (nonatomic, assign) NSInteger FictionCount;

@property (nonatomic, assign) NSInteger FirendCount;

@property (nonatomic, assign) NSInteger IsFirend;

@property (nonatomic, strong) NSArray *FictionItem;

@end
