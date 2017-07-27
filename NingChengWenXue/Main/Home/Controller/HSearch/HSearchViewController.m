//
//  HSearchViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HSearchViewController.h"
#import "HSeaListViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "NCHomePageHelper.h"
#import "SearchModel.h"

#define PYSEARCH_SEARCH_HISTORY_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MLSearchhistories.plist"] // 搜索历史存储路径

@interface HSearchViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *tagsView;
@property (nonatomic, strong) UIView *headerView;
/** 搜索历史 */
@property (nonatomic, strong) NSMutableArray *searchHistories;
/** 搜索历史缓存保存路径, 默认为PYSEARCH_SEARCH_HISTORY_CACHE_PATH(PYSearchConst.h文件中的宏定义) */
@property (nonatomic, copy) NSString *searchHistoriesCachePath;
/** 搜索历史记录缓存数量，默认为20 */
@property (nonatomic, assign) NSUInteger searchHistoriesCount;

/** 搜索建议（推荐）控制器 */
@property (nonatomic, weak) HSeaListViewController *searchSuggestionVC;

@property (strong, nonatomic) NCHomePageHelper *helper;
//@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation HSearchViewController

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
    
    self.tableView.tableFooterView.hidden = NO;
    
//    self.searchSuggestionVC.view.hidden = YES;
    self.tableView.hidden = NO;
    
    self.searchHistoriesCount = 6;
    
    self.searchHistoriesCachePath = PYSEARCH_SEARCH_HISTORY_CACHE_PATH;
    _searchHistories = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.searchHistoriesCachePath]];
    
    if (self.searchHistories.count > self.searchHistoriesCount) {
        // 刨去前6就是counts
        NSInteger counts = self.searchHistories.count - 6;
        // 然后counts就是一共要减去多少个  所以从0开始
        for (NSInteger i = 0; i < counts; i++) {
            [self.searchHistories removeLastObject];
        }
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 64)];
    self.titleView.backgroundColor = BXColor(242,242,242);
    [self.view addSubview:self.titleView];
    
    [self setUpSearchBarUI];
    
    [self setUpNavButtonUI];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, BXScreenW, BXScreenH - 64) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.headerView = [[UIView alloc] init];
    self.headerView.mj_x = 0;
    self.headerView.mj_y = 0;
    self.headerView.mj_w = kScreenWidth;
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    titleLabel.text = @"热门搜索";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = BXColor(40, 40, 40);
    titleLabel.backgroundColor = BXColor(242,242,242);
//    [titleLabel sizeToFit];
    
    [self.headerView addSubview:titleLabel];
    
    self.tagsView = [[UIView alloc] init];
    self.tagsView.mj_x = 10;
    self.tagsView.mj_y = titleLabel.mj_y+45;
    self.tagsView.mj_w = kScreenWidth-20;
    
    [self.headerView addSubview:self.tagsView];
    
    
    self.tableView.tableFooterView = self.headerView;
    
//    [self tagsViewWithTag];
    
    [self getHotSearchData];
    
}

#pragma mark - 添加搜索框
-(void) setUpSearchBarUI {
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(60, 20, BXScreenW - 130, 30)
                              ];
    searchBar.placeholder = @"输入作品、标签或用户名";
    searchBar.delegate = self;
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.layer.cornerRadius = 12;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    self.searchBar = searchBar;
    [self.titleView addSubview:searchBar];
    
}


