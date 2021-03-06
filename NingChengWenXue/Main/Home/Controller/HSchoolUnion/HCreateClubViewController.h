//
//  HCreateClubViewController.h
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/9.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CreateSchoolUnionDelegate <NSObject>
@optional
- (void)createSchoolUnion;

@end

@interface HCreateClubViewController : UIViewController

@property (nonatomic, weak) id<CreateSchoolUnionDelegate> delegate;

@end
