//
//  CardShopViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/10/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CardShopViewController.h"
#import "CardShopTableViewCell.h"
#import "CardDetailViewController.h"
#import "BCWelcomHepler.h"
#import "GoodsModel.h"

@interface CardShopViewController ()<UITableViewDelegate, UITableViewDataSource, CardShopCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) BCWelcomHepler *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation CardShopViewController

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
    self.title = @"商城类";
    
    // 添加导航栏设置
    [self setUpNavButtonUI];
    // 添加collectionView
    [self setRootTableView];
    self.pageIndex = 1;
    
    
}

#pragma mark - 创建TableView
-(void) setRootTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - kTopHeight) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[CardShopTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 60)];
    imgView.image = [UIImage imageNamed:@"卡片类_图"];
    self.tableView.tableHeaderView = imgView;
    
}

#pragma mark - UITableViewViewDelegate
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
// 每个分区的cell数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    CardShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //    BookListModel *tuijianModel = self.fictionArray[indexPath.section];
    //
    
    cell.arr = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    cell.delegate = self;
    tableView.rowHeight = cell.height;
    
    return cell;
    
}

#pragma mark - 图片的点击事件
-(void)createUIButtonWithTitle:(NSString *)title Tag:(NSInteger)tag{
    NSLog(@"点击的图片是  %ld",(long)tag);
    CardDetailViewController *vc = [[CardDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 数据的获取
-(void)getShopGoodsListData{
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper getShopProductListWithType:self.type PageIndex:[NSString stringWithFormat:@"%ld",self.pageIndex] success:^(NSArray *response) {
        st_dispatch_async_main(^{
            
            self.dataArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                GoodsModel *model = [GoodsModel mj_objectWithKeyValues:response[i]];
                
                [self.dataArray addObject:model];
                
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
