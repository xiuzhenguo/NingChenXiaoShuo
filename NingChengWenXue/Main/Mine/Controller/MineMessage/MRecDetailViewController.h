//
//  MRecDetailViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/18.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReceiveMessageDelegate <NSObject>
@optional
- (void)receiveMessageDelegate:(NSInteger)row;

@end


@interface MRecDetailViewController : UIViewController

@property (nonatomic, strong) NSString *msgId;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) NSString *sendId;
@property (nonatomic, weak) id<ReceiveMessageDelegate> delegate;

@end
