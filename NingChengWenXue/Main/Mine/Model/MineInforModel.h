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

@end
