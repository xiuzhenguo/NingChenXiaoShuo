//
//  GoodsModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/11/8.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject

@property (nonatomic, strong) NSString *ProductId;

@property (nonatomic, strong) NSString *ProductName;

@property (nonatomic, strong) NSString *ProductImage;

@property (nonatomic, strong) NSString *ProductDetailed;

@property (nonatomic, assign) NSInteger ProductPrice;

@property (nonatomic, assign) NSInteger *CuurencyType;

@property (nonatomic, assign) NSInteger *ProductType;

//轮播图
@property (nonatomic, strong) NSString *ShopId;
@property (nonatomic, strong) NSString *ShopImage;

@end
