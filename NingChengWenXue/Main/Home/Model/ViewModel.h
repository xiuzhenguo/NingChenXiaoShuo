//
//  ViewModel.h
//  DoubleTableDemo
//
//  Created by xiaocool on 17/2/17.
//  Copyright © 2017年 xiaocool. All rights reserved.
//  在数据模型中添加一个属性 根据此属性显示UI

#import <Foundation/Foundation.h>

@interface ViewModel : NSObject
@property(nonatomic,assign)BOOL isShowBig;
@property(nonatomic,assign)NSInteger row;
@property (nonatomic, strong) NSString *Select;
@end
