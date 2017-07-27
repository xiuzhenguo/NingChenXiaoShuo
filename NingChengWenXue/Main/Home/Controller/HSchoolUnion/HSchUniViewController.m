//
//  HSchUniViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/7.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HSchUniViewController.h"
#import "HSchUniTableViewCell.h"
#import "HFaileViewController.h"
// 实体文学列表
#import "HEntLitListViewController.h"
#import "HLitDetailViewController.h"
#import "HCreateClubViewController.h"
#import "HMyClubListViewController.h"
#import "HSchSearchViewController.h"
#import "NCHomePageHelper.h"
#import "UnionHomeModel.h"
#import "UnionModel.h"

@interface HSchUniViewController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *tableHeadView;
@property (nonatomic, strong) NSArray *btnArray;
@property (nonatomic, strong) UIButton *createBtn;
@property (nonatomic, strong) UIButton *clubBtn;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HSchUniViewController

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
    
    self.title = @"校园联盟";
    self.btnArray = @[@"校文联重要人事变动通知",@"校文联除名社团名单公告",@"文学社自主解散申请流程",@"校文联成员单位调整通知"];
    // 添加导航栏
    [self setUpNavButtonUI];
    // 添加TableView视图
    [self setUpUITableViewUI];
    // 添加底部创建按钮
    [self setUpFootUIButtonUI];
    
    [self setUpMyClubsButton];
    
    [self getDataList];
}

#pragma mark - 添加我的社团按钮
-(void) setUpMyClubsButton {
    self.clubBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 70, BXScreenH - 64 - 190, 60, 60)];
    self.clubBtn.backgroundColor = BXColor(236,105,65);
    
    [self.clubBtn setImage:[UIImage imageNamed:@"我的联盟"] forState:UIControlStateNormal];
    [self.clubBtn setTitle:@"我的社团" forState:UIControlStateNormal];
    self.clubBtn.titleLabel.font = ELEFont;
    self.clubBtn.layer.cornerRadius = 30;
    self.clubBtn.clipsToBounds = YES;
    // 按钮图片和标题总高度
    CGFloat totalHeight = (self.clubBtn.imageView.frame.size.height + self.clubBtn.titleLabel.frame.size.height);
    // 设置按钮图片偏移
    [self.clubBtn setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - self.clubBtn.imageView.frame.size.height), 0.0, 0.0, -self.clubBtn.titleLabel.frame.size.width)];
    // 设置按钮标题偏移
    [self.clubBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -self.clubBtn.imageView.frame.size.width, -(totalHeight - self.clubBtn.titleLabel.frame.size.height),0.0)];
    [self.view addSubview:self.clubBtn];
    [self.clubBtn addTarget:self action:@selector(clickClubButton) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 点击进入我的社团
-(void) clickClubButton {
    HMyClubListViewController *vc = [[HMyClubListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 创建UITableView视图
-(void) setUpUITableViewUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH-64 - 49) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[HSchUniTableViewCell class] forCellReuseIdentifier:@"cell"];
    // 头视图
    self.tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 242)];
    self.tableHeadView.backgroundColor = BXColor(242,242,242);
    self.tableView.tableHeaderView = self.tableHeadView;
    // 添加轮播图
    [self setUpTableHeaderScrollViewUI];
    // 添加四个按钮
    [self setUpTableHeadViewButtonUI];
}

#pragma mark - tableView头视图--轮播图设置
- (void) setUpTableHeaderScrollViewUI {
    NSArray *imageNames = @[@"上首页_1",@"上首页_2",@"上首页_3",@"上首页_4",@"上首页_5",@"上首页_6"];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 144) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.tableHeadView addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // --- 轮播时间间隔，默认1.0秒，可自定义
    cycleScrollView.autoScrollTimeInterval = 2.0;
}

#pragma mark - 头视图——轮播图下四个按钮设置
-(void) setUpTableHeadViewButtonUI {
    for (int i = 0; i < 4; i++) {
        UIButton *typeBtn = [[UIButton alloc] initWithFrame:CGRectMake(i%2*(BXScreenW/2.0), 144+i/2*44, BXScreenW/2.0-0.5, 43.5)];
        typeBtn.backgroundColor = [UIColor whiteColor];
        typeBtn.tag = 1000+i;
        [typeBtn setTitle:self.btnArray[i] forState:UIControlStateNormal];
        typeBtn.titleLabel.font = FIFFont;
        [self.tableHeadView addSubview:typeBtn];
        if (i == 0) {
            [typeBtn setTitleColor:BXColor(130,203,238) forState:UIControlStateNormal];
        }else if (i == 1){
            [typeBtn setTitleColor:BXColor(235,189,91) forState:UIControlStateNormal];
        }else if (i == 2){
            [typeBtn setTitleColor:BXColor(133,203,179) forState:UIControlStateNormal];
        }else{
            [typeBtn setTitleColor:BXColor(218,143,163) forState:UIControlStateNormal];
        }
        
        UILabel *HorizontalLab = [[UILabel alloc] initWithFrame:CGRectMake(i%2*(BXScreenW/2.0), 144+i/2*44+43.5, BXScreenW/2.0, 0.5)];
        HorizontalLab.backgroundColor = BXColor(195,195,195);
        [self.tableHeadView addSubview:HorizontalLab];
    }
    
    UILabel *VerticalLab = [[UILabel alloc] initWithFrame:CGRectMake(BXScreenW/2.0-0.5, 144, 0.5, 88)];
    VerticalLab.backgroundColor = BXColor(195,195,195);
    [self.tableHeadView addSubview:VerticalLab];
}

