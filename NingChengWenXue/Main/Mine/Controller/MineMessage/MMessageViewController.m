//
//  MMessageViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/15.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "MMessageViewController.h"
#import "MSendMesViewController.h"
#import "MReceMesViewController.h"
#import "MWriteMesViewController.h"

@interface MMessageViewController ()

@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) MSendMesViewController *sendVC;
@property (nonatomic, strong) MReceMesViewController *receVC;
@property (nonatomic, strong) MWriteMesViewController *writeVC;

@end

@implementation MMessageViewController

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
    self.title = @"消息管理";
    
    [self setUpNavButtonUI];
    
    [self createSegmentControl];
    
    [self createScrollView];
}

#pragma mark - 创建分段控制器
- (void) createSegmentControl{
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"收件箱", @"写邮件",@"已发送"]];
    self.segmentControl.frame = CGRectMake(15, 0, BXScreenW - 30, 29);
    [self.segmentControl addTarget:self action:@selector(segmentControlAction:) forControlEvents:(UIControlEventValueChanged)];
    self.segmentControl.selectedSegmentIndex = 0;
    [self.view addSubview:self.segmentControl];
    
    self.segmentControl.backgroundColor = [UIColor whiteColor];
    self.segmentControl.tintColor = BXColor(236,105,65);
    // 正常状态下
    NSDictionary * normalTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:13.0f],NSForegroundColorAttributeName : [UIColor blackColor]};
    [self.segmentControl setTitleTextAttributes:normalTextAttributes forState:UIControlStateNormal];
    // 选中状态下
    NSDictionary * selctedTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:13.0f],NSForegroundColorAttributeName : [UIColor whiteColor]};
    [self.segmentControl setTitleTextAttributes:selctedTextAttributes forState:UIControlStateSelected];
    
}

#pragma mark - 创建scrollView
- (void) createScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 29, BXScreenW, BXScreenH - 64 - 29)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.scrollEnabled = NO;
    _scrollView.contentSize = CGSizeMake(3 *self.view.width, BXScreenH - 64);
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    self.receVC = [[MReceMesViewController alloc] init];
    self.writeVC = [[MWriteMesViewController alloc] init];
    self.sendVC = [[MSendMesViewController alloc] init];
    [self addChildViewController:self.receVC];
    [self addChildViewController:self.writeVC];
    [self addChildViewController:self.sendVC];
    
    self.receVC.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    self.writeVC.view.frame = CGRectMake(BXScreenW, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    self.sendVC.view.frame = CGRectMake(BXScreenW*2, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:self.receVC.view];
    [self.scrollView addSubview:self.writeVC.view];
    [self.scrollView addSubview:self.sendVC.view];
}

#pragma mark - 分段控制器点击方法


- (void)segmentControlAction:(UISegmentedControl *)sender
{
    [self.scrollView setContentOffset:CGPointMake(sender.selectedSegmentIndex * self.scrollView.frame.size.width, 0) animated:NO];
    
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
