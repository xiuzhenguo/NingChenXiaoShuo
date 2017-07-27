//
//  LSYTopMenuView.h
//  LSYReader
//
//  Created by Labanotation on 16/6/1.
//  Copyright © 2016年 okwei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LSYMenuViewDelegate;
@interface LSYTopMenuView : UIView
@property (nonatomic,assign) BOOL state; //(0--未保存过，1-－保存过)
@property (nonatomic,weak) id<LSYMenuViewDelegate>delegate;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic,strong) UIButton *cataButton;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *fontbtn;
@property (nonatomic, strong) UIView *fontView;
@property (nonatomic, strong) UIButton *addFontBtn;
@property (nonatomic, strong) UIButton *subFontBtn;
@end
