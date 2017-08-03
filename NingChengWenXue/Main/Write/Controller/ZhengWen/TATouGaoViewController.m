//
//  TATouGaoViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "TATouGaoViewController.h"
#import "TAWeiTouGaoTableViewCell.h"
#import "TAWeiTouGaoView.h"
#import "TAWanJieHeaderView.h"
#import "TARuleViewController.h"
#import "TAMoreViewController.h"
#import "TABookViewController.h"
#import "NCWriteHelper.h"
#import "ZhengWenListModel.h"
#import "ZWDetailModel.h"
#import "NovelDetailViewController.h"

@interface TATouGaoViewController ()<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) TAWanJieHeaderView *headView;
@property (nonatomic, strong) TAWeiTouGaoView *weitougaoView;
@property (strong, nonatomic) NCWriteHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation TATouGaoViewController

-(NCWriteHelper *)helper{
    if (!_helper) {
        _helper = [NCWriteHelper helper];
    }
    return _helper;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;//不设置为黑色背景
    
    [self getZhengWenDetailData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"征文详情";
    
    [self setUpNavButtonUI];
    
    [self setUpTableViewUI];
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    
    [self getZhengWenDetailData];
    
}

#pragma mark - 创建TableView
- (void) setUpTableViewUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 64) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TAWeiTouGaoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
//    [self setUpTableHeaderViewUI];
}

#pragma mark - 创建tableView 头视图(投稿状态)
-(void) setUpTableHeaderViewUI {
    
    self.headerView = [[UIView alloc] init];
    self.headerView.backgroundColor = [UIColor whiteColor];
    
    self.weitougaoView = [[TAWeiTouGaoView alloc] init];
    ZhengWenListModel *model = self.dataArray.firstObject;
    self.weitougaoView.model = model;
    self.weitougaoView.frame = CGRectMake(0, 0, BXScreenW, self.weitougaoView.height);
    [self.headerView addSubview:self.weitougaoView];
    
    UILabel *lineLab = [[UILabel alloc] init];
    lineLab.backgroundColor = BXColor(195,195,195);
    [self.headerView addSubview:lineLab];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn addTarget:self action:@selector(clickGuiZeButton) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:btn];
    // 活动规则
    UILabel *guizeLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, BXScreenW - 150, 44)];
    guizeLab.textColor = BXColor(236,105,65);
    guizeLab.font = FIFFont;
    guizeLab.text = @"活动规则";
    [btn addSubview:guizeLab];
    
    UIImageView *moreImg = [[UIImageView alloc] initWithFrame:CGRectMake(BXScreenW - 25, 20, 15, 15)];
    moreImg.image = [UIImage imageNamed:@"箭头"];
    [btn addSubview:moreImg];
    
    if (model.IsTg == 0) {
        
        UIButton *tougaoBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.weitougaoView.frame), BXScreenW - 30, 44)];
        tougaoBtn.backgroundColor = BXColor(236,105,65);
        tougaoBtn.titleLabel.font = FIFFont;
        tougaoBtn.layer.cornerRadius = 5;
        [tougaoBtn setTitle:@"马上投稿" forState:UIControlStateNormal];
        [tougaoBtn addTarget:self action:@selector(clickTouGaoButton) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:tougaoBtn];
        
        lineLab.frame = CGRectMake(0, CGRectGetMaxY(self.weitougaoView.frame)+14.5+44, BXScreenW, 0.5);
        btn.frame = CGRectMake(0, CGRectGetMaxY(tougaoBtn.frame)+15, BXScreenW, 44);
    }else{
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.weitougaoView.frame), BXScreenW, 0.5)];
        line.backgroundColor = BXColor(195,195,195);
        [self.headerView addSubview:line];
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(line.frame)+0.5, BXScreenW - 120, 43)];
        nameLab.font = FIFFont;
        nameLab.textColor = BXColor(152,152,152);
        nameLab.text = @"小说名称";
        [self.headerView addSubview:nameLab];
        
        UIButton *tuichuBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 95, CGRectGetMaxY(line.frame)+9.5, 80, 24)];
        tuichuBtn.titleLabel.font = FIFFont;
        tuichuBtn.layer.cornerRadius = 5;
        tuichuBtn.layer.borderColor = BXColor(152,152,152).CGColor;
        tuichuBtn.layer.borderWidth = 0.5;
        [tuichuBtn setTitleColor:BXColor(152,152,152) forState:UIControlStateNormal];
        [tuichuBtn addTarget:self action:@selector(clickTuiChuButton) forControlEvents:UIControlEventTouchUpInside];
        [tuichuBtn setTitle:@"退出征文" forState:UIControlStateNormal];
        [self.headerView addSubview:tuichuBtn];
        
        lineLab.frame = CGRectMake(0, CGRectGetMaxY(nameLab.frame), BXScreenW, 0.5);
        
        btn.frame = CGRectMake(0, CGRectGetMaxY(lineLab.frame), BXScreenW, 44);
    }

    self.headerView.frame = CGRectMake(0, 0, BXScreenW, CGRectGetMaxY(btn.frame));
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - 创建tableView 头视图(评选状态)
-(void) setUpTableHeadViewUI {
    self.headView = [[TAWanJieHeaderView alloc] init];
    ZhengWenListModel *model = self.dataArray.firstObject;
    self.headView.model = model;
    self.headView.frame = CGRectMake(0, 0, BXScreenW, self.headView.height);
    self.headView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headView;
    
    [self.headView.btn addTarget:self action:@selector(clickRuleButton) forControlEvents:UIControlEventTouchUpInside];
}

