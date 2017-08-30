//
//  AwardsZhengWenModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/8/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AwardsZhengWenModel : NSObject

@property (nonatomic, strong) NSString *LevelName;

@property (nonatomic, assign) NSInteger Level;

@property (nonatomic, strong) NSArray *SolicitationBookPrizeList;

@property (nonatomic, strong) NSString *ConfigName;

@property (nonatomic, strong) NSString *ConfigContent;

@end
