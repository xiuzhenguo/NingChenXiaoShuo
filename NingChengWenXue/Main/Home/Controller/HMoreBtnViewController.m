//
//  HMoreBtnViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/20.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HMoreBtnViewController.h"
#import "HMoreBtnTableViewCell.h"
#import "HBillboardViewController.h"
#import "HclassifyViewController.h"
#import "HBillboardViewController.h"
#import "HSchUniViewController.h"
#import "HEssenceViewController.h"
#import "HRecommendViewController.h"

@interface HMoreBtnViewController ()<UITableViewDelegate, UITableViewDataSource, HMoreBtnCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation HMoreBtnViewController

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
    
    self.view.backgroundColor = BXColor(242, 242, 242);
    self.title = @"全部";
    
    // 添加导航栏设置
    [self setUpNavButtonUI];
    // 添加collectionView
    [self setUpCollectionViewUI];
    
    // 死数据  测试用的
    self.array =@[@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""],@[@"",@"",@"",@"",@""],@[@"",@"",@""]];
    
}

#pragma mark - 创建CollectionView视图
- (void) setUpCollectionViewUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = BXColor(242,242,242);
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 135)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
    
    [self setUpTableViewHeaderViewUI];
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"cell个数%ld",[self.array[section] count]);
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"分数区%ld",self.array.count);
    return 1;
}

#pragma mark - TableViewCell的设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HMoreBtnTableViewCell * cell = [HMoreBtnTableViewCell setMyTableViewCellWithTableView:tableView];
    
    cell.delegate  = self;
    cell.section = indexPath.section;
    cell.arr       = self.array[indexPath.section];
    tableView.rowHeight = cell.height;
    
    return cell;
}

#pragma mark - 按钮的点击方法
- (void)createUIButtonWithButton:(UIButton *)button Section:(NSInteger)section{
    NSLog(@"%@",button.titleLabel.text);
    // 排行榜
    if (button.tag == 1000) {
        HBillboardViewController *vc = [[HBillboardViewController alloc] init];
        vc.typeStr = @"排行榜";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (button.tag == 1001) {
        HclassifyViewController *vc = [[HclassifyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (button.tag == 1002) {
        NSLog(@"啦啦啦");
        HBillboardViewController *vc = [[HBillboardViewController alloc] init];
        vc.typeStr = @"完本榜";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (button.tag == 1003) {
        HSchUniViewController *vc = [[HSchUniViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (button.tag == 1004) {
        HEssenceViewController *vc = [[HEssenceViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (button.tag == 1005) {
        HRecommendViewController *vc = [[HRecommendViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - tableView 头视图设置
-(void) setUpTableViewHeaderViewUI {
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 90)];
    img.image = [UIImage imageNamed:@"gengduo"];
    [self.headerView addSubview:img];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"凝尘文学";
    title.font = FIFFont;
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = BXColor(195,195,195);
    CGRect titWidth = Adaptive_Width(title.text, title.font);
    title.frame = CGRectMake(BXScreenW/2.0-titWidth.size.width/2.0 - 29, 15+90, titWidth.size.width+58, 15);
    [self.headerView addSubview:title];
    
    UILabel *leftLine = [[UILabel alloc] initWithFrame:CGRectMake(15, 22.5+90, BXScreenW/2.0 - 15 - CGRectGetWidth(title.frame)/2.0, 0.5)];
    leftLine.backgroundColor = BXColor(195,195,195);
    [self.headerView addSubview:leftLine];
    
    UILabel *rightLine = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(title.frame), 22.5+90, BXScreenW/2.0 - 15 - CGRectGetWidth(title.frame)/2.0, 0.5)];
    rightLine.backgroundColor = BXColor(195,195,195);
    [self.headerView addSubview:rightLine];
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


