//
//  HComListViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HComListViewController : UIViewController

@property (nonatomic, strong) NSString *bookID;// 小说ID

@property (nonatomic, strong) NSString *secID;// 章节ID

@property (nonatomic, assign) NSInteger SectionIndex;
@property (nonatomic, strong) NSString *SectionName;

@end
