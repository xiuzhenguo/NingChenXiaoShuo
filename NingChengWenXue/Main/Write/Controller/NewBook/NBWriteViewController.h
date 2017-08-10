//
//  NBWriteViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/22.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBWriteViewController : UIViewController

//编辑富文本，设置内容
@property (nonatomic,strong) id content;
@property (nonatomic, strong) NSString *jsonString;

@property (nonatomic, strong) NSString *sectionID; // 章节ID
@property (nonatomic, strong) NSString *ficID; // 小说ID
@property (nonatomic, assign) NSInteger typeInt;


@property (nonatomic, strong) NSMutableArray *houtuiArray; // 后退
@property (nonatomic, strong) NSMutableArray *qianjinArray;// 前进

@end
