//
//  CardModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/21.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardModel : NSObject

@property (nonatomic, strong) NSString *CardName;

@property (nonatomic, assign) NSInteger CardCount;

@property (nonatomic, strong) NSString *CardImage;

@property (nonatomic, strong) NSString *CardId;

@property (nonatomic, strong) NSString *IsCompound;

@end
