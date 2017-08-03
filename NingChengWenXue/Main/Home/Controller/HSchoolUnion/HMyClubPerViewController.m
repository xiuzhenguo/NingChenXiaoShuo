//
//  HMyClubPerViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HMyClubPerViewController.h"
#import "HMyClubPerTableViewCell.h"
#import "NCHomePageHelper.h"
#import "UserItemModel.h"
#import "UnionModel.h"
#import "HAuthorsViewController.h"

@interface HMyClubPerViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pagenum;
@property (nonatomic, strong) EmptyDataView *emptyView;
@property (nonatomic, assign) NSInteger roleStr;

@end

@implementation HMyClubPerViewController

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
    self.title = @"社团成员";
    self.pagenum = 1;
    // 添加导航栏
    [self setUpNavButtonUI];
    // 添加tableView
    [self setUpUITableViewUI];
    
    [self getCommunityPersonData];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getCommunityPersonData];
    
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getCommunityPersonData];
    
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
    [self.tableView registerClass:[HMyClubPerTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UItableViewcell 的个数及cell的设置
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

#pragma mark - tableViewCell设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HMyClubPerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UserItemModel *model = self.dataArray[indexPath.row];
    cell.row = indexPath.row;
    cell.role = self.roleStr;
    cell.viewModel = model;
    cell.btn.tag = 1000 +indexPath.row;
    cell.deleteBtn.tag = 10000 + indexPath.row;
    [cell.btn addTarget:self action:@selector(clickGunliButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.deleteBtn addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

#pragma mark - tableViewCell的点击事件(跳转作者页面)
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserItemModel *model = self.dataArray[indexPath.row];
    HAuthorsViewController *vc = [[HAuthorsViewController alloc] init];
    vc.autherID = model.UserId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 设置管理按钮的点击事件
-(void)clickGunliButton:(UIButton *)sender{
    UserItemModel *model = self.dataArray[sender.tag - 1000];
    NSInteger role = 2;
    if (model.UserRole == 2) {
        role = 3;
    }else{
        role = 2;
    }
    [self.helper shezhiCommunityRoleWithUserId:model.UserId CommunityId:self.communityID OptionId:kUserID Role:[NSString stringWithFormat:@"%ld",role] success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [self.view hideHubWithActivity];
            [SVProgressHUD showSuccessWithStatus:@"成功"];
            if (sender.selected) {
                model.UserRole = 3;
            }else{
                model.UserRole = 2;
            }
            [self.tableView reloadData];
        });
        
        return ;
        
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"失败"];
    }];
}

#pragma mark - 删除社团成员
-(void)clickDeleteButton:(UIButton *)sender{
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"" message:@"是否删除社团成员" preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(alertControl) wAlert = alertControl;
    [wAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        // 点击确定按钮的时候, 会调用这个block
        UserItemModel *model = self.dataArray[sender.tag - 10000];
        [self.helper removeCommunityPersonWithUserId:model.UserId CommunityId:self.communityID OptionId:kUserID success:^(NSDictionary *response) {
            st_dispatch_async_main(^{
                [self.view hideHubWithActivity];
                [SVProgressHUD showSuccessWithStatus:@"成功"];
                [self.dataArray removeObjectAtIndex:sender.tag - 10000];
                [self.tableView reloadData];
            });
            
            return ;
            
        } faild:^(NSString *response, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }];
        
    }]];
    
    [wAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:wAlert animated:YES completion:nil];
    
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

#pragma mark - 社团成员的获取
-(void) getCommunityPersonData {
   
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper getCommunityPersonWithID:self.communityID UserId:kUserID PageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            if (self.pagenum == 1) {
                self.dataArray = [[NSMutableArray alloc] init];
            }
            UnionModel *model = [UnionModel mj_objectWithKeyValues:response];
            self.roleStr = model.Role;
            
            for (int i = 0; i < model.CommunityUserList.count; i++) {
                UserItemModel *list = [UserItemModel mj_objectWithKeyValues:model.CommunityUserList[i]];
                [self.dataArray addObject:list];
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
            [self getCommunityPersonData];
        }];
    }];
}

@end
