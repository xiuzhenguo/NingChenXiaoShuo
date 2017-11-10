//
//  ChangeSexViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 2017/10/13.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeMineSexDelegate <NSObject>
@optional
- (void)changeMineSexDelegate:(NSString *)content;

@end

@interface ChangeSexViewController : UIViewController

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, weak) id<ChangeMineSexDelegate> delegate;

@end
