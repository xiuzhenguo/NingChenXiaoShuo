//
//  InsuranceViewController.m
//  IrregularTabBar
//
//  Created by JYJ on 16/5/3.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import "WriteViewController.h"
#import "ThemeArtViewController.h"
#import "BNewBookViewController.h"

@interface WriteViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ThemeArtViewController *themeVC;
@property (nonatomic, strong) BNewBookViewController *bookVC;

@end

@implementation WriteViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;//不设置为黑色背景
    
    if (kUserLogin == NO) {
        [SVProgressHUD showSuccessWithStatus:@"请先登录"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createSegmentControl];
    
    [self createScrollView];
}

#pragma mark - 创建分段控制器
- (void) createSegmentControl{
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"创建新书", @"主题征文"]];
    self.segmentControl.frame = CGRectMake(15, BXScreenW/2.0 - 100, 200, 29);
    [self.segmentControl addTarget:self action:@selector(segmentControlAction:) forControlEvents:(UIControlEventValueChanged)];
    self.segmentControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = self.segmentControl;
    
    self.segmentControl.backgroundColor = [UIColor whiteColor];
    self.segmentControl.tintColor = BXColor(236,105,65);
    // 正常状态下
    NSDictionary * normalTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName : BXColor(236,105,65)};
    [self.segmentControl setTitleTextAttributes:normalTextAttributes forState:UIControlStateNormal];
    // 选中状态下
    NSDictionary * selctedTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName : [UIColor whiteColor]};
    [self.segmentControl setTitleTextAttributes:selctedTextAttributes forState:UIControlStateSelected];
    
}

#pragma mark - 创建scrollView
- (void) createScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, BXScreenW, BXScreenH- 64 - 20)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.scrollEnabled = NO;
    _scrollView.contentSize = CGSizeMake(2 *self.view.width, BXScreenH- 64 - 20);
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    self.themeVC = [[ThemeArtViewController alloc] init];
    self.bookVC = [[BNewBookViewController alloc] init];
    [self addChildViewController:self.bookVC];
    [self addChildViewController:self.themeVC];
    
    self.bookVC.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    self.themeVC.view.frame = CGRectMake(BXScreenW, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:self.bookVC.view];
    [self.scrollView addSubview:self.themeVC.view];
}

#pragma mark - 分段控制器点击方法


- (void)segmentControlAction:(UISegmentedControl *)sender
{
    [self.scrollView setContentOffset:CGPointMake(sender.selectedSegmentIndex * self.scrollView.frame.size.width, 0) animated:NO];
    
}


@end
