//
//  HAutMedalViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAutMedalViewController.h"
#import "HAutMedalCollectionViewCell.h"

@interface HAutMedalViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *colletionView;

@end

@implementation HAutMedalViewController

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
    self.title = @"勋章";
    [self setUpNavButtonUI];
    
    [self setUpFollowButton];
    
    [self setUpCollectionViewUI];
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
    [self.colletionView registerClass:[HAutMedalCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

#pragma mark - collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

#pragma mark - collectionViewCell 设置
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HAutMedalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    
    
    return cell;
    
}

#pragma mark ---- UICollectionViewDelegateFlowLayout
//设置每个 UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((BXScreenW - 60)/3, (BXScreenW - 60)/3+18);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}



#pragma mark - 创建底部的两个按钮
-(void) setUpFollowButton {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, BXScreenH - 49 - 64, BXScreenW, 49)];
    footView.backgroundColor = [UIColor whiteColor];
    footView.layer.borderWidth = 0.5;
    footView.layer.borderColor = BXColor(152, 152, 152).CGColor;
    [self.view addSubview:footView];
    
    UIButton *readBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW/3.0, 0, BXScreenW/3.0, 49)];
    [readBtn setTitle:@"商城" forState:UIControlStateNormal];
    readBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    readBtn.backgroundColor = BXColor(236, 105, 65);
    [footView addSubview:readBtn];
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
    [rightBtn setTitle:@"勋章规则" forState:UIControlStateNormal];
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
    NSLog(@"勋章规则");
    
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
