//
//  HCatalogueViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/24.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HCatalogueViewController.h"
#import "HCatalogueTableViewCell.h"
#import "HReadPageViewController.h"
#import "NCHomePageHelper.h"
#import "MuLuListModel.h"

@interface HCatalogueViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) EmptyDataView *emptyView;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation HCatalogueViewController

-(NCHomePageHelper *)helper{
    if (!_helper) {
        _helper = [NCHomePageHelper helper];
    }
    return _helper;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;//不设置为黑色背景
    
    self.pageNum = 1;
    [self getNovelMuluListData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BXColor(242,242,242);
    self.title = @"章节目录";
    
    // 添加导航栏按钮
    [self setUpNavButtonUI];
    // 添加TableView
    [self setUpTableViewUI];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pageNum = 1;
    [self getNovelMuluListData];
    
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pageNum++;
    [self getNovelMuluListData];
    
}

#pragma mark - 创建TableView
- (void) setUpTableViewUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH- 64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[HCatalogueTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


#pragma mark - tableViewCell设置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HCatalogueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    MuLuListModel *model = self.dataArray[indexPath.row];
    cell.viewModel = model;
    
    tableView.rowHeight = 49;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MuLuListModel *model = self.dataArray[indexPath.row];
    HReadPageViewController *vc = [[HReadPageViewController alloc] init];
    vc.bookId = self.bookID;
    vc.secID = model.SectionId;
    vc.SectionName = model.SectionName;
    vc.SectionIndex = model.SectionIndex;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 目录数据的获取
-(void) getNovelMuluListData {
    
    NSString *userId = @"00000000-0000-0000-0000-000000000000";
    if (kUserLogin == YES) {
        userId = kUserID;
    }
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper novelMuluListWithID:self.bookID UserId:userId PageIndex:[NSString stringWithFormat:@"%ld",self.pageNum] success:^(NSArray *response) {
        st_dispatch_async_main(^{
            if (self.pageNum == 1) {
                self.dataArray = [[NSMutableArray alloc] init];
            }
            for (int i=0; i<response.count; i++) {
                MuLuListModel *model = [MuLuListModel mj_objectWithKeyValues:response[i]];
                
                [self.dataArray addObject:model];
                
            }
            if(self.dataArray.count == 0 && self.pageNum == 1){
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
//            [self.view showActivityWithImage:kLoadingImage];
            [self getNovelMuluListData];
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
    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 0, 100, 30);
//    [rightBtn setTitle:@"离线作品" forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
//    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//#pragma mark - 离线作品按钮的点击事件的实现
//-(void)rightNavBtnAction:(UIButton *)sender{
//    NSLog(@"离线作品");
//}


@end
