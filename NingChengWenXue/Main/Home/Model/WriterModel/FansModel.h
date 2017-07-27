//
//  FansModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/19.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FansModel : NSObject

@property (nonatomic, strong) NSString *FansId;

@property (nonatomic, strong) NSString *FansName;

@property (nonatomic, strong) NSString *UserImage;

@property (nonatomic, assign) BOOL Attention;

@property (nonatomic, strong) NSString *AuthenticationName;

@end
