//
//  MRecDetailViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/18.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "MRecDetailViewController.h"
#import "MSenddetailTableViewCell.h"
#import "BCWelcomHepler.h"
#import "BoxdetailModel.h"

@interface MRecDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) BCWelcomHepler *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *arr;

@end

@implementation MRecDetailViewController

-(BCWelcomHepler *)helper{
    if (!_helper) {
        _helper = [BCWelcomHepler helper];
    }
    return _helper;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"收件";
    self.arr = @[@"收件人",@"标  题",@"时  间",@"内  容"];
    
    [self setUpNavButtonUI];
    
    [self setUpTableViewUI];
    
    [self getSendMessageDetailData];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    
    [self getSendMessageDetailData];
    
}

#pragma mark - 创建TableView
- (void) setUpTableViewUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = BXColor(242, 242, 242);
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[MSenddetailTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


#pragma mark - tableViewCell设置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MSenddetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.nameStr = _arr[indexPath.row];
    cell.viewModel  = self.dataArray[indexPath.row];
    tableView.rowHeight = cell.height;
    
    return cell;
}


-(void)getSendMessageDetailData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper receivedMessageBoxDetailWithUserId:kUserID MsgId:self.msgId MsgGener:self.type success:^(NSDictionary *response) {
        
        st_dispatch_async_main(^{
            
            self.dataArray = [[NSMutableArray alloc] init];
            
            BoxdetailModel *model = [BoxdetailModel mj_objectWithKeyValues:response];
            
            [self.dataArray addObject:model.SendName];
            [self.dataArray addObject:model.Title];
            [self.dataArray addObject:model.Time];
            [self.dataArray addObject:model.Content];
            
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
            
            [self getSendMessageDetailData];
        }];
    }];
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
