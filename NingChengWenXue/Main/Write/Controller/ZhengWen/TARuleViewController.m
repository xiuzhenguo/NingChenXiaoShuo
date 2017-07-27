//
//  TARuleViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "TARuleViewController.h"
#import "TARuleTableViewCell.h"
#import "ViewModel.h"

@interface TARuleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *footerView;

@end

@implementation TARuleViewController

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
    self.title = @"征文详情";
    
    [self setUpNavButtonUI];
    
    [self setUpTableViewUI];
}

#pragma mark - 创建TableView
- (void) setUpTableViewUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    self.tableView.backgroundColor = BXColor(242, 242, 242);
    
    [self.tableView registerClass:[TARuleTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 130)];
    imgView.image = [UIImage imageNamed:@"上首页_3"];
    self.tableView.tableHeaderView = imgView;
    
    [self setUpTableFooterViewUI];
}

#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - tableViewCell设置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TARuleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ViewModel *model = [[ViewModel alloc] init];
    cell.viewModel = model;
    
    tableView.rowHeight = cell.height;
    
    return cell;
}

#pragma mark - 创建tableView尾视图
- (void) setUpTableFooterViewUI {
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 110)];
    self.footerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *shuLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, 3, 16)];
    shuLab.backgroundColor = BXColor(236,105,65);
    [self.footerView addSubview:shuLab];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shuLab.frame)+5, 0, 200, 43.5)];
    nameLab.font = [UIFont boldSystemFontOfSize:16];
    nameLab.textColor = BXColor(40, 40, 40);
    nameLab.text = @"征文时间";
    [self.footerView addSubview:nameLab];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 43.5, BXScreenW, 0.5)];
    lineLab.backgroundColor = BXColor(242, 242, 242);
    [self.footerView addSubview:lineLab];
    
    UILabel *tougaoLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 59, BXScreenW, 15)];
    tougaoLab.font = THIRDFont;
    tougaoLab.textColor = BXColor(40, 40, 40);
    tougaoLab.text = @"投稿时间：2017.2.3-2023.4.32";
    [self.footerView addSubview:tougaoLab];
    
    UILabel *pingxuanLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 79, BXScreenW, 15)];
    pingxuanLab.font = THIRDFont;
    pingxuanLab.textColor = BXColor(40, 40, 40);
    pingxuanLab.text = @"评选时间：2017.2.3-2023.4.32（遇节假日顺延）";
    [self.footerView addSubview:pingxuanLab];
    
    self.tableView.tableFooterView = self.footerView;
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
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 30);
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [rightBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark - 右侧分享按钮的点击事件
-(void) clickRightButton {
    
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
