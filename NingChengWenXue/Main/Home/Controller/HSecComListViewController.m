//
//  HSecComListViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HSecComListViewController.h"
#import "HComListTableViewCell.h"
#import "HSecDetailViewController.h"
#import "HSecWriteViewController.h"
#import "ShuPingListModel.h"
#import "NCHomePageHelper.h"

@interface HSecComListViewController ()<UITableViewDelegate, UITableViewDataSource, PassSecValueDelegate,AddSecShuPingDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *footBtn;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) EmptyDataView *emptyView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pagenum;

@end

@implementation HSecComListViewController

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
    self.pagenum = 1;
    
    // 添加TableView
    [self setUpTableViewUI];
    // 添加底部评论按钮
    [self setUpFootButtonUI];
    
    [self getNovelSectionListData];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getNovelSectionListData];
    
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getNovelSectionListData];
    
}

#pragma mark - 创建TableView
- (void) setUpTableViewUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 64 - 44) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    self.tableView.estimatedRowHeight = 80;
    [self.tableView registerClass:[HComListTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


#pragma mark - tableViewCell设置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HComListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ShuPingListModel *model = self.dataArray[indexPath.row];
    cell.viewModel = model;
    [cell.zanBtn setTitle:[NSString stringWithFormat:@"%ld",model.Applaud] forState:UIControlStateNormal];
    [cell.comBtn setTitle:[NSString stringWithFormat:@"%ld",model.Reply] forState:UIControlStateNormal];
    cell.zanBtn.tag = 1000 + indexPath.row;
    [cell.zanBtn addTarget:self action:@selector(clickZanButton:) forControlEvents:UIControlEventTouchUpInside];
    
    tableView.rowHeight = cell.height;
    return cell;
}

#pragma mark - 点赞与取消赞功能的实现
-(void) clickZanButton:(UIButton *)sender {
    if (kUserLogin == NO) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    ShuPingListModel *model = self.dataArray[sender.tag - 1000];
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper clickShuPingWithPostId:model.Id UserId:kUserID success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [self.view hideHubWithActivity];
            [SVProgressHUD showSuccessWithStatus:@"成功"];
            if (sender.selected) {
                model.IsApplaud = 0;
                model.Applaud = model.Applaud - 1;
            }else{
                model.IsApplaud = 1;
                model.Applaud = model.Applaud + 1;
            }
            [self.tableView reloadData];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [SVProgressHUD showSuccessWithStatus:@"失败"];
    }];
}

#pragma mark - tableViewCell点击事件跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HSecDetailViewController *vc = [[HSecDetailViewController alloc] init];
    ShuPingListModel *model = self.dataArray[indexPath.row];
    vc.row = indexPath.row;
    vc.delegate = self;
    vc.secID = model.Id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)passTrendValues:(NSInteger)row zancount:(NSInteger)count pinglun:(NSInteger)pinglun type:(NSInteger)type{
    ShuPingListModel *model = self.dataArray[row];
    model.Applaud = count;
    model.IsApplaud = type;
    model.Reply = pinglun;
    [self.tableView reloadData];
}

#pragma mark - 创建底部评论按钮
-(void) setUpFootButtonUI {
    self.footBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, BXScreenH - 44 - 64, BXScreenW, 44)];
    self.footBtn.backgroundColor = BXColor(242,242,242);
    [self.footBtn setImage:[UIImage imageNamed:@"评论-(1)"] forState:UIControlStateNormal];
    [self.footBtn setTitle:@"评论本章节" forState:UIControlStateNormal];
    self.footBtn.titleLabel.font = FIFFont;
    [self.footBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    [self.view addSubview:self.footBtn];
    [self.footBtn addTarget:self action:@selector(clickFootButton) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 评论本作品的点击事件
-(void) clickFootButton {
    if (kUserLogin == NO) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    HSecWriteViewController *vc = [[HSecWriteViewController alloc] init];
    vc.bookID = self.novelID;
    vc.secID = self.secID;
    vc.SectionIndex = self.SectionIndex;
    vc.SectionName = self.SectionName;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 添加书评成功后的回调
- (void)addShupingModel:(ShuPingListModel *)model{
    if (self.dataArray.count == 0) {
        [self.emptyView removeFromSuperview];
    }
    [self.dataArray insertObject:model atIndex:0];
    [self.tableView reloadData];
}

#pragma mark - 章节评论的获取
-(void) getNovelSectionListData {
    NSString *userId = @"00000000-0000-0000-0000-000000000000";
    if (kUserLogin == YES) {
        userId = kUserID;
    }
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper sectionNovelPinglunListWithFictionId:self.novelID SectionId:self.secID UserId:userId PageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] success:^(NSArray *response) {
        st_dispatch_async_main(^{
            if (self.pagenum == 1) {
                self.dataArray = [[NSMutableArray alloc] init];
            }
            for (int i=0; i<response.count; i++) {
                ShuPingListModel *model = [ShuPingListModel mj_objectWithKeyValues:response[i]];
                
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
            [self getNovelSectionListData];
        }];
    }];
}

@end
