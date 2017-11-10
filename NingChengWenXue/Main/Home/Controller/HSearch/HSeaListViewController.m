//
//  HSeaListViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HSeaListViewController.h"
#import "HAWorksTableViewCell.h"
#import "NovelDetailViewController.h"
#import "NCHomePageHelper.h"
#import "SearchModel.h"
#import "SearchListModel.h"
#import "HAuthorsViewController.h"

#define PYSEARCH_SEARCH_HISTORY_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MLSearchhistories.plist"] // 搜索历史存储路径

@interface HSeaListViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) UILabel * classLab;
@property (nonatomic, strong) UIImageView *img;

/** 搜索历史 */
@property (nonatomic, strong) NSMutableArray *searchHistories;
/** 搜索历史缓存保存路径, 默认为PYSEARCH_SEARCH_HISTORY_CACHE_PATH(PYSearchConst.h文件中的宏定义) */
@property (nonatomic, copy) NSString *searchHistoriesCachePath;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *userArray;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation HSeaListViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.pageNum = 2;
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 64)];
    self.titleView.backgroundColor = BXColor(242,242,242);
    [self.view addSubview:self.titleView];
    
    [self setUpNavButtonUI];
    
    [self setUpSearchBarUI];
    
    [self setUpTableViewUI];
    
    [self getSearchData];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}

#pragma mark - 下拉刷新
-(void) loadNewData {
    [self getSearchData];
}
#pragma mark - 上拉加载
-(void) loadMoreData{
    self.pageNum++;
    [self getSearchNovelMoreData];
}


#pragma mark - 添加搜索框
-(void) setUpSearchBarUI {
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(60, 20, BXScreenW - 130, 30)];
    searchBar.text = self.titleStr;
    searchBar.delegate = self;
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.layer.cornerRadius = 12;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    self.searchBar = searchBar;
    [self.titleView addSubview:searchBar];
    
}

#pragma mark - 创建tableView
-(void) setUpTableViewUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, BXScreenW, BXScreenH - 64) style:UITableViewStyleGrouped];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[HAWorksTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 135)];
    self.headerView.backgroundColor = BXColor(242, 242, 242);
    self.tableView.tableHeaderView = self.headerView;
    
}

#pragma mark - 创建头视图
-(void) setUpHeaderView {
    UILabel *perLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, BXScreenW - 30, 35)];
    perLab.text = @"相关用户";
    perLab.font = [UIFont boldSystemFontOfSize:15];
    perLab.textColor = BXColor(40, 40, 40);
    perLab.backgroundColor = BXColor(242, 242, 242);
    [self.headerView addSubview:perLab];
    
    UIScrollView * scv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 35, BXScreenW, 100)];
    scv.showsHorizontalScrollIndicator = NO;
    scv.showsVerticalScrollIndicator = NO;
    scv.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:scv];

    for (int i=0; i<self.userArray.count; i++) {
        SearchListModel *model = self.userArray[i];
        UIButton * bookBtn = [[UIButton alloc]init];
        bookBtn.frame = CGRectMake(15+i*71, 0, 105, 60);
        scv.contentSize = CGSizeMake(self.userArray.count*71, 56);
        bookBtn.tag = i+10;
        [bookBtn addTarget:self action:@selector(btnCli:) forControlEvents:1<<6];
        [scv addSubview: bookBtn];
        
        self.classLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 76, 56, 14)];
        self.classLab.font = [UIFont boldSystemFontOfSize:13];
        self.classLab.textColor = BXColor(40, 40, 40);
        [bookBtn addSubview: self.classLab];
        self.classLab.textAlignment = NSTextAlignmentCenter;
        self.classLab.text = model.AuthorName;
        
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 56, 56)];
        [self.img sd_setImageWithURL:[NSURL URLWithString:model.AuthorImage] placeholderImage:[UIImage imageNamed:@"评论_头像"]];
        self.img.layer.cornerRadius = 28;
        self.img.clipsToBounds = YES;
        [bookBtn addSubview:self.img];
    }
    
}

