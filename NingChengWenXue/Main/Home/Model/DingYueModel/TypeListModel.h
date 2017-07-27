//
//  TypeListModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/15.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeListModel : NSObject

@property (nonatomic, strong) NSString *ClassName;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, strong) NSString *ClassDesc;

@property (nonatomic, assign) BOOL IsCheck;

@end