-(void) clickRuleButton {
    TARuleViewController *vc = [[TARuleViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 马上投稿按钮的点击事件
-(void) clickTouGaoButton {
    if (kUserLogin == NO) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    TABookViewController *vc = [[TABookViewController alloc] init];
    vc.ficStr = self.ficId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 退出征文按钮的点击事件
-(void) clickTuiChuButton {
    if (kUserLogin == NO) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"" message:@"是否删除作品" preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(alertControl) wAlert = alertControl;
    [wAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        // 点击确定按钮的时候, 会调用这个block
        [self tuiChuNovelData];
        
    }]];
    
    [wAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:wAlert animated:YES completion:nil];
}

#pragma mark - 活动规则按钮的点击事件
-(void) clickGuiZeButton {
    TARuleViewController *vc = [[TARuleViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ZhengWenListModel *model = self.dataArray.firstObject;
    return model.FictionList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark - tableViewCell设置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TAWeiTouGaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZhengWenListModel *model = self.dataArray.firstObject;
    ZWDetailModel *list = model.FictionList[indexPath.row];
    
    cell.row = indexPath.row;
    cell.viewModel = list;
    
    return cell;
}

#pragma mark - tableViewCell的点击事件跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZhengWenListModel *model = self.dataArray.firstObject;
    ZWDetailModel *list = model.FictionList[indexPath.row];
    NovelDetailViewController *vc = [[NovelDetailViewController alloc] init];
    vc.bookId = list.FictionId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 分区头设置
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 59;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 59)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 15)];
    grayView.backgroundColor = BXColor(242, 242, 242);
    [backView addSubview:grayView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 29, 3, 16)];
    lab.backgroundColor = BXColor(236,105,65);
    [backView addSubview:lab];
    
    UILabel *rankLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+15, 15, 100, 43.5)];
    rankLab.text = @"人气榜";
    rankLab.font = [UIFont systemFontOfSize:17];
    rankLab.textColor = BXColor(40,40,40);
    [backView addSubview:rankLab];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(165, 15, BXScreenW - 180, 43.5)];
    btn.titleLabel.font = FIFFont;
    [btn setTitleColor:BXColor(152, 152, 152) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickSectionMoreButton) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"更多>" forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [backView addSubview:btn];
    
    for (int i = 0; i < 2; i++) {
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 14.5 + i*44, BXScreenW, 0.5)];
        lineLab.backgroundColor = BXColor(242, 242, 242);
        [backView addSubview:lineLab];
    }
    
    return backView;
}

#pragma mark - tableView分区头更多按钮的点击事件
-(void) clickSectionMoreButton {
    TAMoreViewController *vc = [[TAMoreViewController alloc] init];
    vc.ficID = self.ficId;
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
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 30);
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [rightBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark - 右侧分享按钮的点击事件
-(void) clickRightButton {
    
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 征文详情获取
-(void) getZhengWenDetailData {
    NSString *userId = @"00000000-0000-0000-0000-000000000000";
    if (kUserLogin == YES) {
        userId = kUserID;
    }
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper zhengWenDetailWithID:self.ficId UserId:userId success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            
            ZhengWenListModel *model = [ZhengWenListModel mj_objectWithKeyValues:response];
            
            [self.dataArray addObject:model];
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self.tableView reloadData];
            if (self.type == 1) {
                [self setUpTableHeaderViewUI];
            }else{
                [self setUpTableHeadViewUI];
            }
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.tableView.mj_header endRefreshing];
        [self.view showFailedViewReloadBlock:^{
            [self getZhengWenDetailData];
        }];
    }];
}

#pragma mark - 退出征文
-(void)tuiChuNovelData {
    [self.helper tuiChuCallForPapersWithID:@"" SolicitationId:self.ficId UserId:kUserID success:^(NSDictionary *response) {
        
    } faild:^(NSString *response, NSError *error) {
        
    }];
}

@end
