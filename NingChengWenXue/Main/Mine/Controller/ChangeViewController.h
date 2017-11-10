//
//  ChangeViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/10/13.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeMineInformationDelegate <NSObject>
@optional
- (void)changeMineInformationDelegate:(NSInteger)row Content:(NSString *)content;

@end

@interface ChangeViewController : UIViewController

@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) NSString *textStr;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, weak) id<ChangeMineInformationDelegate> delegate;

@end
