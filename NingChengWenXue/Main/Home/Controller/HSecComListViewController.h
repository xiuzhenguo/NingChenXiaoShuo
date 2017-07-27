//
//  HSecComListViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSecComListViewController : UIViewController

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSString *novelID;

@property (nonatomic, strong) NSString *secID;

@property (nonatomic, assign) NSInteger SectionIndex;
@property (nonatomic, strong) NSString *SectionName;

@end
