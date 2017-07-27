//
//  HMyClubWorkViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HMyClubWorkViewController.h"
#import "HMyClubWorkTableViewCell.h"
#import "HSeaNovelViewController.h"
#import "NCHomePageHelper.h"
#import "ExcellentFictionModel.h"

@interface HMyClubWorkViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *inputStr;
@property (nonatomic, assign) NSInteger pagenum;
@property (nonatomic, strong) EmptyDataView *emptyView;

@end

@implementation HMyClubWorkViewController

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
    self.title = @"社团作品";
    self.pagenum = 1;
    self.inputStr = @"";
    
    // 添加导航栏
    [self setUpNavButtonUI];
    // 添加tableView
    [self setUpUITableViewUI];
    
    [self getCommunityNovelListData];
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getCommunityNovelListData];
    
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getCommunityNovelListData];
    
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
    [self.tableView registerClass:[HMyClubWorkTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UItableViewcell 的个数及cell的设置
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark - tableViewCell设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HMyClubWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ExcellentFictionModel *model = self.dataArray[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.Image] placeholderImage:[UIImage imageNamed:@"书"]];
    cell.nameLab.text = model.FictionName;
    cell.timeLab.text = model.timeinfo;
    cell.numLab.text = [NSString stringWithFormat:@"%ld阅读/%ld评论/%ld收藏",model.Reader,model.EvalauteIndex,model.Collect];
    
//    // 测试
//    if (indexPath.row % 2 == 0) {
//        [cell.recomBtn setTitle:@"推荐" forState:UIControlStateNormal];
//        [cell.recomBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
//        [cell.recomBtn setImage:[UIImage imageNamed:@"推荐"] forState:UIControlStateNormal];
//        cell.recomBtn.borderColor = BXColor(236,105,65);
//    }else{
//        [cell.recomBtn setTitle:@"已推荐" forState:UIControlStateNormal];
//        [cell.recomBtn setTitleColor:BXColor(152,152,152) forState:UIControlStateNormal];
//        [cell.recomBtn setImage:[UIImage imageNamed:@"已推荐"] forState:UIControlStateNormal];
//        cell.recomBtn.borderColor = BXColor(152,152,152);
//    }
    
    return cell;
    
}

#pragma mark - tableViewCell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NovelDetailViewController *vc = [[NovelDetailViewController alloc] init];
    ExcellentFictionModel *model = self.dataArray[indexPath.row];
    vc.bookId = model.FictionId;
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
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 30);
    [rightBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark - 导航栏右侧搜索按钮点击事件
-(void) rightNavBtnAction:(UIButton *)sender {
    NSLog(@"搜索");
    HSeaNovelViewController *vc = [[HSeaNovelViewController alloc] init];
    vc.communityID = self.communityID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 社团作品数据的获取
-(void) getCommunityNovelListData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper getCommunityNovelWithID:self.communityID Inputstring:self.inputStr PageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] success:^(NSArray *response) {
        st_dispatch_async_main(^{
            if (self.pagenum == 1) {
                self.dataArray = [[NSMutableArray alloc] init];
            }
            for (int i=0; i<response.count; i++) {
                ExcellentFictionModel *model = [ExcellentFictionModel mj_objectWithKeyValues:response[i]];
                
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
            [self getCommunityNovelListData];
        }];
    }];
}


@end

