//
//  GoodsDetailModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/11/8.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsDetailModel : NSObject

@property (nonatomic, strong) NSString *ProductId;

@property (nonatomic, strong) NSString *ProductName;

@property (nonatomic, strong) NSString *ProductImage;

@property (nonatomic, strong) NSString *ProductDetailed;

@property (nonatomic, assign) NSInteger ProductPrice;

@property (nonatomic, assign) NSInteger PlatformPrice;

@property (nonatomic, assign) NSInteger Inventory;

@property (nonatomic, assign) NSInteger BuyAstrictLevel;

@property (nonatomic, assign) NSInteger IsEnabledCombination;

@property (nonatomic, assign) NSInteger CuurencyType;

@property (nonatomic, assign) NSInteger ProductType;

@end
