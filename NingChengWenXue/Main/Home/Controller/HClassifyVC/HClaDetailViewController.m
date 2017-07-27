//
//  HClaDetailViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/3.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HClaDetailViewController.h"
#import "HBListView.h"
#import "HClaDetailTableViewCell.h"
#import "HClaDetailTitleView.h"
#import "NCHomePageHelper.h"
#import "BookKeysModel.h"


@interface HClaDetailViewController ()<UITableViewDelegate, UITableViewDataSource>;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *titleBtn;
@property (nonatomic, strong) HClaDetailTitleView *detailTitleView;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pagenum;
@property (nonatomic, assign) NSInteger orderbynum;
@property (nonatomic, strong) EmptyDataView *emptyView;

@end

@implementation HClaDetailViewController

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
    self.pagenum = 1;
    self.orderbynum = 1;
    
    self.titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BXScreenW - 160, 44)];
    [self.titleBtn setTitleColor:BXColor(40, 40, 40) forState:UIControlStateNormal];
    self.titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    NSString *str = [NSString stringWithFormat:@"%@·%@",_secName,_rowName];
    [self.titleBtn setTitle:str forState:UIControlStateNormal];
    [self.titleBtn setImage:[UIImage imageNamed:@"三角箭头"] forState:UIControlStateNormal];
    
    [self.titleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.titleBtn.imageView.size.width, 0, self.titleBtn.imageView.size.width)];
    [self.titleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleBtn.titleLabel.bounds.size.width, 0, -self.titleBtn.titleLabel.bounds.size.width)];
    
    [self.titleBtn addTarget:self action:@selector(clickTitleButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = self.titleBtn;
    
    // 设置导航栏
    [self setUpNavButtonUI];
    // 添加tableView
    [self setUpTableViewUI];
    
    [self getGenerNovelListData];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //    self.colletionView.mj_footer = [MJDIYHeader]
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getGenerNovelListData];
    
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getGenerNovelListData];
    
}

#pragma mark - 创建UITableViewUI
- (void) setUpTableViewUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH-64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView registerClass:[HClaDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UItableViewcell 的个数及cell的设置
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark - tableViewCell 设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HClaDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BookKeysModel *model = self.dataArray[indexPath.row];
    
    cell.viewModel = model;
    
    return cell;
}

#pragma mark - tableViewCell 的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BookKeysModel *model = self.dataArray[indexPath.row];
    NovelDetailViewController *vc = [[NovelDetailViewController alloc] init];
    vc.bookId = model.FictionId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 点击导航栏标题按钮的点击时间
-(void) clickTitleButton {
    self.detailTitleView = [[HClaDetailTitleView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    [self.view addSubview:self.detailTitleView];
    self.detailTitleView.sectionArr = self.secArray;
    
    __weak typeof(self)weakSelf = self;
    [self.detailTitleView setFinishButtonTitleStr:^(NSString *title){
        NSLog(@"%@",title);
        [weakSelf.titleBtn setTitle:title forState:UIControlStateNormal];
//        [weakSelf.detailTitleView removeFromSuperview];
    }];
    
    [self.detailTitleView setFinishButtonTypeId:^(NSString *typeId){
        NSLog(@"222%@",typeId);
        weakSelf.Id = typeId;
        weakSelf.pagenum = 1;
        [weakSelf getGenerNovelListData];
        [weakSelf.detailTitleView removeFromSuperview];
    }];
}

#pragma mark - 设置导航栏按钮
-(void) setUpNavButtonUI {
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 80, 30);
    [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = item;
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(0, 0, 80, 30);
    [self.rightBtn setTitle:@"最热" forState:UIControlStateNormal];
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

#pragma mark - 右侧选择按钮的实现方法
-(void) rightNavBtnAction:(UIButton *)sender {
    HBListView *listView = [[HBListView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    [self.view.window addSubview:listView];
    NSArray *array = @[@"最热",@"精选",@"最新"];
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
        if ([name isEqualToString:@"最热"]) {
            self.pagenum = 1;
            self.orderbynum = 1;
        }else if ([name isEqualToString:@"精选"]){
            self.orderbynum = 2;
            self.pagenum = 1;
        }else if ([name isEqualToString:@"最新"]){
            self.orderbynum = 3;
            self.pagenum = 1;
        }
        
        [self getGenerNovelListData];
    }];
}

#pragma mark - 分类小说的数据获取
-(void) getGenerNovelListData {
    
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper generNovelListWithGener:self.Id orderby:[NSString stringWithFormat:@"%ld",self.orderbynum] pageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] success:^(NSArray *response) {
        st_dispatch_async_main(^{
            if (self.pagenum == 1) {
                self.dataArray = [[NSMutableArray alloc] init];
            }
            
            for (int i=0; i<response.count; i++) {
                BookKeysModel *model = [BookKeysModel mj_objectWithKeyValues:response[i]];
                
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
//            [self.view showActivityWithImage:kLoadingImage];
            [self getGenerNovelListData];
        }];
    }];
}

@end
