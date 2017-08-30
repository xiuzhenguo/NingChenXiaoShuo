//
//  HBillboardViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/1.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HBillboardViewController.h"
#import "HBLeftTableViewCell.h"
#import "HBRightTableViewCell.h"
#import "HBRTyrantTableViewCell.h"
#import "HBListView.h"
#import "NCHomePageHelper.h"
#import "BillboardModel.h"
#import "HAuthorsViewController.h"

@interface HBillboardViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) NSInteger leftRow;
@property (nonatomic, strong) NSArray *leftArray;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, assign) NSInteger pagenum;
@property (nonatomic, assign) NSInteger typenum;
@property (nonatomic, assign) NSInteger flagnum;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) EmptyDataView *emptyView;

@end

@implementation HBillboardViewController

-(NCHomePageHelper *)helper{
    if (!_helper) {
        _helper = [NCHomePageHelper helper];
    }
    return _helper;
}

- (UITableView *)leftTableView {
    
    if (!_leftTableView) {
        
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 65, BXScreenH-64)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 44;
        _leftTableView.backgroundColor = BXColor(242, 242, 242);
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = [UIColor clearColor];
        [_leftTableView registerClass:[HBLeftTableViewCell class] forCellReuseIdentifier:@"leftCell"];
    }
    
    return _leftTableView;
}

- (UITableView *)rightTableView {
    
    if (!_rightTableView) {
        
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(65, 0, BXScreenW - 65, BXScreenH-64)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTableView.showsVerticalScrollIndicator = NO;
        [_rightTableView registerClass:[HBRightTableViewCell class] forCellReuseIdentifier:@"rightCell"];
        [_rightTableView registerClass:[HBRTyrantTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    
    return _rightTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"排行榜";
    self.flagnum = 1;
    self.pagenum = 1;
    // 添加导航栏
    [self setUpNavButtonUI];
    
    //创建表格
    [self createTable];
    
    self.rightTableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //    self.colletionView.mj_footer = [MJDIYHeader]
    self.rightTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getRankListData];
    
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getRankListData];
    
}

#pragma mark - 创建联动表格
- (void)createTable {
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    
    // 死数据(测试用)
    self.leftArray = @[@"收藏榜",@"勤耕榜",@"评论榜",@"新书榜",@"完本榜",@"土豪榜",@"打赏榜",@"码王榜"];

    for (int i = 0; i<self.leftArray.count; i++) {
        if ([self.typeStr isEqualToString:self.leftArray[i]]) {
            self.leftRow = i;
            self.typenum = i + 1;

        }
        if ([self.typeStr isEqualToString:@"排行榜"]) {
            self.leftRow = 0;
            self.typenum = 1;
        }
    }
    
    [self getRankListData];
    
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.leftRow inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UITableViewDataSourse -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return (_leftTableView == tableView) ? self.leftArray.count : self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_leftTableView == tableView) {
        
        HBLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell" forIndexPath:indexPath];
        cell.nameLab.text = self.leftArray[indexPath.row];
        
        cell.backgroundColor = BXColor(242,242,242);
        
        return cell;
    }else {
        if ([self.typeStr isEqualToString:@"土豪榜"]) {
            HBRTyrantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            BillboardModel *model = self.dataArray[indexPath.row];
            cell.viewModel = model;
            
            tableView.rowHeight = 65;
            return cell;
        }else if ([self.typeStr isEqualToString:@"码王榜"]){
            HBRTyrantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            BillboardModel *model = self.dataArray[indexPath.row];
            cell.model = model;
            
            tableView.rowHeight = 65;
            return cell;
        }else{
            
            HBRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell" forIndexPath:indexPath];
            BillboardModel *model = self.dataArray[indexPath.row];
            cell.viewModel = model;
            
            tableView.rowHeight = 80;
            return cell;
        }
    }
}

