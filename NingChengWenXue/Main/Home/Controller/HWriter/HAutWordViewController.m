//
//  HAutWordViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/30.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAutWordViewController.h"
#import "HAutWordTableViewCell.h"
#import "LeaveMessageModel.h"
#import "HAutWordDetailViewController.h"
#import "HAutWriteViewController.h"
#import "NCHomePageHelper.h"

@interface HAutWordViewController ()<UITableViewDelegate, UITableViewDataSource, AddLeaveMessageDelegate,PassLeaveMessageValueDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *footBtn;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) EmptyDataView *emptyView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pagenum;

@end

@implementation HAutWordViewController

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
    self.title = @"留言板";
    self.pagenum = 1;
    
    [self setUpNavButtonUI];
    
    [self setUpFootButtonUI];
    
    [self setUpTableViewUI];
    
    [self getLeaveMessageListData];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getLeaveMessageListData];
    
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getLeaveMessageListData];
    
}

#pragma mark - 创建TableView
- (void) setUpTableViewUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 64 - 44) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[HAutWordTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


#pragma mark - tableViewCell设置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HAutWordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 测试时
    
    LeaveMessageModel *model = self.dataArray[indexPath.row];
    cell.viewModel = model;
    
    tableView.rowHeight = cell.height;
    return cell;
}

#pragma mark - tableViewCell点击事件跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LeaveMessageModel *model = self.dataArray[indexPath.row];
    HAutWordDetailViewController *vc = [[HAutWordDetailViewController alloc] init];
    vc.leaveId = model.Id;
    vc.row = indexPath.row;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)passLeaveMessageValues:(NSInteger)row pinglun:(NSInteger)pinglun{
    LeaveMessageModel *model = self.dataArray[row];
    model.ReplyCount = pinglun;
    [self.tableView reloadData];
}

#pragma mark - 创建底部评论按钮
-(void) setUpFootButtonUI {
    self.footBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, BXScreenH - 44 - 64, BXScreenW, 44)];
    self.footBtn.backgroundColor = BXColor(242,242,242);
    [self.footBtn setImage:[UIImage imageNamed:@"评论-(1)"] forState:UIControlStateNormal];
    [self.footBtn setTitle:@"添加留言" forState:UIControlStateNormal];
    self.footBtn.titleLabel.font = FIFFont;
    [self.footBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    [self.view addSubview:self.footBtn];
    [self.footBtn addTarget:self action:@selector(clickFootCommentBuuton) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 跳入添加留言页面
-(void) clickFootCommentBuuton {
    if (kUserLogin == NO) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    HAutWriteViewController *vc = [[HAutWriteViewController alloc] init];
    vc.authorId = self.authorId;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 添加留言成功后的回调
- (void)addShupingModel:(LeaveMessageModel *)model{
    if (self.dataArray.count == 0) {
        [self.emptyView removeFromSuperview];
    }
    [self.dataArray insertObject:model atIndex:0];
    [self.tableView reloadData];
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

#pragma mark - 留言集合的获取
-(void) getLeaveMessageListData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper leacveYanWithUserId:self.authorId PageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] success:^(NSArray *response) {
        st_dispatch_async_main(^{
            if (self.pagenum == 1) {
                self.dataArray = [[NSMutableArray alloc] init];
            }
            for (int i=0; i<response.count; i++) {
                LeaveMessageModel *model = [LeaveMessageModel mj_objectWithKeyValues:response[i]];
                
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
            [self getLeaveMessageListData];
        }];
    }];
}

@end
