//
//  HAutCardSynViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/29.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAutCardSynViewController.h"
#import "HAutCardSynTableViewCell.h"
#import "HAutCardSynView.h"

@interface HAutCardSynViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation HAutCardSynViewController

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
    
    [self setUpNavButtonUI];
    
    [self setUpUITableViewUI];
}

#pragma mark - 创建UITableView视图
-(void) setUpUITableViewUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH-64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[HAutCardSynTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UItableViewcell 的个数及cell的设置
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 157;
}

#pragma mark - tableViewCell设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HAutCardSynTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.imgView.image = [UIImage imageNamed:@"卡片"];
    cell.nameLab.text = @"狐仙姐妹女武神";
    if (indexPath.row == 0) {
        cell.btn.backgroundColor = BXColor(236,105,65);
    }else{
        cell.btn.backgroundColor = BXColor(152,152,152);
    }
    cell.btn.tag = 1000+indexPath.row;
    [cell.btn addTarget:self action:@selector(clickCellButton:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

#pragma mark - 卡片合成功能的实现
-(void) clickCellButton:(UIButton *)sender {
    if (sender.tag - 1000 == 0) {
        HAutCardSynView *cardsynView = [[HAutCardSynView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
        [self.view.window addSubview:cardsynView];
        
        cardsynView.imgView.image = [UIImage imageNamed:@"卡片"];
        cardsynView.nameLab.text = @"生肖守护神合成成功";
        CGRect with = Adaptive_Width(cardsynView.nameLab.text, cardsynView.nameLab.font);
        cardsynView.nameLab.frame = CGRectMake((BXScreenW - with.size.width)/2.0, CGRectGetMaxY(cardsynView.imgView.frame)+40, with.size.width, 20);
    }else{
        _hud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        _hud.mode = MBProgressHUDModeCustomView;
        _hud.label.text = @"生肖卡不足";
        _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"卡片不足"]];
        _hud.bezelView.backgroundColor = [UIColor blackColor];
        _hud.bezelView.alpha = 0.8;
        [_hud hideAnimated:YES afterDelay:1.0f];
        _hud.label.textColor = [UIColor whiteColor];
    }
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

@end
