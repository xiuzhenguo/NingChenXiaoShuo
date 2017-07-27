//
//  HSeaNovelViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/6/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HSeaNovelViewController.h"
#import "HAWorksTableViewCell.h"
#import "BXNavigationController.h"
#import "HLitDetailViewController.h"
#import "ExcellentFictionModel.h"
#import "NCHomePageHelper.h"

@interface HSeaNovelViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) EmptyDataView *emptyView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIView *titleView;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pagenum;

@end

@implementation HSeaNovelViewController

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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BXColor(242,242,242);
    
    self.pagenum = 1;
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 64)];
    self.titleView.backgroundColor = BXColor(242,242,242);
    [self.view addSubview:self.titleView];
    
    [self setUpSearchBarUI];
    [self setUpNavButtonUI];
    [self setUpUITableViewUI];
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getSearchData:self.searchBar.text];
    
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getSearchData:self.searchBar.text];
    
}

#pragma mark - 添加搜索框
-(void) setUpSearchBarUI {
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(60, 20, BXScreenW - 130, 30)];
    searchBar.placeholder = @"输入作品名称";
    searchBar.delegate = self;
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.layer.cornerRadius = 12;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    self.searchBar = searchBar;
    [self.titleView addSubview:searchBar];
    
}

#pragma mark - 创建UITableView视图
-(void) setUpUITableViewUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, BXScreenW, BXScreenH-64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[HAWorksTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
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
    
    HAWorksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ExcellentFictionModel *model = self.dataArray[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.Image] placeholderImage:[UIImage imageNamed:@"书"]];
    cell.nameLab.text = model.FictionName;
    cell.timeLab.text = model.timeinfo;
    cell.numLab.text = [NSString stringWithFormat:@"%ld阅读/%ld评论/%ld收藏",model.Reader,model.EvalauteIndex,model.Collect];
    
    return cell;
    
}

#pragma mark - tableViewCell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NovelDetailViewController *vc = [[NovelDetailViewController alloc] init];
    ExcellentFictionModel *model = self.dataArray[indexPath.row];
    vc.bookId = model.FictionId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    //    self.tableView.hidden = NO;
    [self.searchBar resignFirstResponder];
    self.pagenum = 1;
    [self getSearchData:searchBar.text];
}

#pragma mark - 设置导航栏按钮
-(void) setUpNavButtonUI {
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(15, 20, 45, 30);
    [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    //    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [self.titleView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(BXScreenW - 70, 20, 55, 30);
    [rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    //    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self.titleView addSubview:rightBtn];
}

#pragma mark - 导航栏右侧资料按钮点击事件
-(void) rightNavBtnAction:(UIButton *)sender {
    NSLog(@"搜索");
    //    self.tableView.hidden = NO;
    [self.searchBar resignFirstResponder];
    self.pagenum = 1;
    [self getSearchData:self.searchBar.text];
}

#pragma mark - 搜索数据的获取
-(void) getSearchData:(NSString *) searchText {
    if (searchText.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写搜索作品"];
        return;
    }
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper getCommunityNovelWithID:self.communityID Inputstring:searchText PageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] success:^(NSArray *response) {
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
            [self getSearchData:searchText];
        }];
    }];

}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
