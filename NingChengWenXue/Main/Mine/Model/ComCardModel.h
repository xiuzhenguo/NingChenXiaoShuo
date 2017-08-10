//
//  ComCardModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/8/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComCardModel : NSObject

@property (nonatomic, strong) NSString *CardImage;

@property (nonatomic, assign) NSInteger CardId;

@property (nonatomic, strong) NSString *CardName;

@property (nonatomic, assign) NSInteger IsCompound; // 1.可合成  2.不能合成

@end
