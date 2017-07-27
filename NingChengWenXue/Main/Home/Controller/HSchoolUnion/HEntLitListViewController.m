//
//  HEntLitListViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/8.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HEntLitListViewController.h"
#import "HEntLitListTableViewCell.h"
#import "HLitDetailViewController.h"
#import "HSchSearchViewController.h"
#import "NCHomePageHelper.h"
#import "UnionHomeModel.h"
#import "UnionModel.h"

@interface HEntLitListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *rightBtn;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pagenum;
@property (nonatomic, strong) EmptyDataView *emptyView;

@end

@implementation HEntLitListViewController

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
    
    self.title = @"实体文学社";
    
    self.pagenum = 1;
    // 添加导航栏按钮
    [self setUpNavButtonUI];
    // 添加tableView
    [self setUpUITableViewUI];
    
    [self getDataList];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getDataList];
    
}
#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getDataList];
    
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
    [self.tableView registerClass:[HEntLitListTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UItableViewcell 的个数及cell的设置
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    UnionModel *listModel = self.dataArray.firstObject;
    return listModel.CommunityIndexList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

#pragma mark - tableViewCell设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HEntLitListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UnionModel *listModel = self.dataArray.firstObject;
    UnionHomeModel *model = listModel.CommunityIndexList[indexPath.row];
    cell.rankLab.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.CommunitImage] placeholderImage:[UIImage imageNamed:@"评论_头像"]];
    cell.nameLab.text = model.CommunityName;
    cell.schNameLab.text = model.SchoolName;
    cell.numLab.text = [NSString stringWithFormat:@"%ld部作品",model.FictionCount];
    cell.perNumLab.text = [NSString stringWithFormat:@"%ld人",model.UserCount];
    if (indexPath.row == 0) {
        cell.rankLab.textColor = [UIColor whiteColor];
        cell.rankLab.backgroundColor = BXColor(230,78,54);
    }else if (indexPath.row == 1){
        cell.rankLab.textColor = [UIColor whiteColor];
        cell.rankLab.backgroundColor = BXColor(50,205,189);
    }else if (indexPath.row == 2){
        cell.rankLab.textColor = [UIColor whiteColor];
        cell.rankLab.backgroundColor = BXColor(55,142,211);
    }else{
        cell.rankLab.textColor = BXColor(152, 152, 152);
        cell.rankLab.backgroundColor = [UIColor clearColor];
    }
    return cell;
    
}

#pragma mark - tableViewCell点击方法跳入详情页
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HLitDetailViewController *vc = [[HLitDetailViewController alloc] init];
    UnionModel *listModel = self.dataArray.firstObject;
    UnionHomeModel *model = listModel.CommunityIndexList[indexPath.row];
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
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(0, 0, 80, 30);
    [self.rightBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark - 导航栏右侧搜索按钮点击事件
-(void) rightNavBtnAction:(UIButton *)sender {
    NSLog(@"搜索");
    HSchSearchViewController *vc = [[HSchSearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 数据的获取
-(void) getDataList {
    NSString *userid = @"00000000-0000-0000-0000-000000000000";
    if (kUserLogin == YES) {
        userid = kUserID;
    }else{
        userid = @"00000000-0000-0000-0000-000000000000";
    }
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper communityHomeWithPageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] userId:userid success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            if (self.pagenum == 1) {
                self.dataArray = [[NSMutableArray alloc] init];
            }
            
            UnionModel *model = [UnionModel mj_objectWithKeyValues:response];
            
            [self.dataArray addObject:model];
            
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
            
            [self getDataList];
        }];
    }];
}


@end
