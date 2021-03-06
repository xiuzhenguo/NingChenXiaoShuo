//
//  HMyClubListViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/13.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HMyClubListViewController.h"
#import "HSchUniTableViewCell.h"
#import "HMyClubViewController.h"
#import "UnionHomeModel.h"
#import "NCHomePageHelper.h"

@interface HMyClubListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pagenum;
@property (nonatomic, strong) EmptyDataView *emptyView;

@end

@implementation HMyClubListViewController

-(NCHomePageHelper *)helper{
    if (!_helper) {
        _helper = [NCHomePageHelper helper];
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
    self.title = @"我的社团";
    self.pagenum = 1;
    
    [self setUpNavButtonUI];
    
    [self setUpUITableViewUI];
    
    [self getMineCommunityData];
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getMineCommunityData];
    
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getMineCommunityData];
    
}

#pragma mark - 创建UITableView视图
-(void) setUpUITableViewUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH-64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[HSchUniTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UItableViewcell 的个数及cell的设置
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

#pragma mark - tableViewCell设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HSchUniTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UnionHomeModel *model = self.dataArray[indexPath.row];
    cell.viewModel = model;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HMyClubViewController *vc = [[HMyClubViewController alloc] init];
    UnionHomeModel *model = self.dataArray[indexPath.row];
    vc.comId = model.Id;
    vc.title = model.CommunityName;
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

#pragma mark - 我的社团数据的获取
-(void) getMineCommunityData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper getMineCommunityWithUserId:kUserID PageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] success:^(NSArray *response) {
        st_dispatch_async_main(^{
            
            if (self.pagenum == 1) {
                self.dataArray = [[NSMutableArray alloc] init];
            }
            for (int i=0; i<response.count; i++) {
                UnionHomeModel *model = [UnionHomeModel mj_objectWithKeyValues:response[i]];
                
                [self.dataArray addObject:model];
                
            }
            if(self.dataArray.count == 0 && self.pagenum == 1){
                [self.emptyView removeFromSuperview];
                self.emptyView = [[EmptyDataView alloc]initWithFrame:self.view.bounds title:@"没有数据" actionTitle:nil];
                [self.tableView addSubview:self.emptyView];
                
            }else{
                [self.emptyView removeFromSuperview];
            }
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
            
            [self getMineCommunityData];
        }];
    }];
}

@end
