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

@interface MineViewController ()<UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource,LoginDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *logoutTableView;
@property (nonatomic, strong) UIView *loginView;
@property (nonatomic, strong) UIView *logoutView;
@property (nonatomic, strong) NSArray *imgArray;
@property (strong, nonatomic) BCWelcomHepler *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
//@property (nonatomic, strong) NSArray *nameArray;

@end

@implementation MineViewController

-(BCWelcomHepler *)helper{
    if (!_helper) {
        _helper = [BCWelcomHepler helper];
    }
    return _helper;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (kUserLogin == YES) {
        [self getMineFirstData:kUserID];
    }else{
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"我的";
    self.imgArray = @[@[@"消息管理",@"好友动态"],@[@"个人资料",@"卡片勋章",@"uu银行",@"各种记录",@"推广奖励",@"商城"],@[@"退出登录"]];
    [self setUpTableViewUI];
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
    }else{
        [self.tableView.mj_header endRefreshing];
    }
    
}

#pragma mark - 创建UITableViewUI
- (void) setUpTableViewUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LoginTableViewCell" bundle:nil] forCellReuseIdentifier:@"firstCell"];
    [self.tableView registerClass:[LogoutTableViewCell class] forCellReuseIdentifier:@"outCell"];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 113)];
    imgView.image = [UIImage imageNamed:@"幻灯片"];
    self.tableView.tableHeaderView = imgView;
    
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
            cell.nameLab.text = model.UserName;
            cell.jianjieLab.text = model.UserSign;
            cell.fensiLab.text = [NSString stringWithFormat:@"%ld",model.UserFansCount];;
            cell.guanzhuLab.text = [NSString stringWithFormat:@"%ld",model.UserAttentionCount];
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
        }
        if (indexPath.section == 1 && indexPath.row == 0) {
            MMessageViewController *vc = [[MMessageViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
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
        [self.view showFailedViewReloadBlock:^{
            
            [self getMineFirstData:userid];
        }];
    }];
}


@end
