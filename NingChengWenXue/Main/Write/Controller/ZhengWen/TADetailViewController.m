//
//  TADetailViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "TADetailViewController.h"
#import "TAWanJieHeaderView.h"
#import "TAWanJIeTableViewCell.h"
#import "TARuleViewController.h"
#import "NCWriteHelper.h"
#import "ZhengWenListModel.h"
#import "ZWDetailModel.h"

@interface TADetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TAWanJieHeaderView *headerView;
@property (strong, nonatomic) NCWriteHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation TADetailViewController

-(NCWriteHelper *)helper{
    if (!_helper) {
        _helper = [NCWriteHelper helper];
    }
    return _helper;
}

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
    
    [self getZhengWenDetailData];
}

#pragma mark - 创建TableView
- (void) setUpTableViewUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 64) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TAWanJIeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark - 创建tableView 头视图
-(void) setUpTableHeaderViewUI {
    self.headerView = [[TAWanJieHeaderView alloc] init];
    ZhengWenListModel *model = self.dataArray.firstObject;
    self.headerView.model = model;
    self.headerView.frame = CGRectMake(0, 0, BXScreenW, self.headerView.height);
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
    
    [self.headerView.btn addTarget:self action:@selector(clickRuleButton) forControlEvents:UIControlEventTouchUpInside];
}

-(void) clickRuleButton {
    TARuleViewController *vc = [[TARuleViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark - tableViewCell设置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TAWanJIeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.nameLab.font = [UIFont boldSystemFontOfSize:15];
    
    return cell;
}

#pragma mark - 分区头设置
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 46;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 46)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 3, 16)];
    lab.backgroundColor = BXColor(236,105,65);
    [backView addSubview:lab];
    
    NSArray *rankArray = @[@"一等奖",@"二等奖",@"三等奖"];
    UILabel *rankLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+15, 0, 240, 45.5)];
    rankLab.text = rankArray[section];
    rankLab.font = [UIFont systemFontOfSize:17];
    rankLab.textColor = BXColor(40,40,40);
    [backView addSubview:rankLab];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 0.5)];
    lineLab.backgroundColor = BXColor(242, 242, 242);
    [backView addSubview:lineLab];
    
    return backView;
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

#pragma mark - 征文详情获取
-(void) getZhengWenDetailData {
    NSString *userId = @"00000000-0000-0000-0000-000000000000";
    if (kUserLogin == YES) {
        userId = kUserID;
    }
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper zhengWenDetailWithID:self.ficID UserId:userId success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
           
            ZhengWenListModel *model = [ZhengWenListModel mj_objectWithKeyValues:response];
            
            [self.dataArray addObject:model];
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self.tableView reloadData];
            [self setUpTableHeaderViewUI];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.tableView.mj_header endRefreshing];
        [self.view showFailedViewReloadBlock:^{
            [self getZhengWenDetailData];
        }];
    }];
}

@end
