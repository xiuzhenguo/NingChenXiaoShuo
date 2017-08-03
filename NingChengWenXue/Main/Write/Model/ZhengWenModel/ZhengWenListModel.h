//
//  ZhengWenListModel.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/6.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhengWenListModel : NSObject

@property (nonatomic, strong) NSString *Id;

@property (nonatomic, strong) NSString *FileImage;

@property (nonatomic, strong) NSString *Title;

@property (nonatomic, strong) NSString *Intro;

@property (nonatomic, strong) NSString *StatusName;

@property (nonatomic, strong) NSString *FictionCount;

@property (nonatomic, assign) NSInteger ClickCount;

@property (nonatomic, assign) NSInteger Status;

@property (nonatomic, assign) NSInteger IsTg;

@property (nonatomic, strong) NSArray *FictionList;

@end
