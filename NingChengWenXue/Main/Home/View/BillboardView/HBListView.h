//
//  HBListView.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/1.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectBlock) (NSString *name);

@interface HBListView : UIView

@property (nonatomic, strong) NSMutableArray *BtnArray;

@property (nonatomic, strong) selectBlock finishButtonName;

@end
