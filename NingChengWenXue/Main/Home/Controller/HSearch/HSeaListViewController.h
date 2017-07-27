//
//  HSeaListViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSeaListViewController : UIViewController

/** 选中cell时调用此Block  */
@property (nonatomic, copy) void(^didSelectText)(NSString *selectedText);

@property (nonatomic, strong) NSString *titleStr;

@end
