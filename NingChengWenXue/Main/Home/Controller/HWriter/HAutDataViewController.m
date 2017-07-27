//
//  HAutDataViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAutDataViewController.h"
#import "HAutDataTableViewCell.h"
#import "NCHomePageHelper.h"
#import "WriterPerModel.h"
#import "WriterNovelModel.h"
#import "WriterDynModel.h"
#import "HLitDetailViewController.h"

@interface HAutDataViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation HAutDataViewController

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
    self.view.backgroundColor = BXColor(242, 242, 242);
    self.title = @"详细资料";
    
    [self setUpNavButtonUI];
    
    // 测试死数据
    self.titleArray = @[@"昵称",@"性别",@"生日",@"个人签名",@"作者认证"];
//    self.dataArray = @[@[@"人不归",@"男",@"2001-02-20",@"尊师妹子加微博",@"凝成创作签约作者"],@[@"醉墨文学社"]];
    
    [self setUpTableViewUI];
    
    [self getAutherPersonData];
}

#pragma mark - 创建CollectionView视图
- (void) setUpTableViewUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = BXColor(242,242,242);
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[HAutDataTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 5;
    }else{
        WriterPerModel *model = self.listArray.firstObject;
        return model.CommunityList.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark - TableViewCell的设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HAutDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = self.titleArray[indexPath.row];
        cell.infoLab.text = self.dataArray[indexPath.row];
    }else if (indexPath.section == 1){
        WriterPerModel *model = self.listArray.firstObject;
        WriterNovelModel *list = model.CommunityList[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = @"社团名称";
        cell.infoLab.text = list.ComName;
        
    }
    
    return cell;
}

#pragma mark - tableViewCell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        WriterPerModel *model = self.listArray.firstObject;
        WriterNovelModel *list = model.CommunityList[indexPath.row];
        HLitDetailViewController *vc = [[HLitDetailViewController alloc] init];
        vc.comId = list.ComId;
        vc.title = list.ComName;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 分区头设置
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }else{
        return 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *array = @[@"基本资料",@"Ta加入的社团"];
    UIView *backView = [[UIView alloc] init];
    
    UILabel *titleLab = [[UILabel alloc] init];
    if (section == 0) {
        backView.frame = CGRectMake(0, 0, BXScreenW, 40);
        titleLab.frame = CGRectMake(15, 15, BXScreenW - 30, 15);
    }else{
        backView.frame = CGRectMake(0, 0, BXScreenW, 50);
        titleLab.frame = CGRectMake(15, 25, BXScreenW - 30, 15);
    }
    titleLab.text = array[section];
    titleLab.font = FIFFont;
    titleLab.textColor = BXColor(236,105,65);
    [backView addSubview:titleLab];
    
    return backView;
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

#pragma mark - 个人资料的获取
-(void) getAutherPersonData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper autherPersonWithAnthorId:self.autherId success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            self.dataArray = [[NSMutableArray alloc] init];
            self.listArray = [[NSMutableArray alloc] init];
            
            WriterPerModel *model = [WriterPerModel mj_objectWithKeyValues:response];
            
            [self.listArray addObject:model];
            
            [self.dataArray addObject:model.NickName];
            [self.dataArray addObject:model.SexName];
            [self.dataArray addObject:model.Birthday];
            [self.dataArray addObject:model.Signature];
            [self.dataArray addObject:model.Certification];
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self.tableView reloadData];
            
    
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        
        [self.view showFailedViewReloadBlock:^{
            [self getAutherPersonData];
        }];
    }];
}

@end