#pragma mark - UItableViewcell 的个数及cell的设置
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    UnionModel *listModel = self.dataArray.firstObject;
    return listModel.CommunityIndexList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

#pragma mark - tableViewCell设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HSchUniTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UnionModel *listModel = self.dataArray.firstObject;
    UnionHomeModel *model = listModel.CommunityIndexList[indexPath.row];
    cell.viewModel = model;
    
    return cell;
    
}

#pragma mark - tableViewCell的点击事件 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HLitDetailViewController *vc = [[HLitDetailViewController alloc] init];
    UnionModel *listModel = self.dataArray.firstObject;
    UnionHomeModel *model = listModel.CommunityIndexList[indexPath.row];
    vc.comId = model.Id;
    vc.title = model.CommunityName;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableView的分区头设置
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 44)];
    UILabel *verLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 14.5, 3, 15)];
    verLab.backgroundColor = BXColor(236,150,65);
    [backView addSubview:verLab];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 90, 44)];
    nameLab.text = @"实体文学社";
    nameLab.font = [UIFont boldSystemFontOfSize:16];
    nameLab.textColor = BXColor(35,35,35);
    [backView addSubview:nameLab];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLab.frame)+10, 0, BXScreenW - CGRectGetWidth(nameLab.frame)-50, 44)];
    [btn setTitle:@"全部 >" forState:UIControlStateNormal];
    [btn setTitleColor:BXColor(152,152,152) forState:UIControlStateNormal];
    btn.titleLabel.font = FIFFont;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [backView addSubview:btn];
    [btn addTarget:self action:@selector(clickEntAllButton) forControlEvents:UIControlEventTouchUpInside];
    return backView;
}

#pragma mark - 实体文学全部按钮的点击事件
-(void) clickEntAllButton {
    HEntLitListViewController *vc = [[HEntLitListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate(轮播图的点击方法)

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
}

#pragma mark - 底部创建按钮
-(void) setUpFootUIButtonUI {
    UIView *footBackView = [[UIView alloc] initWithFrame:CGRectMake(0, BXScreenH - 49 - 64, BXScreenW, 49)];
    footBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footBackView];
    
    self.createBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW/3.0, 0, BXScreenW/3.0, 49)];
    self.createBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    [footBackView addSubview:self.createBtn];
    
    
}

#pragma mark - 创建社团
-(void) clickCreateUIButton {
    if (kUserLogin == NO) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        HCreateClubViewController *vc = [[HCreateClubViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 查看失败原因
-(void) clickFaileButton {
    HFaileViewController *vc = [[HFaileViewController alloc] init];
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
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(0, 0, 80, 30);
    [self.rightBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark - 导航栏右侧搜索按钮点击事件
-(void) rightNavBtnAction:(UIButton *)sender {
    NSLog(@"搜索");
    HSchSearchViewController *vc = [[HSchSearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 首页数据的获取
-(void) getDataList {
    NSString *userid = @"00000000-0000-0000-0000-000000000000";
    if (kUserLogin == YES) {
        userid = kUserID;
    }else{
        userid = @"00000000-0000-0000-0000-000000000000";
    }
    [self.helper communityHomeWithPageIndex:@"1" userId:userid success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            UnionModel *model = [UnionModel mj_objectWithKeyValues:response];
            [self.dataArray addObject:model];
                    
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self.tableView reloadData];
            if (model.AppyStatus == 0) {
                [self.createBtn setTitle:@"创建" forState:UIControlStateNormal];
                self.createBtn.backgroundColor = BXColor(236,105,65);
                [self.createBtn addTarget:self action:@selector(clickCreateUIButton) forControlEvents:UIControlEventTouchUpInside];
            }else if (model.AppyStatus == 1){
                [self.createBtn setTitle:@"审核失败" forState:UIControlStateNormal];
                self.createBtn.backgroundColor = BXColor(236,105,65);
                [self.createBtn addTarget:self action:@selector(clickFaileButton) forControlEvents:UIControlEventTouchUpInside];
            }else{
                self.createBtn.backgroundColor = BXColor(195,195,195);
                [self.createBtn setTitle:@"审核中" forState:UIControlStateNormal];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
     
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.view showFailedViewReloadBlock:^{
            
            [self getDataList];
        }];
    }];
}

@end
