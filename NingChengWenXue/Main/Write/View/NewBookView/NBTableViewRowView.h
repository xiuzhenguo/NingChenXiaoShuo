//
//  NBTableViewRowView.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectBlock) (NSString *title);

@interface NBTableViewRowView : UIView

@property (nonatomic, strong) SelectBlock finishButtonTitle;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end
