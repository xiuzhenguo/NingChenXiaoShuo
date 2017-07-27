//
//  HReportView.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectBlock) (NSString *title);

@interface HReportView : UIView

@property (nonatomic, strong) selectBlock finishButtonTitle;

@property (nonatomic, strong) NSArray *dataArray;

@end
