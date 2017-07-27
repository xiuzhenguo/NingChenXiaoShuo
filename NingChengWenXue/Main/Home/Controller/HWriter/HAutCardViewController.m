//
//  HAutCardViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAutCardViewController.h"
#import "HAutCardCollectionViewCell.h"
#import "HAutCardSynViewController.h"
#import "CardModel.h"
#import "NCHomePageHelper.h"

@interface HAutCardViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *colletionView;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) EmptyDataView *emptyView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pagenum;

@end

@implementation HAutCardViewController

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
    self.title = @"卡片";
    self.pagenum = 1;
    [self setUpNavButtonUI];
    
    [self setUpFollowButton];
    
    [self setUpCollectionViewUI];
    
    [self getUserCardListData];
    self.colletionView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.colletionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getUserCardListData];
    
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getUserCardListData];
    
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
    
    self.colletionView.frame=CGRectMake(0, 0, BXScreenW, BXScreenH-64-49);
    
    //注册cell单元格
    [self.colletionView registerClass:[HAutCardCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

#pragma mark - collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

#pragma mark - collectionViewCell 设置
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HAutCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    CardModel *model = self.dataArray[indexPath.item];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.CardImage] placeholderImage:[UIImage imageNamed:@"卡片"]];
    
    cell.nameLab.text = [NSString stringWithFormat:@"%@x%ld",model.CardName,model.CardCount];
    NSRange range = [cell.nameLab.text rangeOfString:[NSString stringWithFormat:@"x%ld",model.CardCount]];
    [self setTextColor:cell.nameLab FontNumber:THIRDFont AndRange:range AndColor:BXColor(236,105,65)];
    
    return cell;
    
}

#pragma mark - 设置不同字体颜色
-(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    label.attributedText = str;
}


#pragma mark ---- UICollectionViewDelegateFlowLayout
//设置每个 UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((BXScreenW - 60)/3, 150);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}



#pragma mark - 创建底部的两个按钮
-(void) setUpFollowButton {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, BXScreenH - 49 - 64, BXScreenW, 49)];
    footView.backgroundColor = [UIColor whiteColor];
    footView.layer.borderWidth = 1;
    footView.layer.borderColor = BXColor(152, 152, 152).CGColor;
    [self.view addSubview:footView];
    
    UIButton *readBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW/3.0, 0, BXScreenW/3.0, 49)];
    [readBtn setTitle:@"商城" forState:UIControlStateNormal];
    readBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    readBtn.backgroundColor = BXColor(236, 105, 65);
    [footView addSubview:readBtn];
    
    // 创建自定义按钮
    UIButton *btn_click = [UIButton buttonWithType:UIButtonTypeCustom];
    // 创建普通状态按钮图片
    [btn_click setImage:[UIImage imageNamed:@"卡片合成"] forState:UIControlStateNormal];
    // 设置按钮普通状态标题
    [btn_click setTitle:@"卡片合成" forState:UIControlStateNormal];
    [btn_click setTitleColor:BXColor(152, 152, 152) forState:UIControlStateNormal];
    // 按钮坐标和尺寸
    btn_click.frame = CGRectMake((BXScreenW/3.0)*2, 0, BXScreenW/3.0, 49);
    btn_click.titleLabel.font = THIRDFont;
    // 按钮图片和标题总高度
    CGFloat totalHeight = (btn_click.imageView.frame.size.height + btn_click.titleLabel.frame.size.height);
    // 设置按钮图片偏移
    [btn_click setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - btn_click.imageView.frame.size.height), 0.0, 0.0, -btn_click.titleLabel.frame.size.width)];
    // 设置按钮标题偏移
    [btn_click setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -btn_click.imageView.frame.size.width, -(totalHeight - btn_click.titleLabel.frame.size.height),0.0)];
    
    [btn_click addTarget:self action:@selector(clickCardButton) forControlEvents:UIControlEventTouchUpInside];
    // 加载按钮到视图
//    [footView addSubview:btn_click];
}

#pragma mark - 卡片合成按钮的点击事件
-(void) clickCardButton {
    HAutCardSynViewController *vc = [[HAutCardSynViewController alloc] init];
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
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 30);
    [rightBtn setTitle:@"卡片规则" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark - 导航栏右侧搜索按钮点击事件
-(void) rightNavBtnAction:(UIButton *)sender {
    NSLog(@"卡片规则");
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 获取用户卡片集合
-(void) getUserCardListData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper userCardsWithUserId:self.authorID PageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] success:^(NSArray *response) {
        st_dispatch_async_main(^{
            if (self.pagenum == 1) {
                self.dataArray = [[NSMutableArray alloc] init];
            }
            
            for (int i=0; i<response.count; i++) {
                CardModel *model = [CardModel mj_objectWithKeyValues:response[i]];
                
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
            [self getUserCardListData];
        }];
    }];
}

@end
