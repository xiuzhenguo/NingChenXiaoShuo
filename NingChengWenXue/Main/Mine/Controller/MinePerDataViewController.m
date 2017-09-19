//
//  MinePerDataViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/15.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "MinePerDataViewController.h"
#import "MinePerDataTableViewCell.h"
#import "BCWelcomHepler.h"
#import "MineInforModel.h"
#import "MinePerInfoHeaderView.h"

@interface MinePerDataViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (strong, nonatomic) BCWelcomHepler *helper;
@property (nonatomic, strong) MinePerInfoHeaderView *headerView;

@end

@implementation MinePerDataViewController

-(BCWelcomHepler *)helper{
    if (!_helper) {
        _helper = [BCWelcomHepler helper];
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
    self.view.backgroundColor = BXColor(242, 242, 242);
    self.title = @"个人资料";
    self.nameArray = @[@[@"UUID:",@"昵称:",@"手机:"],@[@"级别:",@"门派:",@"卡片:",@"活动:",@"勋章:",@"地址:"]];
    [self setUpNavButtonUI];
    [self setUpTableViewUI];
    [self getPersonInformationData];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    [self getPersonInformationData];
    
}

#pragma mark - tableView视图的创建
-(void)setUpTableViewUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[MinePerDataTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.headerView = [[MinePerInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 105)];
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else{
        return 6;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark - 分区尾设置
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 10)];
    backView.backgroundColor = BXColor(242, 242, 242);
    
    return backView;
}

#pragma mark - TableViewCell的设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MinePerDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.nameLab.text = self.nameArray[indexPath.section][indexPath.row];
    cell.conLab.text = self.dataArray[indexPath.section][indexPath.row];
    
    return cell;
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

#pragma mark - 个人资料数据的获取
-(void)getPersonInformationData{
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper minePersonInformationWithUserId:kUserID success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            self.dataArray = [[NSMutableArray alloc] init];
            NSMutableArray *oneArray = [[NSMutableArray alloc] init];
            NSMutableArray *secArray = [[NSMutableArray alloc] init];
            MineInforModel *model = [MineInforModel mj_objectWithKeyValues:response];
            [oneArray addObject:model.UUID];
            [oneArray addObject:model.UserName];
            [oneArray addObject:model.UserPhone];
            [secArray addObject:[NSString stringWithFormat:@"%ld",model.Lv]];
            [secArray addObject:model.UserMartial];
            [secArray addObject:[NSString stringWithFormat:@"%ld",model.UserCardCount]];
            [secArray addObject:[NSString stringWithFormat:@"%ld",model.UserEnergy]];
            [secArray addObject:[NSString stringWithFormat:@"%ld",model.UserMedalCount]];
            [secArray addObject:model.UserAddress];
            [self.dataArray addObject:oneArray];
            [self.dataArray addObject:secArray];
            
            self.headerView.UULab.text = [NSString stringWithFormat:@"%ld",model.UUPoint];
            self.headerView.monLab.text = [NSString stringWithFormat:@"%ld",model.MMPoint];
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.view showFailedViewReloadBlock:^{
            
            [self getPersonInformationData];
        }];
    }];
}

@end
