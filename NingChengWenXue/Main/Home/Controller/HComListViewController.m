//
//  HComListViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HComListViewController.h"
#import "HAllComListViewController.h"
#import "HSecComListViewController.h"
#import "HNewestTypeView.h"

@interface HComListViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HAllComListViewController *allComContoller;
@property (nonatomic, strong) HSecComListViewController *secComController;

@property (nonatomic, assign) NSInteger segIndex;
@property (nonatomic, strong) HNewestTypeView *typeView;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, assign) NSInteger type;


@end

@implementation HComListViewController

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
    
    self.segIndex = 0;
    self.type = 1;
    
    [self setUpNavButtonUI];
    
    [self createSegmentControl];
    
    [self createScrollView];
    
    [self setUpNewestAndHotViewUI];
}

#pragma mark - 创建分段控制器
- (void) createSegmentControl{
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"章节", @"全部"]];
    self.segmentControl.frame = CGRectMake(0, 0, 152, 29);
    [self.segmentControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:(UIControlEventValueChanged)];
    self.segmentControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = self.segmentControl;
    
    self.segmentControl.backgroundColor = [UIColor whiteColor];
    self.segmentControl.tintColor = BXColor(236,105,65);
    // 正常状态下
    NSDictionary * normalTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15.0f],NSForegroundColorAttributeName : BXColor(236,105,65)};
    [self.segmentControl setTitleTextAttributes:normalTextAttributes forState:UIControlStateNormal];
    // 选中状态下
    NSDictionary * selctedTextAttributes = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:15.0f],NSForegroundColorAttributeName : [UIColor whiteColor]};
    [self.segmentControl setTitleTextAttributes:selctedTextAttributes forState:UIControlStateSelected];
    
}

#pragma mark - 创建scrollView
- (void) createScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 64)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.scrollEnabled = NO;
    self.scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width * 2, self.view.bounds.size.height);
    
    self.allComContoller = [[HAllComListViewController alloc] init];
    self.secComController = [[HSecComListViewController alloc] init];
    self.allComContoller.novelID = self.bookID;
    self.secComController.novelID = self.bookID;
    self.secComController.secID = self.secID;
    self.secComController.SectionIndex = self.SectionIndex;
    self.secComController.SectionName = self.SectionName;
    [self addChildViewController:self.secComController];
    [self addChildViewController:self.allComContoller];
    
    self.secComController.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    self.allComContoller.view.frame = CGRectMake(BXScreenW, 0, self.scrollView.frame.size.width, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView addSubview:self.secComController.view];
    [self.scrollView addSubview:self.allComContoller.view];
    
    
//    self.scrollView.delegate = self;
}

#pragma mark - 分段控制器点击方法


- (void)segmentedControlAction:(UISegmentedControl *)sender
{
    [self.scrollView setContentOffset:CGPointMake(sender.selectedSegmentIndex * self.scrollView.frame.size.width, 0) animated:NO];
    if (sender.selectedSegmentIndex == 1) {
        self.segIndex = 1;
        [self setUpRightButton];
        self.segmentControl.selectedSegmentIndex = 1;
    }else{
        self.segIndex = 0;
        [self setUpRightButton];
        self.segmentControl.selectedSegmentIndex = 0;
    }

}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    NSInteger n = scrollView.contentOffset.x / scrollView.frame.size.width;
//    self.segmentControl.selectedSegmentIndex = n;
//    //    [self.searchbar resignFirstResponder];
//}

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

-(void) setUpRightButton {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 100, 30);
    if (self.type == 1) {
        [rightBtn setTitle:@"最新" forState:UIControlStateNormal];
    }else{
        [rightBtn setTitle:@"最热" forState:UIControlStateNormal];
    }
    
    [rightBtn setImage:[UIImage imageNamed:@"三角-2"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -rightBtn.imageView.size.width+5, 0, rightBtn.imageView.size.width)];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, rightBtn.titleLabel.bounds.size.width, 0, -rightBtn.titleLabel.bounds.size.width-5)];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
    self.rightBtn = rightBtn;
    if (self.segIndex == 1) {
        rightBtn.hidden = NO;
//        self.typeView.hidden = NO;
    }else{
        rightBtn.hidden = YES;
        self.typeView.hidden = YES;
    }

}

#pragma mark - 最新最热视图的创建
- (void) setUpNewestAndHotViewUI{
    _typeView = [[HNewestTypeView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    _typeView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_typeView];
    _typeView.hidden = YES;
    
    [_typeView.newestBtn addTarget:self action:@selector(clicktypeNewButton) forControlEvents:UIControlEventTouchUpInside];
    [_typeView.hostBtn addTarget:self action:@selector(clicktypeHotButton) forControlEvents:UIControlEventTouchUpInside];
}

-(void) clicktypeNewButton{
    self.allComContoller.index = 1;
    [self.rightBtn setTitle:@"最新" forState:UIControlStateNormal];
    [self.allComContoller viewWillAppear:YES];
    [self.typeView viewHiddenAnimation:YES];
    self.type = 1;
}

-(void) clicktypeHotButton {
    self.allComContoller.index = 2;
    [self.rightBtn setTitle:@"最热" forState:UIControlStateNormal];
    [self.allComContoller viewWillAppear:YES];
    [self.typeView viewHiddenAnimation:YES];
    self.type = 2;
}

#pragma mark - 最新按钮的点击事件的实现
-(void)rightNavBtnAction:(UIButton *)sender{
    NSLog(@"最新");
    [self.typeView viewShowAnimation:YES];
}


#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
