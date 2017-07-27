//
//  HSearchViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSearchViewController : UIViewController

/** 搜索栏 */
@property (nonatomic, weak) UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *tagsArray;

@end
