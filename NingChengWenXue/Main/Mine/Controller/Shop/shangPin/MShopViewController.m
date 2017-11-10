//
//  MShopViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/10/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "MShopViewController.h"
#import "ShopTableViewCell.h"
#import "CardShopViewController.h"
#import "CardDetailViewController.h"
#import "BCWelcomHepler.h"
#import "GoodsModel.h"

@interface MShopViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, SDCycleScrollViewDelegate, ShopBtnClickDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableHeadView;
@property (nonatomic, strong) NSArray *classfyArray;
@property (nonatomic, strong) NSArray *imgArray;
@property (strong, nonatomic) BCWelcomHepler *helper;
@property (nonatomic, strong) NSMutableArray *cardArray;//卡片类
@property (nonatomic, strong) NSMutableArray *goodArray;//实物类
@property (nonatomic, strong) NSMutableArray *dataArray;//虚拟类

@end

@implementation MShopViewController

-(BCWelcomHepler *)helper{
    if (!_helper) {
        _helper = [BCWelcomHepler helper];
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
    self.title = @"商城";
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.classfyArray = @[@"卡片类",@"实物类",@"虚拟类"];
    self.imgArray = @[@"卡片类",@"实物类",@"虚拟类"];
    
    [self setRootTableView];
    
    [self setUpNavButtonUI];
    [self getLunBoPictureData];//轮播图获取
    [self getCardListData];//卡片数据的获取
    [self getGoodsListData];
    [self getXuniListData];
}

#pragma mark - 创建TableView
-(void) setRootTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - kTopHeight - 49) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[ShopTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    // 头视图
    self.tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 175)];
    self.tableHeadView.backgroundColor = BXColor(242,242,242);
    self.tableView.tableHeaderView = self.tableHeadView;
    
    
}

#pragma mark - UITableViewViewDelegate
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
// 每个分区的cell数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    BookListModel *tuijianModel = self.fictionArray[indexPath.section];
    if (indexPath.section == 0) {
        [cell countOfButton:self.cardArray.count namearray:self.cardArray];
    }else if (indexPath.section == 1){
        [cell countOfButton:self.goodArray.count namearray:self.goodArray];
    }else{
        [cell countOfButton:self.dataArray.count namearray:self.dataArray];
    }
    
    cell.delegate = self;
    tableView.rowHeight = 180;
    
    return cell;
   
}

#pragma mark - 商品的点击事件
- (void)BFCell:(ShopTableViewCell *)bfcell didClickBFBtnTag:(NSInteger)BFBtnTag currentBFBtn:(UIButton *)sender{
    ShopTableViewCell *cell = (ShopTableViewCell *)[[[sender superview]superview]superview];
    NSIndexPath *indexPathAll = [self.tableView indexPathForCell:cell];
    NSLog(@"当前点击的是%ld行id为%zd",indexPathAll.section,BFBtnTag-10000);
//    BookListModel *tuijianModel = self.fictionArray[indexPathAll.section];
//    BookKeysModel *model = tuijianModel.FictionList[BFBtnTag - 10000];
//    
    CardDetailViewController *vc = [[CardDetailViewController alloc] init];
//    vc.bookId = model.FictionId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 分区头、分区尾设置
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView  *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 50)];
    headView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
    headImg.backgroundColor = [UIColor whiteColor];
    headImg.image = [UIImage imageNamed:self.imgArray[section]];
    [headView addSubview:headImg];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 200, 50)];
    title.font = FIFFont;
    title.textColor = BXColor(40,40,40);
    title.text = self.classfyArray[section];
    [headView addSubview:title];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(200, 0, BXScreenW - 205, 50)];
    btn.titleLabel.font = THIRDFont;
    [headView addSubview:btn];
    [btn setTitleColor:BXColor(152, 152, 152) forState:UIControlStateNormal];
    [btn setTitle:@"更多>" forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [headView addSubview:btn];
    btn.tag = 1000 + section;
    [btn addTarget:self action:@selector(clickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
   
    return headView;
}

#pragma mark - 分区头更多按钮的点击事件
-(void)clickMoreButton:(UIButton *)sender{
    NSLog(@"点击的分区是 %ld",sender.tag);
    
    CardShopViewController *vc = [[CardShopViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableView头视图--轮播图设置
- (void) setUpTableHeaderScrollViewUI:(NSArray *)picArray {
    
    NSArray *groupImgs = [picArray copy];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 175) delegate:self placeholderImage:[UIImage imageNamed:@"商城幻灯片"]];
    cycleScrollView.imageURLStringsGroup = groupImgs;
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.tableHeadView addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // --- 轮播时间间隔，默认1.0秒，可自定义
    cycleScrollView.autoScrollTimeInterval = 2.0;
}

#pragma mark - SDCycleScrollViewDelegate(轮播图的点击方法)

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
}

#pragma mark - 轮播图获取
-(void)getLunBoPictureData{
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper getLunBoPictureWithSuccess:^(NSArray *response) {
        st_dispatch_async_main(^{
            
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                GoodsModel *model = [GoodsModel mj_objectWithKeyValues:response[i]];
                
                [arr addObject:model.ShopImage];
                
            }
            [self setUpTableHeaderScrollViewUI:arr];
            
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
            
            [self getLunBoPictureData];
        }];
    }];
}

#pragma mark - 卡片类数据的获取
-(void)getCardListData{
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper getShopProductListWithType:@"1" PageIndex:@"1" success:^(NSArray *response) {
        st_dispatch_async_main(^{
            
            self.cardArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                GoodsModel *model = [GoodsModel mj_objectWithKeyValues:response[i]];
                
                [self.cardArray addObject:model];
                
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

#pragma mark - 实物类数据的获取
-(void)getGoodsListData{
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper getShopProductListWithType:@"3" PageIndex:@"1" success:^(NSArray *response) {
        st_dispatch_async_main(^{
            
            self.goodArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                GoodsModel *model = [GoodsModel mj_objectWithKeyValues:response[i]];
                
                [self.goodArray addObject:model];
                
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

#pragma mark - 虚拟类数据的获取
-(void)getXuniListData{
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper getShopProductListWithType:@"4" PageIndex:@"1" success:^(NSArray *response) {
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
