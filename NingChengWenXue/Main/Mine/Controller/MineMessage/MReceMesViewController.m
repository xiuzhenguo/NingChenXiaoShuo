//
//  MReceMesViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/15.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "MReceMesViewController.h"
#import "MReceMessListTableViewCell.h"
#import "BCWelcomHepler.h"
#import "InboxListModel.h"
#import "MRecDetailViewController.h"

@interface MReceMesViewController () <UITableViewDelegate, UITableViewDataSource,ReceiveMessageDelegate>

@property (nonatomic, strong) EmptyDataView *emptyView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (strong, nonatomic) BCWelcomHepler *helper;
@property (nonatomic, assign) NSInteger pagenum;

@end

@implementation MReceMesViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.pagenum = 1;
    
    [self setUpTableViewUI];
    
    [self getReciveMessageListData];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getReciveMessageListData];
    
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getReciveMessageListData];
    
}

#pragma mark - 创建TableView
- (void) setUpTableViewUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 9, BXScreenW, BXScreenH - 64 - 39) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = BXColor(242, 242, 242);
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[MReceMessListTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark - tableViewCell设置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MReceMessListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    InboxListModel *model = self.dataArray[indexPath.row];
    
    cell.timeLab.text = model.Time;
    cell.nameLab.text = model.Title;
    cell.perLab.text = model.SendName;
    if (model.IsRead == true) {
        cell.imgView.image = [UIImage imageNamed:@"已读"];
    }else{
        cell.imgView.image = [UIImage imageNamed:@"邮件"];
    }
    
    return cell;
}

#pragma mark - 跳转收件箱详情页
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MRecDetailViewController *vc = [[MRecDetailViewController alloc] init];
    InboxListModel *model = self.dataArray[indexPath.row];
    vc.msgId = model.Id;
    vc.type = model.MessageGener;
    vc.row = indexPath.row;
    vc.sendId = model.SendId;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 详情页返回代理方法
- (void)receiveMessageDelegate:(NSInteger)row{
    InboxListModel *model = self.dataArray[row];
    model.IsRead = true;
    [self.tableView reloadData];
}

#pragma mark - 收件箱集合数据的获取
-(void)getReciveMessageListData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper receivedMessageBoxListWithUserId:kUserID PageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] successs:^(NSArray *response) {
        
        st_dispatch_async_main(^{
            if (self.pagenum == 1) {
                self.dataArray = [[NSMutableArray alloc] init];
            }
            
            for (int i=0; i<response.count; i++) {
                InboxListModel *model = [InboxListModel mj_objectWithKeyValues:response[i]];
                
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
            
            [self getReciveMessageListData];
        }];
    }];
}

@end
