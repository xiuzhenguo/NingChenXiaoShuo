//
//  NBAttViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/12.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBAttViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger typeRow;
@property (nonatomic, assign) BOOL IsPublish;
@property (nonatomic, strong) NSString *bookId;

@end
