//
//  MLSearchViewController.m
//  Medicine
//
//  Created by Visoport on 2/1/17.
//  Copyright © 2017年 Visoport. All rights reserved.
//

#import "MLSearchViewController.h"
#import "SearchTableViewController.h"
#import <MJRefresh/MJRefresh.h>

#define PYSEARCH_SEARCH_HISTORY_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MLSearchhistories.plist"] // 搜索历史存储路径

@interface MLSearchViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tagsView;
@property (nonatomic, strong) UIView *headerView;
/** 搜索历史 */
@property (nonatomic, strong) NSMutableArray *searchHistories;
/** 搜索历史缓存保存路径, 默认为PYSEARCH_SEARCH_HISTORY_CACHE_PATH(PYSearchConst.h文件中的宏定义) */
@property (nonatomic, copy) NSString *searchHistoriesCachePath;
/** 搜索历史记录缓存数量，默认为20 */
@property (nonatomic, assign) NSUInteger searchHistoriesCount;

/** 搜索建议（推荐）控制器 */
@property (nonatomic, weak) SearchTableViewController *searchSuggestionVC;


@end

@implementation MLSearchViewController

- (SearchTableViewController *)searchSuggestionVC
{
    if (!_searchSuggestionVC) {
        SearchTableViewController *searchSuggestionVC = [[SearchTableViewController alloc] initWithStyle:UITableViewStylePlain];
        __weak typeof(self) _weakSelf = self;
        searchSuggestionVC.didSelectText = ^(NSString *didSelectText) {
            
            if ([didSelectText isEqualToString:@""]) {
                [self.searchBar resignFirstResponder];
            }
            else
            {
                // 设置搜索信息
                _weakSelf.searchBar.text = didSelectText;
                
                // 缓存数据并且刷新界面
                [_weakSelf saveSearchCacheAndRefreshView];
            }
            
            
        };
        searchSuggestionVC.view.frame = CGRectMake(0, 64, self.view.mj_w, BXScreenH);
        searchSuggestionVC.view.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:searchSuggestionVC.view];
        [self addChildViewController:searchSuggestionVC];
        _searchSuggestionVC = searchSuggestionVC;
    }
    return _searchSuggestionVC;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.tableFooterView.hidden = NO;
    
    self.searchSuggestionVC.view.hidden = YES;
    self.tableView.hidden = NO;
    
    self.searchHistoriesCount = 6;
    
    if (self.searchHistories.count > self.searchHistoriesCount) {
        // 刨去前6就是counts
        NSInteger counts = self.searchHistories.count - 6;
        // 然后counts就是一共要减去多少个  所以从0开始
        for (NSInteger i = 0; i < counts; i++) {
            [self.searchHistories removeLastObject];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    // 创建搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(10, 7, kScreenWidth-64-20, 30)];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-10, 0, titleView.frame.size.width, 30)
                              ];
    searchBar.placeholder = @"搜索内容";
    searchBar.delegate = self;
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.layer.cornerRadius = 12;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelDidClick)];
    
    
    
    self.headerView = [[UIView alloc] init];
    self.headerView.mj_x = 0;
    self.headerView.mj_y = 0;
    self.headerView.mj_w = kScreenWidth;
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 30)];
    titleLabel.text = @"热门搜索";
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor grayColor];
    [titleLabel sizeToFit];
    [self.headerView addSubview:titleLabel];
    
    self.tagsView = [[UIView alloc] init];
    self.tagsView.mj_x = 10;
    self.tagsView.mj_y = titleLabel.mj_y+30;
    self.tagsView.mj_w = kScreenWidth-20;
    
    [self.headerView addSubview:self.tagsView];
 
    
    self.tableView.tableFooterView = self.headerView;
    
    [self tagsViewWithTag];
    
}