#pragma mark - tableViewCell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_rightTableView == tableView) {
        if (self.typenum == 6 || self.typenum == 8) {//土豪榜、码王榜跳转作者页面
            
            HAuthorsViewController *vc = [[HAuthorsViewController alloc] init];
            BillboardModel *model = self.dataArray[indexPath.row];
            if (self.typenum == 6) {
                vc.autherID = model.FictionId;
            }else{
                vc.autherID = model.UserId;
            }
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{// 跳转小说详情页面
            
            NovelDetailViewController *vc = [[NovelDetailViewController alloc] init];
            BillboardModel *model = self.dataArray[indexPath.row];
            vc.bookId = model.FictionId;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else{
        self.leftRow = indexPath.row;
        self.rightTableView.contentOffset = CGPointMake(0, 0);
        self.typeStr = self.leftArray[indexPath.row];
        self.typenum = indexPath.row + 1;
        self.pagenum = 1;
        [self getRankListData];
    
    }
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
    self.rightBtn.frame = CGRectMake(0, 0, 100, 30);
    [self.rightBtn setTitle:@"周榜" forState:UIControlStateNormal];
    [self.rightBtn setImage:[UIImage imageNamed:@"三角-2"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    
    [self.rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.rightBtn.imageView.size.width+5, 0, self.rightBtn.imageView.size.width)];
    [self.rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.rightBtn.titleLabel.bounds.size.width, 0, -self.rightBtn.titleLabel.bounds.size.width-5)];
    self.rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 离线作品按钮的点击事件的实现
-(void)rightNavBtnAction:(UIButton *)sender{
    NSLog(@"排行榜");
    HBListView *listView = [[HBListView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    [self.view.window addSubview:listView];
     NSArray *array = @[@"周榜",@"月榜",@"总榜"];
    for (int i = 0; i<listView.BtnArray.count; i++) {
        UIButton *sender = listView.BtnArray[i];
        [sender setTitle:array[i] forState:UIControlStateNormal];
        if ([self.rightBtn.titleLabel.text isEqualToString:sender.titleLabel.text]) {
            NSLog(@"%@",sender.titleLabel.text);
            [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }
    // 点击回调方法
//    __weak typeof(self)weakSelf = self;
    [listView setFinishButtonName:^(NSString *name){
        NSLog(@"%@",name);
        [self.rightBtn setTitle:name forState:UIControlStateNormal];
        if ([name isEqualToString:@"周榜"]) {
            self.pagenum = 1;
            self.flagnum = 1;
        }else if ([name isEqualToString:@"月榜"]){
            self.flagnum = 2;
            self.pagenum = 1;
        }else if ([name isEqualToString:@"总榜"]){
            self.flagnum = 3;
            self.pagenum = 1;
        }
        
        [self getRankListData];
    }];
}

#pragma mark - 数据的获取
- (void) getRankListData {
    
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper rankingListWithType:[NSString stringWithFormat:@"%ld",self.typenum] flag:[NSString stringWithFormat:@"%ld",self.flagnum] pageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] success:^(NSArray *response) {
        st_dispatch_async_main(^{
            if (self.pagenum == 1) {
                self.dataArray = [[NSMutableArray alloc] init];
            }
            for (int i=0; i<response.count; i++) {
                BillboardModel *model = [BillboardModel mj_objectWithKeyValues:response[i]];
                
                [self.dataArray addObject:model];
                
            }
            if(self.dataArray.count == 0 && self.pagenum == 1){
                [self.emptyView removeFromSuperview];
                self.emptyView = [[EmptyDataView alloc]initWithFrame:CGRectMake(0, 0, BXScreenW - 65, BXScreenH) title:@"没有数据" actionTitle:nil];
                [self.rightTableView addSubview:self.emptyView];
                
            }else{
                [self.emptyView removeFromSuperview];
            }
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self.rightTableView reloadData];
            [self.rightTableView.mj_header endRefreshing];
            [self.rightTableView.mj_footer endRefreshing];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.rightTableView.mj_header endRefreshing];
        [self.rightTableView.mj_footer endRefreshing];
        [self.view showFailedViewReloadBlock:^{
//            [self.view showActivityWithImage:kLoadingImage];
            [self getRankListData];
        }];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;//不设置为黑色背景
}

@end
