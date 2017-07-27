//
//  HMyClubViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HMyClubViewController.h"
#import "HMyClubHeadView.h"
#import "HLitDetOneTableViewCell.h"
#import "HLitDetMidTableViewCell.h"
#import "HAWorksTableViewCell.h"
#import "HMyClubWorkViewController.h"
#import "HMyClubPerViewController.h"

// 资料
#import "HClubMeansViewController.h"
#import "NCHomePageHelper.h"
#import "UnionDetailModel.h"
#import "ExcellentFictionModel.h"
#import "UserItemModel.h"

@interface HMyClubViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HMyClubHeadView *headerView;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) EmptyDataView *emptyView;


@end

@implementation HMyClubViewController

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
    
    [self getCommunityDetailData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加导航栏
    [self setUpNavButtonUI];
    // 添加tableView
    [self setUpUITableViewUI];
    
    
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
    [self.tableView registerClass:[HLitDetOneTableViewCell class] forCellReuseIdentifier:@"firstCell"];
    [self.tableView registerClass:[HLitDetMidTableViewCell class] forCellReuseIdentifier:@"MidCell"];
    [self.tableView registerClass:[HAWorksTableViewCell class] forCellReuseIdentifier:@"lastCell"];
    
    
}

#pragma mark - 创建tableView头视图
-(void) setUpTableViewHeaderViewUI {
    
    self.headerView = [[HMyClubHeadView alloc] init];
    self.headerView.model = self.dataArray.firstObject;

    
    self.tableView.tableHeaderView = self.headerView;
    
}


#pragma mark - UItableViewcell 的个数及cell的设置
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    UnionDetailModel *model = self.dataArray.firstObject;
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else{
        return model.ExcellentFiction.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else if (indexPath.section == 1){
        return 141;
    }else{
        
        return 80;
    }
}

#pragma mark - tableViewCell设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UnionDetailModel *detail = self.dataArray.firstObject;
    if (indexPath.section == 0) {
        HLitDetOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.numLab.text = [NSString stringWithFormat:@"(%ld)",detail.FictionCount];
        return cell;
    }else if (indexPath.section == 1){
        HLitDetMidTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MidCell" forIndexPath:indexPath];
        //        UserItemModel *model = detail.UserItem;
        
        cell.count = detail.UserItem.count;
        cell.viewModel = detail.UserItem;
        cell.numLab.text = [NSString stringWithFormat:@"(%ld)",detail.UserCount];
        
        return cell;
    }else{
        
        HAWorksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lastCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ExcellentFictionModel *model = detail.ExcellentFiction[indexPath.row];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.Image] placeholderImage:[UIImage imageNamed:@"书"]];
        cell.nameLab.text = model.FictionName;
        cell.timeLab.text = model.timeinfo;
        //        cell.numLab.text = @"2020220阅读/258289评论/200220收藏";
        cell.numLab.text = [NSString stringWithFormat:@"%ld阅读/%ld评论/%ld收藏",model.Reader,model.EvalauteIndex,model.Collect];
        
        return cell;
    }

    
}

#pragma mark - tableViewCell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UnionDetailModel *model = self.dataArray.firstObject;
    if (indexPath.section == 0) {
        HMyClubWorkViewController *vc = [[HMyClubWorkViewController alloc] init];
        vc.communityID = model.Id;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1){
        HMyClubPerViewController *vc = [[HMyClubPerViewController alloc] init];
        vc.communityID = model.Id;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NovelDetailViewController *vc = [[NovelDetailViewController alloc] init];
        ExcellentFictionModel *userModel = model.ExcellentFiction[indexPath.row];
        vc.bookId = userModel.FictionId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 设置分区尾
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else if (section == 1){
        return 35;
    }else{
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 35)];
        back.backgroundColor = [UIColor whiteColor];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, BXScreenW-15, 35)];
        lable.text = @"优秀作品展示";
        lable.font = THIRDFont;
        lable.textColor = BXColor(152,152,152);
        [back addSubview:lable];
        return back;
    }else{
        UIView *view = [[UIView alloc] init];
        return view;
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
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 30);
    [rightBtn setTitle:@"资料" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark - 导航栏右侧资料按钮点击事件
-(void) rightNavBtnAction:(UIButton *)sender {

    HClubMeansViewController *vc = [[HClubMeansViewController alloc] init];
    vc.comID = self.comId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 社团详情数据的获取
-(void) getCommunityDetailData {
    
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper communityDetailWithID:self.comId userId:kUserID success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            self.dataArray = [[NSMutableArray alloc] init];
            
            UnionDetailModel *model = [UnionDetailModel mj_objectWithKeyValues:response];
            
            [self.dataArray addObject:model];
            
            if(self.dataArray.count == 0){
                [self.emptyView removeFromSuperview];
                self.emptyView = [[EmptyDataView alloc]initWithFrame:self.view.bounds title:@"没有数据" actionTitle:nil];
                [self.tableView addSubview:self.emptyView];
                
            }else{
                [self.emptyView removeFromSuperview];
            }
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self setUpTableViewHeaderViewUI];
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
            
            [self getCommunityDetailData];
        }];
    }];
}

@end