- (void)tagsViewWithTag
{
    CGFloat allLabelWidth = 0;
    CGFloat allLabelHeight = 0;
    int rowHeight = 0;
    
    for (int i = 0; i < self.tagsArray.count; i++) {
        
        
        if (i != self.tagsArray.count-1) {
            
            CGFloat width = [self getWidthWithTitle:self.tagsArray[i+1] font:[UIFont systemFontOfSize:14]];
            if (allLabelWidth + width+10 > self.tagsView.frame.size.width) {
                rowHeight++;
                allLabelWidth = 0;
                allLabelHeight = rowHeight*40;
            }
        }
        else
        {
            
            CGFloat width = [self getWidthWithTitle:self.tagsArray[self.tagsArray.count-1] font:[UIFont systemFontOfSize:14]];
            if (allLabelWidth + width+10 > self.tagsView.frame.size.width) {
                rowHeight++;
                allLabelWidth = 0;
                allLabelHeight = rowHeight*40;
            }
        }
        
        
        
        UILabel *rectangleTagLabel = [[UILabel alloc] init];
        // 设置属性
        rectangleTagLabel.userInteractionEnabled = YES;
        rectangleTagLabel.font = THIRDFont;
        rectangleTagLabel.textColor = BXColor(40, 40, 40);
        
        rectangleTagLabel.text = self.tagsArray[i];
        rectangleTagLabel.textAlignment = NSTextAlignmentCenter;
        [rectangleTagLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        
        CGFloat labelWidth = [self getWidthWithTitle:self.tagsArray[i] font:[UIFont systemFontOfSize:13]];
        
        rectangleTagLabel.layer.borderWidth = 0.5;
        rectangleTagLabel.layer.borderColor = BXColor(195,195,195).CGColor;
        rectangleTagLabel.layer.cornerRadius = 5;
        [rectangleTagLabel.layer setMasksToBounds:YES];
        
        rectangleTagLabel.frame = CGRectMake(allLabelWidth, allLabelHeight, labelWidth, 25);
        [self.tagsView addSubview:rectangleTagLabel];
        
        allLabelWidth = allLabelWidth+10+labelWidth;
    }
    
    self.tagsView.mj_h = rowHeight*40+40;
    self.headerView.mj_h = self.tagsView.mj_y+self.tagsView.mj_h+10;
}

/** 选中标签 */
- (void)tagDidCLick:(UITapGestureRecognizer *)gr
{
    UILabel *label = (UILabel *)gr.view;
    self.searchBar.text = label.text;
    
    // 缓存数据并且刷新界面
    [self saveSearchCacheAndRefreshView];
    
    self.tableView.tableFooterView.hidden = NO;
    
    self.searchSuggestionVC.view.hidden = NO;
    self.tableView.hidden = YES;
    [self.view bringSubviewToFront:self.searchSuggestionVC.view];
    
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"searchBarDidChange" object:nil userInfo:@{@"searchText":label.text}];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
   
}



- (void)cancelDidClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 视图完全显示 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.tableView.tableFooterView.hidden = NO;
    
    self.searchSuggestionVC.view.hidden = YES;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.searchHistories.count != 0) {
        
        return @"搜索历史";
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-10, 60)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:view.frame];
    titleLabel.text = @"搜索历史";
    titleLabel.font = [UIFont systemFontOfSize:14];
    [titleLabel sizeToFit];
    [view addSubview:titleLabel];
    
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
    
//    [self searchBarSearchButtonClicked:self.searchBar];
    self.searchSuggestionVC.view.hidden = NO;
    self.tableView.hidden = YES;
    [self.view bringSubviewToFront:self.searchSuggestionVC.view];
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"searchBarDidChange" object:nil userInfo:@{@"searchText":cell.textLabel.text}];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width+10;
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
    
    SearchTableViewController *vc = [[SearchTableViewController alloc] init];
    vc.hidesBottomBarWhenPushed = true;
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
    
    //    [self searchBarSearchButtonClicked:self.searchBar];
    self.searchSuggestionVC.view.hidden = NO;
    self.tableView.hidden = YES;
    [self.view bringSubviewToFront:self.searchSuggestionVC.view];
    
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"searchBarDidChange" object:nil userInfo:@{@"searchText":self.searchBar.text}];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}



@end
