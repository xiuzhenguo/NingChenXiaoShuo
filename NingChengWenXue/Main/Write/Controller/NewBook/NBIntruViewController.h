//
//  NBIntruViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/8.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WriteIntrofyDelegate <NSObject>
@optional
- (void)writeIntro:(NSString *)intro;

@end

@interface NBIntruViewController : UIViewController

@property (nonatomic, strong) NSString *introduceStr;

@property (nonatomic, strong) NSString *bookId;

@property (nonatomic, assign) NSInteger newType;

@property (nonatomic, weak) id<WriteIntrofyDelegate> delegate;

@end
