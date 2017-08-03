//
//  NBClassfyViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/15.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectClassfyDelegate <NSObject>
@optional
- (void)selectClassfy:(NSInteger )classfy Biaoqian:(NSString *)biaoqian Other:(NSString *)other;

@end

@interface NBClassfyViewController : UIViewController

@property (nonatomic, assign) NSInteger typeID;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSMutableArray *ortherArray;

@property (nonatomic, strong) NSString *bookId;

@property (nonatomic, assign) NSInteger newType;

@property (nonatomic, weak) id<SelectClassfyDelegate> delegate;

@end
