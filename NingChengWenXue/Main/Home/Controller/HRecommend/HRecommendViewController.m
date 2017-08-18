//
//  HRecommendViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/6.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HRecommendViewController.h"
#import "HBListView.h"
#import "HEssenceTableViewCell.h"
#import "HEssenceLastTableViewCell.h"
#import "NCHomePageHelper.h"
#import "ExceedListModel.h"
#import "NCBookshelfHelper.h"

@interface HRecommendViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *rightBtn;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pagenum;
@property (nonatomic, strong) NSString *statusNum;
@property (nonatomic, strong) EmptyDataView *emptyView;
@property (nonatomic, strong) NCBookshelfHelper *bookHelper;

@end

@implementation HRecommendViewController

-(NCHomePageHelper *)helper{
    if (!_helper) {
        _helper = [NCHomePageHelper helper];
    }
    return _helper;
}

- (NCBookshelfHelper *)bookHelper{
    if (!_bookHelper) {
        _bookHelper = [NCBookshelfHelper helper];
    }
    return _bookHelper;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"凝尘推荐TOP200";
    
    self.pagenum = 1;
    self.statusNum = @"3";
    
    // 添加导航栏
    [self setUpNavButtonUI];
    // 添加tableView
    [self setUpTableViewUI];
  
    [self getTuijianListData];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getTuijianListData];
    
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getTuijianListData];
    
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
    [self.tableView registerClass:[HEssenceTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[HEssenceLastTableViewCell class] forCellReuseIdentifier:@"lastCell"];
}

#pragma mark - UItableViewcell 的个数及cell的设置
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 5) {
        return 125;
    }else{
        return 44;
    }
}

#pragma mark - tableViewCell设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < 5) {
        
        HEssenceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        ExceedListModel *model = self.dataArray[indexPath.row];
        cell.collecBtn.tag = 1000 +indexPath.row;
        cell.viewModel = model;
        [cell.collecBtn addTarget:self action:@selector(clickCillecButton:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }else{
        HEssenceLastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lastCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        ExceedListModel *model = self.dataArray[indexPath.row];
        
        [cell cellForModel:model Row: indexPath.row];
        return  cell;
    }
}

#pragma mark - 点击收藏按钮的点击事件
-(void) clickCillecButton:(UIButton *)sender {
    if (kUserLogin  == NO) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }else{
        ExceedListModel *model = self.dataArray[sender.tag - 1000];
        [self.view showHudWithActivity:@"正在加载"];
        [self.bookHelper removeNovelWithFictionId:model.FictionId UserId:kUserID success:^(NSDictionary *response) {
            
            st_dispatch_async_main(^{
                [self.view hideHubWithActivity];
                [SVProgressHUD showSuccessWithStatus:@"成功"];
                if (sender.selected) {
                    model.IsCollect = @"0";
                }else{
                    model.IsCollect = @"1";
                }
                [self.tableView reloadData];
            });
            
            return ;
        } faild:^(NSString *response, NSError *error) {
            [self.view hideHubWithActivity];
            [SVProgressHUD showSuccessWithStatus:@"失败"];
        }];
    }
}

#pragma mark - tableViewCell的点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ExceedListModel *model = self.dataArray[indexPath.row];
    NovelDetailViewController *vc = [[NovelDetailViewController alloc] init];
    vc.bookId = model.FictionId;
    [self.navigationController pushViewController:vc animated:YES];
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
    [self.rightBtn setTitle:@"全部" forState:UIControlStateNormal];
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
    NSArray *array = @[@"全部",@"完本",@"连载"];
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
        [self.rightBtn setTitle:name forState:UIControlStateNormal];
        if ([name isEqualToString:@"连载"]) {
            self.pagenum = 1;
            self.statusNum = @"1";
        }else if ([name isEqualToString:@"完本"]){
            self.statusNum = @"2";
            self.pagenum = 1;
        }else if ([name isEqualToString:@"全部"]){
            self.statusNum = @"3";
            self.pagenum = 1;
        }
        
        [self getTuijianListData];
    }];
}

#pragma mark - 推荐网络数据的获取
-(void) getTuijianListData {
    
    NSString *userId = @"00000000-0000-0000-0000-000000000000";
    if (kUserLogin == YES) {
        userId = kUserID;
    }
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper chaojinghuaListWithUserId:userId Status:self.statusNum PageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] success:^(NSArray *response) {
        st_dispatch_async_main(^{
            if (self.pagenum == 1) {
                self.dataArray = [[NSMutableArray alloc] init];
            }
            for (int i=0; i<response.count; i++) {
                ExceedListModel *model = [ExceedListModel mj_objectWithKeyValues:response[i]];
                
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
            [self getTuijianListData];
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
