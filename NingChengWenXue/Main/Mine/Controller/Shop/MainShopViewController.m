
//
//  MainShopViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/11/3.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "MainShopViewController.h"
#import "MJiLuViewController.h"
#import "MAddressViewController.h"
#import "MShopViewController.h"

@interface MainShopViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) MShopViewController *oneVC;
@property (nonatomic, strong) MAddressViewController *twoVC;
@property (nonatomic, strong) MJiLuViewController *threeVC;
@property (nonatomic, strong) UIButton *shopBtn;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *jiluBtn;

@end

@implementation MainShopViewController

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
    self.title = @"商城";
    
    [self setUpNavButtonUI];
    
    [self setUpFooterButton];
    
    [self createScrollView];
}

#pragma mark - 
-(void)setUpFooterButton{
    NSArray *imgArray = @[@"商城_click",@"地址管理",@"购物记录"];
    NSArray *titleArray = @[@"商城",@"地址管理",@"购物记录"];
    for (int i = 0; i < 3; i++) {
        // 创建自定义按钮
        UIButton *btn_click = [UIButton buttonWithType:UIButtonTypeCustom];
        // 创建普通状态按钮图片
        [btn_click setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        // 设置按钮普通状态标题
        [btn_click setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn_click setTitleColor:BXColor(101, 101, 101) forState:UIControlStateNormal];
        // 按钮坐标和尺寸
        btn_click.frame = CGRectMake(0 + (BXScreenW/3.0)*i, BXScreenH - kTopHeight - 49, BXScreenW/3.0, 49);
        btn_click.titleLabel.font = THIRDFont;
        // 按钮图片和标题总高度
        CGFloat totalHeight = (btn_click.imageView.frame.size.height + btn_click.titleLabel.frame.size.height);
        // 设置按钮图片偏移
        [btn_click setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - btn_click.imageView.frame.size.height), 0.0, 0.0, -btn_click.titleLabel.frame.size.width)];
        // 设置按钮标题偏移
        [btn_click setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -btn_click.imageView.frame.size.width, -(totalHeight - btn_click.titleLabel.frame.size.height),0.0)];
        btn_click.tag = 1000 + i;
        [btn_click addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        // 加载按钮到视图
        [self.view addSubview:btn_click];
        if (i == 0) {
            self.shopBtn = btn_click;
        }else if (i == 1){
            self.addBtn = btn_click;
        }else{
            self.jiluBtn = btn_click;
        }
        
    }
}

#pragma mark - 创建scrollView
- (void) createScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - kTopHeight - 49)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.scrollEnabled = NO;
    _scrollView.contentSize = CGSizeMake(3 *self.view.width, BXScreenH - kTopHeight - 49);
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    self.oneVC = [[MShopViewController alloc] init];
    self.twoVC = [[MAddressViewController alloc] init];
    self.threeVC = [[MJiLuViewController alloc] init];
    [self addChildViewController:self.oneVC];
    [self addChildViewController:self.twoVC];
    [self addChildViewController:self.threeVC];
    
    self.oneVC.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    self.twoVC.view.frame = CGRectMake(BXScreenW, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    self.threeVC.view.frame = CGRectMake(BXScreenW*2, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:self.oneVC.view];
    [self.scrollView addSubview:self.twoVC.view];
    [self.scrollView addSubview:self.threeVC.view];
}

-(void)clickButton:(UIButton *)sender{
    
    if (sender.tag == 1000) {
        [self.shopBtn setImage:[UIImage imageNamed:@"商城_click"] forState:UIControlStateNormal];
        [self.addBtn setImage:[UIImage imageNamed:@"地址管理"] forState:UIControlStateNormal];
        [self.jiluBtn setImage:[UIImage imageNamed:@"购物记录"] forState:UIControlStateNormal];
    }else if (sender.tag == 1001){
        [self.shopBtn setImage:[UIImage imageNamed:@"商城"] forState:UIControlStateNormal];
        [self.addBtn setImage:[UIImage imageNamed:@"地址管理_click"] forState:UIControlStateNormal];
        [self.jiluBtn setImage:[UIImage imageNamed:@"购物记录"] forState:UIControlStateNormal];
    }else{
        [self.shopBtn setImage:[UIImage imageNamed:@"商城"] forState:UIControlStateNormal];
        [self.addBtn setImage:[UIImage imageNamed:@"地址管理"] forState:UIControlStateNormal];
        [self.jiluBtn setImage:[UIImage imageNamed:@"购物记录_click"] forState:UIControlStateNormal];
    }
    [self.scrollView setContentOffset:CGPointMake((sender.tag - 1000) * self.scrollView.frame.size.width, 0) animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置导航栏按钮
-(void) setUpNavButtonUI {
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 100, 30);
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
