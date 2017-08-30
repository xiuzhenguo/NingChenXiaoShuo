//
//  TABookViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/11.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "TABookViewController.h"
#import "TANoBookTableViewCell.h"
#import "TABookTableViewCell.h"
#import "WriteBookViewController.h"
#import "NCWriteHelper.h"
#import "ZWDetailModel.h"

@interface TABookViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *footView;
@property (strong, nonatomic) NCWriteHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *fictionID;

@end

@implementation TABookViewController

-(NCWriteHelper *)helper{
    if (!_helper) {
        _helper = [NCWriteHelper helper];
    }
    return _helper;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;//不设置为黑色背景
    
    [self getCanTouGaoData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"征文详情";
    
    [self setUpNavButtonUI];
    
    [self setUpTableViewUI];
    
}

#pragma mark - 创建TableView
- (void) setUpTableViewUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 64) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[TABookTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[TANoBookTableViewCell class] forCellReuseIdentifier:@"cell1"];
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 110)];
    self.headView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headView;
    
    [self setUpTableHeadViewUI];
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 60)];
    self.footView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = self.footView;
    
    [self setUpTableFootViewUI];
}

#pragma mark - 创建TableView头视图
- (void) setUpTableHeadViewUI {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, 28, BXScreenW - 30, 44)];
    btn.backgroundColor = BXColor(236,105,65);
    [btn setTitle:@"创建新作品投稿" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn addTarget:self action:@selector(clickCreateButton) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 5;
    [self.headView addSubview:btn];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, BXScreenW, 10)];
    grayView.backgroundColor = BXColor(242, 242, 242);
    [self.headView addSubview:grayView];
}

#pragma mark - 创建新作品按钮的点击事件
-(void)clickCreateButton{
    WriteBookViewController *vc = [[WriteBookViewController alloc] init];
    vc.type = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count == 0) {
        return 1;
    }else{
        return self.dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count == 0) {
        return 112;
    }else{
        return 44;
    }
}

#pragma mark - tableViewCell设置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArray.count == 0) {
        TANoBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        
        TABookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ZWDetailModel *model = self.dataArray[indexPath.row];
        cell.nameLab.text = model.Name;
        
        cell.imgView.tag = 1000 + indexPath.row;
        [cell.imgView addTarget:self action:@selector(clickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}

#pragma mark - tableViewCell 中选中按钮的点击事件
-(void) clickSelectButton:(UIButton *)sender{
    for (int i = 0; i < self.dataArray.count; i++) {
        ZWDetailModel *model = self.dataArray[i];
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000+i];
        if (sender.tag - 1000 == i) {
            [btn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
            self.fictionID = model.FictionId;
            
        }else{
            [btn setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - tableViewCell的分区头设置

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 75;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 75)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *zuopinLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, BXScreenW - 30, 20)];
    zuopinLab.textAlignment = NSTextAlignmentCenter;
    zuopinLab.font = [UIFont systemFontOfSize:18];
    zuopinLab.textColor = BXColor(40, 40, 40);
    zuopinLab.text = @"可投递作品";
    [backView addSubview:zuopinLab];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, BXScreenW - 30, 15)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = THIRDFont;
    lable.textColor = BXColor(236,96,65);
    lable.text = @"仅限新作（征文发布后创建的作品为新作品）";
    [backView addSubview:lable];
    
    return backView;
}

#pragma mark - 当有投稿作品情况下tableView的分区尾设置
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.dataArray.count == 0) {
        return 0.01;
    }else{
        return 74;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.dataArray.count == 0) {
        return nil;
    }else{
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 74)];
        backView.backgroundColor = [UIColor whiteColor];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 0.5)];
        line.backgroundColor = BXColor(195,195,195);
        [backView addSubview:line];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, BXScreenW - 30, 44)];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = BXColor(236,105,65).CGColor;
        btn.layer.borderWidth = 0.5;
        [btn addTarget:self action:@selector(clickSectionSureButton) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
        
        return backView;
    }
}

#pragma mark - tableView分区尾确定按钮的点击事件
-(void) clickSectionSureButton {
    [self.helper DeliveryNovelWithSolicitationId:self.ficStr UserId:kUserID FictionId:self.fictionID success:^(NSDictionary *response) {
        
        st_dispatch_async_main(^{
            
            ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:response];
            if (model.StatusCode == 200) {
                
                [SVProgressHUD showSuccessWithStatus:@"投递成功"];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:model.Message];
            }
            
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}

#pragma mark - 创建TableView的尾视图
-(void) setUpTableFootViewUI {
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, BXScreenW - 30, 15)];
    titleLab.font = [UIFont boldSystemFontOfSize:13];
    titleLab.textColor = BXColor(40, 40, 40);
    titleLab.text = @"投稿须知：";
    [self.footView addSubview:titleLab];
    
    UILabel *conLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, BXScreenW - 30, 35)];
    conLab.font = THIRDFont;
    conLab.textColor = BXColor(152,152,152);
    conLab.numberOfLines = 0;
    conLab.text = @"作品投稿后，作品名称暂时不能修改，直至征文活动结束。";
    [conLab sizeToFit];
    [self.footView addSubview:conLab];
}

#pragma mark - 设置导航栏按钮
-(void) setUpNavButtonUI {
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 80, 30);
    [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = item;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 30);
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [rightBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark - 右侧分享按钮的点击事件
-(void) clickRightButton {
    NSLog(@"分享");
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 投稿作品的获取
-(void) getCanTouGaoData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper canTouNovelWithSolicitationId:self.ficStr UserId:kUserID success:^(NSArray *response) {
        st_dispatch_async_main(^{
            
            self.dataArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                ZWDetailModel *model = [ZWDetailModel mj_objectWithKeyValues:response[i]];
                
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
        [self.view showFailedViewReloadBlock:^{
            [self getCanTouGaoData];
        }];
    }];
}



@end
