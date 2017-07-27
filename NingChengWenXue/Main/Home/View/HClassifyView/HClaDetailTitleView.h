//
//  HClaDetailTitleView.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/7.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HClaDetTitTableViewCell.h"

typedef void(^selectBlock) (NSString *titleStr);
typedef void(^selectBlock) (NSString *typeId);

@interface HClaDetailTitleView : UIView

@property (nonatomic, strong) NSArray *sectionArr;

@property (nonatomic, strong) selectBlock finishButtonTitleStr;
@property (nonatomic, strong) selectBlock finishButtonTypeId;

@end
