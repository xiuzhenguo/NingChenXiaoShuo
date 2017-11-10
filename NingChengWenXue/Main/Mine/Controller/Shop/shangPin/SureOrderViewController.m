
//
//  SureOrderViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/11/3.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "SureOrderViewController.h"
#import "OrderCardTableViewCell.h"
#import "OrderTableViewCell.h"
#import "OrderHeader.h"

@interface SureOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OrderHeader *headeView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *priceLab;

@end

@implementation SureOrderViewController

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
    self.title = @"确认订单";
    
    [self setUpUITableViewUI];
    [self setUpNavButtonUI];
    [self setUpFootApplyButtonUI];
}

#pragma mark - UITableView视图的创建
-(void)setUpUITableViewUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - kTopHeight - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = BXColor(242, 242, 242);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[OrderCardTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:@"cell1"];
    
    [self setUpTableHeaderViewUI];
}

#pragma mark - UITableView头视图的设置
-(void)setUpTableHeaderViewUI{
    self.headeView = [[OrderHeader alloc] init];
    self.headeView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headeView;
    self.headeView.frame = CGRectMake(0, 0, BXScreenW, self.headeView.height);
}

#pragma mark - UITableViewCell设置
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 2;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 137;
    }else{
        return 44;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (indexPath.section == 0) {
        
        OrderCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        cell.currentCountNumber = 1;
        cell.viewModel = [[ViewModel alloc] init];
        
        return cell;
    }else{
        OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.titleLab.text = @"价格";
        cell.priceLab.text = @"￥ 0";
        return cell;
    }
}

#pragma mark - 分区头、分区尾设置
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 45;
    }else{
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 5)];
    header.backgroundColor = BXColor(242, 242, 242);
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 44)];
        footerView.backgroundColor = [UIColor whiteColor];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, BXScreenW - 25, 44)];
        self.textField.placeholder = @"选填:买家留言(50字)";
        self.textField.font = FIFFont;
        self.textField.textColor = BXColor(152,152,152);
        [footerView addSubview:self.textField];
        
        return footerView;
    }
    return nil;
}

#pragma mark - 底部支付按钮的点击事件
-(void)setUpFootApplyButtonUI{
    self.priceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, BXScreenH - 49 - kTopHeight, BXScreenW - 115, 49)];
    self.priceLab.font = FIFFont;
    self.priceLab.textColor = BXColor(101,101,101);
    self.priceLab.textAlignment = NSTextAlignmentRight;
    NSString *strStaus = @"￥38";
    NSString *str = [NSString stringWithFormat:@"需付：%@  ",strStaus];
    
    NSMutableAttributedString *attrDescribeStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attrDescribeStr addAttribute:NSForegroundColorAttributeName
     
                            value:BXColor(236,105,65)
     
                            range:[str rangeOfString:strStaus]];
    
    self.priceLab.attributedText = attrDescribeStr;
    [self.view addSubview:self.priceLab];
    
    UIButton *applyBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 130, BXScreenH - kTopHeight - 49, 130, 49)];
    applyBtn.backgroundColor = BXColor(236,105,65);
    [applyBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    applyBtn.titleLabel.font = FIFFont;
    [self.view addSubview:applyBtn];
    
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
