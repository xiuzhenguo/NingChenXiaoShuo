//
//  ProfileViewController.m
//  IrregularTabBar
//
//  Created by JYJ on 16/5/3.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "LoginTableViewCell.h"
#import "MineTableViewCell.h"
#import "LogoutTableViewCell.h"
#import "BCWelcomHepler.h"
#import "MineInforModel.h"
#import "MinePerDataViewController.h"
#import "MMessageViewController.h"
#import "NCHomePageHelper.h"
#import "SysMessageModel.h"
#import "MineChangeViewController.h"
#import "MShopViewController.h"
#import "MainShopViewController.h"


@interface MineViewController ()<UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource,LoginDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *logoutTableView;
@property (nonatomic, strong) UIView *loginView;
@property (nonatomic, strong) UIView *logoutView;
@property (nonatomic, strong) NSArray *imgArray;
@property (strong, nonatomic) BCWelcomHepler *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NCHomePageHelper *help;
@property (nonatomic, strong) NSMutableArray *picArray;
//@property (nonatomic, strong) NSArray *nameArray;

@end

@implementation MineViewController

-(BCWelcomHepler *)helper{
    if (!_helper) {
        _helper = [BCWelcomHepler helper];
    }
    return _helper;
}

-(NCHomePageHelper *)help{
    if (!_help) {
        _help = [NCHomePageHelper helper];
    }
    return _help;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (kUserLogin == YES) {
        [self getMineFirstData:kUserID];
    }else{
        [self.tableView reloadData];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;//不设置为黑色背景
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"我的";
    self.imgArray = @[@[@"消息管理",@"好友动态"],@[@"个人资料",@"卡片勋章",@"UU银行",@"各种记录",@"推广奖励",@"商城"],@[@"退出登录"]];
    [self setUpTableViewUI];
    [self getLunBoPictrueData];
    
    if (kUserLogin == YES) {
        [self getMineFirstData:kUserID];
    }
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    if (kUserLogin == YES) {
        [self getMineFirstData:kUserID];
        [self getLunBoPictrueData];
    }else{
        [self getLunBoPictrueData];
        
    }
    
}

#pragma mark - 创建UITableViewUI
- (void) setUpTableViewUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, BXScreenW, BXScreenH-128) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LoginTableViewCell" bundle:nil] forCellReuseIdentifier:@"firstCell"];
    [self.tableView registerClass:[LogoutTableViewCell class] forCellReuseIdentifier:@"outCell"];
    
}

#pragma mark - UItableViewcell 的个数及cell的设置
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (kUserLogin == YES) {
        return 4;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (kUserLogin == YES) {
        if (section == 0) {
            return 1;
        }else if (section == 1){
            return 2;
        }else if (section== 3){
            return 1;
        }else{
            return 6;
        }
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (kUserLogin == YES) {
        if (indexPath.section == 0) {
            return 123;
        }else{
            return 44;
        }
    }else{
        return 83;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (kUserLogin == NO) {
        LogoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"outCell" forIndexPath:indexPath];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        MineInforModel *model = self.dataArray.firstObject;
        if (indexPath.section == 0) {
            LoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.UserImage] placeholderImage:[UIImage imageNamed:@"头像"]];
            cell.imgView.layer.cornerRadius = 26.5;
            cell.imgView.clipsToBounds = YES;
            cell.nameLab.text = model.UserName;
            cell.jianjieLab.text = model.UserSign;
            cell.fensiLab.text = [NSString stringWithFormat:@"%ld",model.UserFansCount];;
            cell.guanzhuLab.text = [NSString stringWithFormat:@"%ld",model.UserAttentionCount];
            [cell.inforBtn addTarget:self action:@selector(clickInforButton) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            
            MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            cell.imgView.image = [UIImage imageNamed:self.imgArray[indexPath.section-1][indexPath.row]];
            cell.nameLab.text = self.imgArray[indexPath.section-1][indexPath.row];
            return cell;
        }
    }
}

#pragma mark - tableViewCell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (kUserLogin == NO) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if (indexPath.section == 2 && indexPath.row == 0) {//个人资料
            MinePerDataViewController *vc = [[MinePerDataViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if(indexPath.section == 1 && indexPath.row == 0) {//消息管理
            MMessageViewController *vc = [[MMessageViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if(indexPath.section == 3) {// 退出登录
            [self clickLogOutButton];
        }else if (indexPath.section == 0){// 个人信息
            
            MineChangeViewController *vc = [[MineChangeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.section == 2 && indexPath.row == 5){//商城
            
            MainShopViewController *vc = [[MainShopViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
           
            [SVProgressHUD showErrorWithStatus:@"此功能暂未实现"];
        }
    }
}

#pragma mark - 个人信息按钮的点击事件
-(void)clickInforButton{
    MineChangeViewController *vc = [[MineChangeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 退出登录功能
-(void) clickLogOutButton {
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"" message:@"是否退出登录" preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(alertControl) wAlert = alertControl;
    [wAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        // 点击确定按钮的时候, 会调用这个block
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:KServiceAccount];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLoginStateKey];
        [self.tableView reloadData];
        
    }]];
    
    [wAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:wAlert animated:YES completion:nil];
}

#pragma mark - 登录成功后回调
- (void)logindelegate:(NSString *)userId{
    [self getMineFirstData:userId];
}

#pragma mark - 分区尾设置
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 10)];
    footView.backgroundColor = BXColor(242,242,242);
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (kUserLogin == NO) {
        return 0.01;
    }else{
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark - 我的首页数据获取
-(void)getMineFirstData:(NSString *)userid{
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper mineHomeInfoWithUserId:userid success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
          
            self.dataArray = [[NSMutableArray alloc] init];
            MineInforModel *model = [MineInforModel mj_objectWithKeyValues:response];
            
            [self.dataArray addObject:model];
            
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
        [self.tableView showFailedViewReloadBlock:^{
            
            [self getMineFirstData:userid];
            [self getLunBoPictrueData];
        }];
    }];
}

#pragma mark - 轮播图数据解析
-(void) getLunBoPictrueData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.help CarouselPictrueWithSuccess:^(NSArray *response) {
        st_dispatch_async_main(^{
            [self.view hideHubWithActivity];
            self.picArray = [[NSMutableArray alloc] init];
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                SysMessageModel *model = [SysMessageModel mj_objectWithKeyValues:response[i]];
                
                [self.picArray addObject:model];
                [arr addObject:model.FictionImage];
                
            }
            [self setHeadCycleScrollView:arr];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        //        [SVProgressHUD showSuccessWithStatus:@"失败"];
        [self.view hideHubWithActivity];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView showFailedViewReloadBlock:^{
            
            [self getMineFirstData:kUserID];
            [self getLunBoPictrueData];
        }];
    }];
}

#pragma mark - 创建顶部轮播图
- (void) setHeadCycleScrollView:(NSMutableArray *)dataArray {
    
    NSArray *groupImgs = [dataArray copy];
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 176) delegate:self placeholderImage:[UIImage imageNamed:@"书"]];
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.imageURLStringsGroup = groupImgs;
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    self.tableView.tableHeaderView = self.cycleScrollView;
    self.cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // --- 轮播时间间隔，默认1.0秒，可自定义
    self.cycleScrollView.autoScrollTimeInterval = 2.0;
}

#pragma mark - SDCycleScrollViewDelegate(轮播图的点击方法)

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    SysMessageModel *model = self.picArray[index];
    NovelDetailViewController *vc = [[NovelDetailViewController alloc] init];
    vc.bookId = model.FictionId;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
