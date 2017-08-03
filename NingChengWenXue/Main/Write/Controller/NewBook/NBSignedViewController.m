
//
//  NBSignedViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/8.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBSignedViewController.h"
#import "NBSignedTableViewCell.h"
#import "NBDetailViewController.h"
#import "NCWriteHelper.h"
#import "NewBookModel.h"
#import "SignNovelModel.h"

@interface NBSignedViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UIView *headerView;
@property (strong, nonatomic) NCWriteHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *applyBtn;

@end

@implementation NBSignedViewController

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"申请签约";
    
    [self setUpNavButtonUI];
    
    [self setUpTableViewUI];
    
    [self getSignTiaoJianData];
}

#pragma mark - 创建UItableView视图
- (void) setUpTableViewUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 64) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[NBSignedTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 177)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
    
//    [self setUpTableHeaderViewUI];
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 223)];
    self.footView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = self.footView;
    
    [self setUpTableFootViewUI];
}


#pragma mark - tableView头视图的创建
-(void) setUpTableHeaderViewUI {
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(BXScreenW/2.0 - 40, 35, 80, 70)];
    img.image = [UIImage imageNamed:@"可以申请"];
    [self.headerView addSubview:img];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(img.frame)+12, BXScreenW - 30, 44)];
    btn.backgroundColor = BXColor(236,105,65);
    [btn setTitle:@"申请签约" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(clickQianYUeButton) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:btn];
    self.applyBtn = btn;
}

#pragma mark - UITableViewViewDelegate
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
// 每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NewBookModel *list = self.dataArray.firstObject;
    return list.Msg.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark - UItableViewCell 设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NBSignedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NewBookModel *list = self.dataArray.firstObject;
    SignNovelModel *model = list.Msg[indexPath.row];
    cell.titleLab.text = model.Msg;
    if (model.Result == true) {
        cell.typeLab.text = @"满足";
        cell.typeLab.textColor = BXColor(143,195,31);
    }else{
        cell.typeLab.text = @"不满足";
        cell.typeLab.textColor = BXColor(255,0,0);
    }
    
    return cell;
}

#pragma mark - 分区头设置
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 44)];
    back.backgroundColor = BXColor(242, 242, 242);
    
    UILabel *secLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, BXScreenW - 30, 44)];
    secLab.font = FIFFont;
    secLab.textColor = BXColor(101,101,101);
    secLab.text = @"申请签约要求";
    [back addSubview:secLab];
    
    return back;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark - 创建TableView的尾视图
-(void) setUpTableFootViewUI {
    UILabel *zhushiLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, BXScreenW - 30, 56)];
    zhushiLab.textColor = BXColor(101,101,101);
    zhushiLab.font = ELEFont;
    zhushiLab.numberOfLines = 0;
    [self.footView addSubview:zhushiLab];
    zhushiLab.text = [NSString stringWithFormat:@"亲，不用怕这些条件，这仅仅是线上申请签约通道。若您作品足够优秀，编辑大大还会在线下主动联系您签约哟。\n注：线上线下申请签约，编辑看的都是作品内容质量。"];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 56, BXScreenW, 35)];
    backView.backgroundColor = BXColor(242, 242, 242);
    [self.footView addSubview:backView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, BXScreenW - 30, 35)];
    lab.textColor = BXColor(101, 101, 101);
    lab.font = FIFFont;
    lab.text = @"签约福利";
    [backView addSubview:lab];
    NSArray *arr = @[@"1、作品获得更多的曝光机会",@"2、更好的享受福利（勤更及创作基金等）"];
    for (int i = 0; i < 2; i++) {
        UILabel *fulilab = [[UILabel alloc] initWithFrame:CGRectMake(15, 101+i*23, BXScreenW - 30, 13)];
        fulilab.textColor = BXColor(40,40,40);
        fulilab.font = FIFFont;
        fulilab.text = arr[i];
        [self.footView addSubview:fulilab];
    }
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
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 签约条件的获取
-(void)getSignTiaoJianData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper signConditionWithFictionId:self.bookId success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            
            NewBookModel *model = [NewBookModel mj_objectWithKeyValues:response];
            [self.dataArray addObject:model];
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
            if (model.SignType==2 && model.IsSatisfy==true && model.FictionApplyStatus==0) {
                [self setUpTableHeaderViewUI];
            }else if (model.SignType==2 && model.FictionApplyStatus==3){
                [self errorSignCondition];
            }else{
                [self notSignCondition];
                
            }
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.tableView.mj_header endRefreshing];
        [self.view showFailedViewReloadBlock:^{
            [self getSignTiaoJianData];
        }];
    }];
}

#pragma mark - 不满足签约条件下的头视图
-(void)notSignCondition {
    NewBookModel *model = self.dataArray.firstObject;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(BXScreenW/2.0 - 40, 35, 80, 70)];
    [self.headerView addSubview:img];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(img.frame)+12, BXScreenW - 30, 44)];
    btn.titleLabel.font = FIFFont;
    [btn setTitle:model.ResultMsg forState:UIControlStateNormal];
    [btn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    [self.headerView addSubview:btn];
    if (model.SignType==2 && model.IsSatisfy==false && model.FictionApplyStatus==0) {
        img.image = [UIImage imageNamed:@"不满足"];
    }
    if (model.SignType==2 && model.FictionApplyStatus==1){
        img.image = [UIImage imageNamed:@"审核中"];
    }
    if (model.SignType==1){
        img.image = [UIImage imageNamed:@"申请成功"];
    }
}

#pragma mark - 签约失败下的头视图
-(void)errorSignCondition {
    NewBookModel *model = self.dataArray.firstObject;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(BXScreenW/2.0 - 40, 35, 80, 70)];
    img.image = [UIImage imageNamed:@"不满足"];
    [self.headerView addSubview:img];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(img.frame)+23, BXScreenW - 30, 15)];
    btn.titleLabel.font = FIFFont;
    [btn setTitle:model.ResultMsg forState:UIControlStateNormal];
    [btn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    [self.headerView addSubview:btn];
    
    UIButton *errorBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(btn.frame)+10, BXScreenW - 30, 15)];
    errorBtn.titleLabel.font = THIRDFont;
    [errorBtn setTitle:@"详情" forState:UIControlStateNormal];
    [errorBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    [errorBtn addTarget:self action:@selector(clickErrorDetailButton) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:errorBtn];
}

#pragma mark - 签约失败详情按钮的点击事件
-(void)clickErrorDetailButton{
    NBDetailViewController *vc = [[NBDetailViewController alloc] init];
    vc.bookID = self.bookId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 申请签约按钮的点击事件
-(void) clickQianYUeButton {
    [self.helper applySignNovelWithFictionId:self.bookId AuthorId:kUserID success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [SVProgressHUD showSuccessWithStatus:@"申请成功"];
            [self.applyBtn removeFromSuperview];
            [self getSignTiaoJianData];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"申请失败"];
    }];
}

@end
