//
//  HSecMoreViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/2.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HSecMoreViewController.h"
#import "HSecMoreCollectionViewCell.h"
#import "NCHomePageHelper.h"
#import "BookListModel.h"
#import "BookKeysModel.h"


@interface HSecMoreViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *colletionView;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pagenum;
@property (nonatomic, strong) EmptyDataView *emptyView;

@end

@implementation HSecMoreViewController

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
    
    // 添加导航栏设置
    [self setUpNavButtonUI];
    // 添加collectionView
    [self setUpCollectionViewUI];
    
    self.pagenum = 1;
    
    [self getData];
    
    self.colletionView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //    self.colletionView.mj_footer = [MJDIYHeader]
    self.colletionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getData];
   
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getData];

}

#pragma mark - 创建CollectionView视图
- (void) setUpCollectionViewUI {
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=15; //设置每一行的间距
    
    self.colletionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.colletionView.delegate=self;
    self.colletionView.dataSource=self;
    self.colletionView.showsVerticalScrollIndicator = NO;
    self.colletionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.colletionView];
    
    self.colletionView.frame=CGRectMake(0, 0, BXScreenW, BXScreenH-kTopHeight);
    
    //注册cell单元格
    [self.colletionView registerClass:[HSecMoreCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //注册头视图
    [self.colletionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell"];
}

#pragma mark - collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    BookListModel *model = self.dataArray[section];
    return model.FictionList.count;
}

#pragma mark - collectionViewCell 设置
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HSecMoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    BookListModel *listmodel = self.dataArray[indexPath.section];
    BookKeysModel *model = listmodel.FictionList[indexPath.item];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.FictionImage] placeholderImage:[UIImage imageNamed:@"默认书"]];
    cell.nameLab.text = model.FictionName;
    
    return cell;
    
}

#pragma mark - collectionViewCell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BookListModel *listmodel = self.dataArray[indexPath.section];
    BookKeysModel *model = listmodel.FictionList[indexPath.item];
    NovelDetailViewController *vc = [[NovelDetailViewController alloc] init];
    vc.bookId = model.FictionId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 返回头视图设置
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        BookListModel *model = self.dataArray[indexPath.item];
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
        UILabel *headLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 30)];
        headLab.backgroundColor = BXColor(242,242,242);
        headLab.font = FIFFont;
        headLab.text = model.DataTime;
        headLab.textColor = BXColor(152,152,152);
        headLab.textAlignment = NSTextAlignmentCenter;
        [header addSubview:headLab];
        return header;
    }
    
    return nil;
}

#pragma mark ---- UICollectionViewDelegateFlowLayout
//设置每个 UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((BXScreenW - 60)/3, 160);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 15, 10, 15);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){BXScreenW,35};
}

#pragma mark - 获取网络数据
-(void) getData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper fictionListWithGener:self.classId PageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] Success:^(NSArray *response) {
        st_dispatch_async_main(^{
            if (self.pagenum == 1) {
                self.dataArray = [[NSMutableArray alloc] init];
            }
            for (int i=0; i<response.count; i++) {
                BookListModel *model = [BookListModel mj_objectWithKeyValues:response[i]];
                
                [self.dataArray addObject:model];
                
            }
            if(self.dataArray.count == 0 && self.pagenum == 1){
                [self.emptyView removeFromSuperview];
                self.emptyView = [[EmptyDataView alloc]initWithFrame:self.view.bounds title:@"没有数据" actionTitle:nil];
                [self.colletionView addSubview:self.emptyView];
                
            }else{
                [self.emptyView removeFromSuperview];
            }
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self.colletionView reloadData];
            [self.colletionView.mj_header endRefreshing];
            [self.colletionView.mj_footer endRefreshing];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.colletionView.mj_header endRefreshing];
        [self.colletionView.mj_footer endRefreshing];
        [self.view showFailedViewReloadBlock:^{
//            [self.view showActivityWithImage:kLoadingImage];
            [self getData];
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
