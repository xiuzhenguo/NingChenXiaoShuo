//
//  HReadPageViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/24.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HReadPageViewController.h"
#import "HReadMenuView.h"
#import "HComListViewController.h"
#import "HCatalogueViewController.h"

@interface HReadPageViewController ()<UIGestureRecognizerDelegate,LSYMenuViewDelegate,UINavigationControllerDelegate>

@property(nonatomic, strong) HReadMenuView *menuView;

@end

@implementation HReadPageViewController

//-(void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    
//    _menuView.frame = CGRectMake(0, 0, BXScreenW, BXScreenH);
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showToolMenu)];
        tap.delegate = self;
        tap;
    })];
    
    self.navigationController.delegate = self;
    
    [self setUpMenuViewUI];
    
    [[NSUserDefaults standardUserDefaults] setValue:@"2" forKey:@"whether_read"];
    
    
}

#pragma mark - 添加菜单栏
-(void) setUpMenuViewUI {
    _menuView = [[HReadMenuView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    [self.view addSubview:_menuView];
    _menuView.hidden = YES;
    [_menuView.topView.backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    // 添加字体放大的点击方法
    [_menuView.topView.addFontBtn addTarget:self action:@selector(clickAddFontButton) forControlEvents:UIControlEventTouchUpInside];
    // 添加字体缩小的点击方法
    [_menuView.topView.subFontBtn addTarget:self action:@selector(clickSubFontButton) forControlEvents:UIControlEventTouchUpInside];
    // 评论按钮的点击方法
    [_menuView.boomView.commentBtn addTarget:self action:@selector(clickCommentButton) forControlEvents:UIControlEventTouchUpInside];
    // 目录按钮的点击事件
    [_menuView.topView.cataButton addTarget:self action:@selector(clickCataButton) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 进入章节目录
-(void) clickCataButton {
    HCatalogueViewController *vc = [[HCatalogueViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 字体放大功能的实现
-(void) clickAddFontButton {
    NSLog(@"11111");
}

#pragma mark - 字体减小功能的实现
-(void) clickSubFontButton {
    
}

#pragma mark - 进入评论列表页面
-(void) clickCommentButton {
    HComListViewController *vc = [[HComListViewController alloc] init];
    vc.bookID = self.bookId;
    vc.secID = self.secID;
    vc.SectionIndex = self.SectionIndex;
    vc.SectionName = self.SectionName;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 实现菜单栏出现的方法
-(void)showToolMenu
{
    [self.menuView showAnimation:YES];
}

#pragma mark - 返回按钮点击事件
-(void)clickBackButton{
    [self.navigationController popViewControllerAnimated:YES];
}

//#pragma mark - UINavigationControllerDelegate(隐藏导航栏)
//// 将要显示控制器
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    // 判断要显示的控制器是否是自己
//    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
//    
//    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
//}
//


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.translucent = NO;//不设置为黑色背景
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
