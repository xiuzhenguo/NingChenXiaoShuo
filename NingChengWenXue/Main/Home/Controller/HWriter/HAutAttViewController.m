//
//  HAutAttViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/19.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAutAttViewController.h"
#import "HAutPerTableViewCell.h"
#import "FansModel.h"
#import "NCHomePageHelper.h"
#import "HAuthorsViewController.h"

@interface HAutAttViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) EmptyDataView *emptyView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pagenum;

@end

@implementation HAutAttViewController

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
    self.title = @"Ta的关注";
    self.pagenum = 1;
    // 添加导航栏
    [self setUpNavButtonUI];
    // 添加tableView
    [self setUpUITableViewUI];
    
    [self getFansListData];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getFansListData];
    
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getFansListData];
    
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
    [self.tableView registerClass:[HAutPerTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UItableViewcell 的个数及cell的设置
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

#pragma mark - tableViewCell设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HAutPerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    FansModel *model = self.dataArray[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.UserImage] placeholderImage:[UIImage imageNamed:@"打赏头像"]];
    cell.nameLab.text = model.FansName;
    cell.bookLab.text = model.AuthenticationName;
    cell.btn.tag = 1000 + indexPath.row;
    [cell.btn addTarget:self action:@selector(clickGuanZhuButton:) forControlEvents:UIControlEventTouchUpInside];
    if (model.Attention == false) {
        cell.btn.selected = NO;
        [cell.btn setTitle:@"关注" forState:UIControlStateNormal];
        [cell.btn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
        [cell.btn setImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
        cell.btn.borderColor = BXColor(236,105,65);
    }else{
        cell.btn.selected = YES;
        [cell.btn setTitle:@"已关注" forState:UIControlStateNormal];
        [cell.btn setTitleColor:BXColor(152,152,152) forState:UIControlStateNormal];
        [cell.btn setImage:[UIImage imageNamed:@"已关注"] forState:UIControlStateNormal];
        cell.btn.borderColor = BXColor(152,152,152);
    }
    
    return cell;
    
}

#pragma mark - tableViewCell点击跳转作者页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HAuthorsViewController *vc = [[HAuthorsViewController alloc] init];
    FansModel *model = self.dataArray[indexPath.row];
    vc.autherID = model.FansId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 关注好友的点击事件
-(void) clickGuanZhuButton:(UIButton *)sender {
    FansModel *model = self.dataArray[sender.tag - 1000];
    if (kUserLogin == NO) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }else{
        
        [self.helper attentionUserWithUserId:kUserID AppentionId:model.FansId success:^(NSDictionary *response) {
            st_dispatch_async_main(^{
                [self.view hideHubWithActivity];
                ETHttpModel *mode = [ETHttpModel mj_objectWithKeyValues:response];
                [SVProgressHUD showSuccessWithStatus:mode.datas];
                if ([self.autherId isEqualToString:kUserID]) {
                    [self.dataArray removeObjectAtIndex:sender.tag - 1000];
                    [self.tableView reloadData];
                    return ;
                }
                if (sender.selected) {
                    model.Attention = false;
                }else{
                    model.Attention = true;
                }
                [self.tableView reloadData];
            });
            
            return ;
        } faild:^(NSString *response, NSError *error) {
            [self.view hideHubWithActivity];
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }];
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
    
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 粉丝集合的获取
-(void) getFansListData {
    NSString *userId = @"00000000-0000-0000-0000-000000000000";
    if (kUserLogin == YES) {
        userId = kUserID;
    }
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper attionWithUserId:userId AuthorId:self.autherId PageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] success:^(NSArray *response) {
        st_dispatch_async_main(^{
            if (self.pagenum == 1) {
                self.dataArray = [[NSMutableArray alloc] init];
            }
            for (int i=0; i<response.count; i++) {
                FansModel *model = [FansModel mj_objectWithKeyValues:response[i]];
                
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
            [self getFansListData];
        }];
    }];
}

@end