#pragma mark - 头视图的点击方法
-(void)btnCli:(UIButton*)sender{

    SearchListModel *model = self.userArray[sender.tag - 10];
    HAuthorsViewController *vc = [[HAuthorsViewController alloc] init];
    vc.autherID = model.UserId;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark - tableViewCell 设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HAWorksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SearchListModel *model = self.dataArray[indexPath.row];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.Image] placeholderImage:[UIImage imageNamed:@"书"]];
    cell.nameLab.text = model.FictionName;
    cell.timeLab.text = model.AuthorName;
    cell.numLab.text = [NSString stringWithFormat:@"%ld阅读/%ld评论/%ld收藏",model.Reader,model.EvalauteIndex,model.Collect];
    
    return cell;
}

#pragma mark - tableView分区头设置
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 35)];
    back.backgroundColor = BXColor(242, 242, 242);;
    UILabel *novelLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, BXScreenW - 30, 35)];
    novelLab.text = @"相关作品";
    novelLab.font = [UIFont boldSystemFontOfSize:15];
    novelLab.textColor = BXColor(40, 40, 40);
    [back addSubview:novelLab];
    return back;
}

#pragma mark - tableViewCell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NovelDetailViewController *vc = [[NovelDetailViewController alloc] init];
    SearchListModel *model = self.dataArray[indexPath.row];
    vc.bookId = model.FictionId;
    [self.navigationController pushViewController:vc animated:YES];
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

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchResultAndRefresh];
}

#pragma mark - 导航栏右侧资料按钮点击事件
-(void) rightNavBtnAction:(UIButton *)sender {
    [self searchResultAndRefresh];;
}

-(void) searchResultAndRefresh {
    if (self.searchBar.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入搜索内容"];
        return;
    }
    UISearchBar *searchBar = self.searchBar;
    // 回收键盘
    [searchBar resignFirstResponder];
    // 先移除再刷新
    [self.searchHistories removeObject:searchBar.text];
    [self.searchHistories insertObject:searchBar.text atIndex:0];
    
    // 保存搜索信息
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
    
    self.titleStr = searchBar.text;
    [self getSearchData];
}

#pragma mark - 搜索网络数据的获取
-(void) getSearchData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper searchWithInputText:self.titleStr PageIndex:@"1" success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            self.dataArray = [[NSMutableArray alloc] init];
            SearchModel *model = [SearchModel mj_objectWithKeyValues:response];
            _array = model.Fiction;
            self.userArray = model.User;
            self.dataArray = [_array mutableCopy];
            
            if(self.dataArray.count == 0 && model.User.count == 0){
                [self.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
            }
            
            if (model.User.count == 0) {
                
                self.headerView.frame = CGRectMake(0, 0, BXScreenW, 0);
                self.headerView.hidden = YES;
            }else{
                self.headerView.frame = CGRectMake(0, 0, BXScreenW, 135);
                self.headerView.hidden = NO;
            }
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self setUpHeaderView];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView showFailedViewReloadBlock:^{
//            [self.view showActivityWithImage:kLoadingImage];
            [self getSearchData];
        }];
    }];
}

#pragma mark - 加载更多网络数据
-(void) getSearchNovelMoreData {
    [self.helper searchFictionWithInputText:self.titleStr PageIndex:[NSString stringWithFormat:@"%ld",self.pageNum] success:^(NSArray *response) {
        for (int i=0; i<response.count; i++) {
            SearchListModel *model = [SearchListModel mj_objectWithKeyValues:response[i]];
            
            [self.dataArray addObject:model];
            
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } faild:^(NSString *response, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (NSMutableArray *)searchHistories
{
    
    if (!_searchHistories) {
        self.searchHistoriesCachePath = PYSEARCH_SEARCH_HISTORY_CACHE_PATH;
        _searchHistories = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.searchHistoriesCachePath]];
        
    }
    return _searchHistories;
}

#pragma mark - 不能删  刚进页面是用
- (void)setSearchHistoriesCachePath:(NSString *)searchHistoriesCachePath
{
    _searchHistoriesCachePath = [searchHistoriesCachePath copy];
    // 刷新
    self.searchHistories = nil;
    
    [self.tableView reloadData];
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  视图即将消失
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}

@end
