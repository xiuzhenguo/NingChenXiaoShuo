//
//  PreviewSecViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/8/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionListModel.h"

@interface PreviewSecViewController : UIViewController

@property (nonatomic, strong) NSString *sectionID;

@property (nonatomic, strong) SectionListModel *sectionModel;

@property (nonatomic, assign) NSInteger loadType;

@end
