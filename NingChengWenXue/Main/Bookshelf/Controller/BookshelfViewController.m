//
//  DataViewController.m
//  IrregularTabBar
//
//  Created by JYJ on 16/5/3.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import "BookshelfViewController.h"
#import "ShelfViewController.h"
#import "BSCollectViewController.h"
#import "BSOffLineViewController.h"

@interface BookshelfViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ShelfViewController *shelfVC;
@property (nonatomic, strong) BSCollectViewController *collectVC;
@property (nonatomic, strong) BSOffLineViewController *offLineVC;

@end

@implementation BookshelfViewController

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
    self.title = @"书架";
   
    [self setHeadCycleScrollView];
    
    [self createSegmentControl];
    
    [self createScrollView];
}

#pragma mark - 创建顶部轮播图
- (void) setHeadCycleScrollView {
    NSArray *imageNames = @[@"上首页_1",@"上首页_2",@"上首页_3",@"上首页_4",@"上首页_5",@"上首页_6"];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, kScreenWidth, 113) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.view addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // --- 轮播时间间隔，默认1.0秒，可自定义
    cycleScrollView.autoScrollTimeInterval = 2.0;
}

#pragma mark - 创建分段控制器
- (void) createSegmentControl{
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"书架", @"收藏", @"离线"]];
    self.segmentControl.frame = CGRectMake(15, 120+64, BXScreenW - 30, 29);
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
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 128+29+64, BXScreenW, BXScreenH - 128 - 28 - 64)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.scrollEnabled = NO;
    _scrollView.contentSize = CGSizeMake(3 *self.view.width, BXScreenH - 128 - 28 - 64);
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    self.shelfVC = [[ShelfViewController alloc] init];
    self.collectVC = [[BSCollectViewController alloc] init];
    self.offLineVC = [[BSOffLineViewController alloc] init];
    [self addChildViewController:self.shelfVC];
    [self addChildViewController:self.collectVC];
    [self addChildViewController:self.offLineVC];
    
    self.shelfVC.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    self.collectVC.view.frame = CGRectMake(BXScreenW, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    self.offLineVC.view.frame = CGRectMake(BXScreenW*2, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:self.shelfVC.view];
    [self.scrollView addSubview:self.collectVC.view];
    [self.scrollView addSubview:self.offLineVC.view];
}

#pragma mark - 分段控制器点击方法


- (void)segmentControlAction:(UISegmentedControl *)sender
{
    [self.scrollView setContentOffset:CGPointMake(sender.selectedSegmentIndex * self.scrollView.frame.size.width, 0) animated:NO];
    
}

#pragma mark - SDCycleScrollViewDelegate(轮播图的点击方法)

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
}

@end