//
//  HReadPageViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/24.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HReadPageViewController : UIViewController

@property (nonatomic, strong) NSString *bookId;// 小说Id

@property (nonatomic, strong) NSString *secID;// 章节Id

@property (nonatomic, assign) NSInteger pushType;

@property (nonatomic, assign) NSInteger SectionIndex;// 第几章
@property (nonatomic, strong) NSString *SectionName;



@property (nonatomic, strong) NSMutableArray *novelArray;
@property (nonatomic, assign) NSInteger loadType;

@end