- (void)tagsViewWithTag
{
    
    for (int i = 0; i < _tagsArray.count; i ++)
    {
        //        Area *are = cell_Array[i];
        
        NSString *name = _tagsArray[i];
        static UIButton *recordBtn =nil;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        CGRect rect = [name boundingRectWithSize:CGSizeMake(BXScreenW -20, 35) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
        
        CGFloat BtnW = rect.size.width + 10;
        CGFloat BtnH = rect.size.height + 10;
        
        if (i == 0)
        {
            btn.frame =CGRectMake(0, 0, BtnW, BtnH);
        }
        else{
            
            CGFloat yuWidth = BXScreenW - 20 -recordBtn.frame.origin.x -recordBtn.frame.size.width;
            
            if (yuWidth >= rect.size.width) {
                
                btn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + 5, recordBtn.frame.origin.y, BtnW, BtnH);
            }else{
                
                btn.frame =CGRectMake(0, recordBtn.frame.origin.y+recordBtn.frame.size.height+5, BtnW, BtnH);
            }
            
        }
        btn.borderWidth = 1;
        btn.borderColor = BXColor(40, 40, 40);
        [btn setTitle:name forState:UIControlStateNormal];
        [self.tagsView addSubview:btn];
    
        self.tagsView.mj_h = CGRectGetMaxY(btn.frame);
        recordBtn = btn;
        
        btn.tag = 1000 + i;
        btn.titleLabel.font = THIRDFont;
        [btn setTitleColor:BXColor(40, 40, 40) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.headerView.mj_h = self.tagsView.mj_y+self.tagsView.mj_h+10;
}

-(void) BtnClick:(UIButton *)sender{
    
    self.searchBar.text = sender.titleLabel.text;
    
    // 缓存数据并且刷新界面
    [self saveSearchCacheAndRefreshView];
    
    self.tableView.tableFooterView.hidden = NO;
    
    NSLog(@"%@",self.searchBar.text);
    
}

/** 视图完全显示 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.tableView.tableFooterView.hidden = NO;
    
    
    self.tableView.hidden = NO;
    
    // 弹出键盘
    [self.searchBar becomeFirstResponder];
}

/** 视图即将消失 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 回收键盘
    [self.searchBar resignFirstResponder];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    self.tableView.tableFooterView.hidden = self.searchHistories.count == 0;
    return self.searchHistories.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   
    cell.textLabel.textColor = BXColor(40, 40, 40);
    cell.textLabel.font = THIRDFont;
    cell.textLabel.text = self.searchHistories[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.searchHistories.count != 0) {
        
        return @"搜索历史";
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.searchHistories.count != 0) {
        return 35;
    }else{
        
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    view.backgroundColor = BXColor(242,242,242);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, BXScreenW - 100, 35)];
    titleLabel.text = @"搜索历史";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = BXColor(40, 40, 40);
    [view addSubview:titleLabel];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 100, 0, 90, 35)];
    [btn setImage:[UIImage imageNamed:@"垃圾箱"] forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [btn addTarget:self action:@selector(emptySearchHistoryDidClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出选中的cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.searchBar.text = cell.textLabel.text;
    
    // 缓存数据并且刷新界面
    [self saveSearchCacheAndRefreshView];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 滚动时，回收键盘
    [self.searchBar resignFirstResponder];
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

/** 进入搜索状态调用此方法 */
- (void)saveSearchCacheAndRefreshView
{
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
    
    //    // 移除多余的缓存
    if (self.searchHistories.count > self.searchHistoriesCount) {
        // 刨去前6就是counts
        NSInteger counts = self.searchHistories.count - 6;
        // 然后counts就是一共要减去多少个  所以从0开始
        for (NSInteger i = 0; i < counts; i++) {
            [self.searchHistories removeLastObject];
        }
        
    }
    // 保存搜索信息
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
    
    [self.tableView reloadData];
    
    HSeaListViewController *vc = [[HSeaListViewController alloc] init];
    vc.titleStr = searchBar.text;
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
    [self.navigationController pushViewController:vc animated:YES];
}


/** 点击清空历史按钮 */
- (void)emptySearchHistoryDidClick
{
    
    self.tableView.tableFooterView.hidden = NO;
    // 移除所有历史搜索
    [self.searchHistories removeAllObjects];
    // 移除数据缓存
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
    
    [self.tableView reloadData];
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    // 缓存数据并且刷新界面
    [self saveSearchCacheAndRefreshView];
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
    // 缓存数据并且刷新界面
    [self saveSearchCacheAndRefreshView];
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 获取热门搜索数据
-(void) getHotSearchData {
//    [self.view showHudWithActivity:@"正在加载"];
    [self.helper hotsearchWithSuccess:^(NSArray *response) {
        st_dispatch_async_main(^{
            
            self.tagsArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                SearchModel *model = [SearchModel mj_objectWithKeyValues:response[i]];
                
                [self.tagsArray addObject:[NSString stringWithFormat:@"%@",model.HotName]];
                
            }
            
            [self.view hideHubWithActivity];
            [self tagsViewWithTag];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
    }];
    
}


@end

