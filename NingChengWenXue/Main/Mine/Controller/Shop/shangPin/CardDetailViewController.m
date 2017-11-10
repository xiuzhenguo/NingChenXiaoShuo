//
//  CardDetailViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/10/30.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CardDetailViewController.h"
#import "CardDetailTableViewCell.h"
#import "BuyCardNumberView.h"
#import "SureOrderViewController.h"

@interface CardDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) BuyCardNumberView *numberView;

@end

@implementation CardDetailViewController

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
    self.title = @"卡片类";
    self.typeArray = @[@"直接购买",@"平台购买"];
    
    [self setUpNavButtonUI];
    
    [self setUpUITableViewUI];
    
    [self setApplyButtonUI];
    
}

#pragma mark - UITableView视图的创建
-(void)setUpUITableViewUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - kTopHeight - 45) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CardDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 285)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
    
    [self setTableHeaderViewUI];
}

#pragma mark - 头视图的设置
-(void)setTableHeaderViewUI{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(BXScreenW/2.0 - 100, 20, 200, 240)];
    imgView.image = [UIImage imageNamed:@"商品-数量图"];
    [self.headerView addSubview:imgView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 280, BXScreenW, 5)];
    lineView.backgroundColor = BXColor(242, 242, 242);
    [self.headerView addSubview:lineView];
}

#pragma mark - UITableViewViewDelegate
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
// 每个分区的cell数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    CardDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell.btn addTarget:self action:@selector(cliclSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn.tag = 1000 + indexPath.row;
    if (cell.btn.selected == NO) {
        cell.imgView.image = [UIImage imageNamed:@"未选中"];
    }else{
        cell.imgView.image = [UIImage imageNamed:@"选中"];
    }
    cell.typeLab.text = self.typeArray[indexPath.row];
    cell.priceLab.text = @"¥ 100";
    
    return cell;
    
}

#pragma mark - 选择购买方式的点击事件
-(void)cliclSelectButton:(UIButton *)sender{
    for (int i = 0; i < 2; i++) {
//        ZWDetailModel *model = self.dataArray[i];
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000+i];
        if (sender.tag - 1000 == i) {
            btn.selected = YES;
            
        }else{
            btn.selected = NO;
        }
    }
    [self.tableView reloadData];
}

#pragma mark - 分区头、分区尾设置
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 45)];
    secView.backgroundColor = [UIColor whiteColor];
    
    UILabel *secLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, BXScreenW - 30, 45)];
    secLab.text = @"商品名称商品名称商品名称商品称商品";
    secLab.textColor = BXColor(40,40,40);
    secLab.numberOfLines = 0;
    secLab.font = [UIFont systemFontOfSize:18];
    [secView addSubview:secLab];
    return secView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 35)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *expressLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 15)];
    expressLab.textColor = BXColor(152,152,152);
    expressLab.font = THIRDFont;
    expressLab.text = @"快递:包邮";
    [backView addSubview:expressLab];
    
    UILabel *sumLab = [[UILabel alloc] initWithFrame:CGRectMake(225, 5, BXScreenW - 240, 15)];
    sumLab.font = THIRDFont;
    sumLab.textColor = BXColor(152,152,152);
    sumLab.textAlignment = NSTextAlignmentRight;
    sumLab.text = @"销量:100件";
    [backView addSubview:sumLab];
    
    return backView;
}

#pragma mark - 立即购买按钮的设置
-(void)setApplyButtonUI{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, BXScreenH - kTopHeight - 45, BXScreenW, 45)];
    btn.backgroundColor = BXColor(236,105,65);
    [btn setTitle:@"立即购买" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBuyButton) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = FIFFont;
    [self.view addSubview:btn];
}

#pragma mark - 立即按钮的点击事件
-(void)clickBuyButton{
    self.numberView = [[BuyCardNumberView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    
    [self.view.window addSubview:self.numberView];
    [self.numberView.sureBtn addTarget:self action:@selector(clickSureButton) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 点击BuyCardNumberView确定按钮的点击事件
-(void)clickSureButton{
    [self.numberView removeFromSuperview];
    SureOrderViewController *vc = [[SureOrderViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
