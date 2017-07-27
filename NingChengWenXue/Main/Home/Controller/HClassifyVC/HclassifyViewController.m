//
//  HclassifyViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/2.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HclassifyViewController.h"
#import "HClassifyTableViewCell.h"
#import "HClaDetailViewController.h"
#import "HClaMoreViewController.h"
#import "NCHomePageHelper.h"
#import "AllTypeModel.h"
#import "TypeListModel.h"

@interface HclassifyViewController ()<UITableViewDataSource, UITableViewDelegate, MyCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HclassifyViewController

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
    self.title = @"分类";
    
    // 添加导航栏设置
    [self setUpNavButtonUI];
    // 添加collectionView
    [self setUpCollectionViewUI];
    
    // 网络数据的获取
    [self getGenerData];
    
}

#pragma mark - 创建CollectionView视图
- (void) setUpCollectionViewUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = BXColor(242,242,242);
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *footBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 44)];
    footBtn.backgroundColor = [UIColor whiteColor];
    [footBtn setTitle:@"更多分类" forState:UIControlStateNormal];
    footBtn.titleLabel.font = FIFFont;
    [footBtn setTitleColor:BXColor(40,40,40) forState:UIControlStateNormal];
    [footBtn addTarget:self action:@selector(clickTableFootButton) forControlEvents:UIControlEventTouchUpInside];
//    self.tableView.tableFooterView = footBtn;
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

#pragma mark - TableViewCell的设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HClassifyTableViewCell * cell = [HClassifyTableViewCell setMyTableViewCellWithTableView:tableView];
    AllTypeModel *modelList = self.dataArray[indexPath.section];
    cell.delegate  = self;
    cell.section = indexPath.section;
    cell.arr       = modelList.Item;
    tableView.rowHeight = cell.height;
    
    return cell;
}

#pragma mark - 分区头设置
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    AllTypeModel *model = self.dataArray[section];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 30)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = model.GenerName;
    title.font = FIFFont;
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = BXColor(195,195,195);
    CGRect titWidth = Adaptive_Width(title.text, title.font);
    title.frame = CGRectMake(BXScreenW/2.0-titWidth.size.width/2.0 - 29, 15, titWidth.size.width+58, 15);
    [backView addSubview:title];
    
    UILabel *leftLine = [[UILabel alloc] initWithFrame:CGRectMake(15, 22.5, BXScreenW/2.0 - 15 - CGRectGetWidth(title.frame)/2.0, 0.5)];
    leftLine.backgroundColor = BXColor(195,195,195);
    [backView addSubview:leftLine];
    
    UILabel *rightLine = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(title.frame), 22.5, BXScreenW/2.0 - 15 - CGRectGetWidth(title.frame)/2.0, 0.5)];
    rightLine.backgroundColor = BXColor(195,195,195);
    [backView addSubview:rightLine];
    
    return backView;
}

#pragma mark - tableViewCell上按钮点击事件回调
- (void)createUIButtonWithTitle:(NSString *)title Tag:(NSInteger)tag Section:(NSInteger)section{
    NSLog(@"%@",title);
    HClaDetailViewController *vc = [[HClaDetailViewController alloc] init];
    AllTypeModel *model = self.dataArray[section];
    TypeListModel *list = model.Item[tag - 1000];
    vc.secName = model.GenerName;
    vc.rowName = title;
    vc.Id = [NSString stringWithFormat:@"%ld",list.Id];
    vc.secArray = [self.dataArray copy];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - tableView 尾视图更多分类点击按钮
-(void) clickTableFootButton {
    NSLog(@"更多分类");
    HClaMoreViewController *vc = [[HClaMoreViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 数据的获取
-(void) getGenerData {
    
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper generWithsuccess:^(NSArray *response) {
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            
            for (int i=0; i<response.count; i++) {
                AllTypeModel *model = [AllTypeModel mj_objectWithKeyValues:response[i]];
                
                [self.dataArray addObject:model];
                
            }
            if(self.dataArray.count == 0){
                [self.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
            }
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self.tableView reloadData];

        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.view showFailedViewReloadBlock:^{
//            [self.view showActivityWithImage:kLoadingImage];
            [self getGenerData];
        }];
    }];
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

@end

