//
//  MineInforModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/8/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineInforModel : NSObject

@property (nonatomic, strong) NSString *UserId;

@property (nonatomic, strong) NSString *UserName;

@property (nonatomic, strong) NSString *UserImage;

@property (nonatomic, strong) NSString *UserSign;

@property (nonatomic, assign) NSInteger UserFansCount;

@property (nonatomic, assign) NSInteger UserAttentionCount;

@property (nonatomic, strong) NSString *UUID;

@property (nonatomic, strong) NSString *UserPhone;

@property (nonatomic, assign) NSInteger MMPoint;

@property (nonatomic, assign) NSInteger UUPoint;

@property (nonatomic, assign) NSInteger Lv;

@property (nonatomic, assign) NSInteger UserCardCount;

@property (nonatomic, assign) NSInteger UserMedalCount;

@property (nonatomic, assign) NSInteger UserEnergy;

@property (nonatomic, strong) NSString *UserMartial;

@property (nonatomic, strong) NSString *UserAddress;

@end
