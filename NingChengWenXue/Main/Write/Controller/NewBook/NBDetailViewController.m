//
//  NBDetailViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/18.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBDetailViewController.h"

@interface NBDetailViewController ()

@end

@implementation NBDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;//不设置为黑色背景
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"详情";
    
    [self setUpNavButtonUI];
    
    [self setUpUILableUI];
}

#pragma mark - 创建显示UILabe
-(void) setUpUILableUI {
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, BXScreenW - 30, BXScreenH - 30)];
    contentLab.font = THIRDFont;
    contentLab.textColor = BXColor(40, 40, 40);
    contentLab.numberOfLines = 0;
    contentLab.text = @"签约不成功的原因是，签约不成功的原因是：签约不成功的原因是；签约不成功的原因是，签约不成功的原因是。签约不成功的原因是、签约不成功的原因是";
    [contentLab sizeToFit];
    [self.view addSubview:contentLab];
}

#pragma mark - 设置导航栏按钮
-(void) setUpNavButtonUI {
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 80, 30);
    [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = item;
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
