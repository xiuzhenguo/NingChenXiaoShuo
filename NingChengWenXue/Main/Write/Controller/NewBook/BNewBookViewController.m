//
//  BNewBookViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/26.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "BNewBookViewController.h"
#import "BNewBookTableViewCell.h"
#import "ViewModel.h"
#import "NBEditViewController.h"
#import "WriteBookViewController.h"
#import "NCWriteHelper.h"
#import "NewBookModel.h"
#import "NewBookListModel.h"

@interface BNewBookViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *createBtn;
@property (strong, nonatomic) NCWriteHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) EmptyDataView *emptyView;

@end

@implementation BNewBookViewController

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
    
    [self getProductionListData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpTableViewUI];
    
    [self setUpCreateButton];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    [self getProductionListData];
    
}

#pragma mark - 添加我的社团按钮
-(void) setUpCreateButton {
    self.createBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 50, BXScreenH - 64 - 80 - 175, 40, 40)];
    self.createBtn.backgroundColor = BXColor(236,105,65);
    
    [self.createBtn setImage:[UIImage imageNamed:@"创作"] forState:UIControlStateNormal];
    [self.createBtn setTitle:@"创作" forState:UIControlStateNormal];
    self.createBtn.titleLabel.font = ELEFont;
    self.createBtn.layer.cornerRadius = 20;
    self.createBtn.clipsToBounds = YES;
    // 按钮图片和标题总高度
    CGFloat totalHeight = (self.createBtn.imageView.frame.size.height + self.createBtn.titleLabel.frame.size.height);
    // 设置按钮图片偏移
    [self.createBtn setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - self.createBtn.imageView.frame.size.height), 0.0, 0.0, -self.createBtn.titleLabel.frame.size.width)];
    // 设置按钮标题偏移
    [self.createBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -self.createBtn.imageView.frame.size.width, -(totalHeight - self.createBtn.titleLabel.frame.size.height),0.0)];
    [self.view addSubview:self.createBtn];
    
    UIButton *tapBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 80, BXScreenH - 64 - 80 - 175, 80, 80)];
    [tapBtn addTarget:self action:@selector(clickCreateButton) forControlEvents:UIControlEventTouchUpInside];
    tapBtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tapBtn];
}

#pragma mark - 创建TableView
- (void) setUpTableViewUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 64 - 20) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[BNewBookTableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NewBookModel *model = self.dataArray.firstObject;
    return model.Item.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 118;
}

#pragma mark - tableViewCell设置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BNewBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NewBookModel *list = self.dataArray.firstObject;
    NewBookListModel *model = list.Item[indexPath.row];
    cell.viewModel = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 31;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 31)];
    backView.backgroundColor = BXColor(242, 242, 242);
    NewBookModel *model = self.dataArray.firstObject;
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 31)];
    titleLab.text = [NSString stringWithFormat:@"%ld部连载中，%ld部完结",(long)model.NotComplete,model.Complete];
    titleLab.font = THIRDFont;
    titleLab.textColor = BXColor(101, 101, 101);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:titleLab];
    
    return backView;
}

#pragma mark - tableView点击事件跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NBEditViewController *vc = [[NBEditViewController alloc] init];
    NewBookModel *list = self.dataArray.firstObject;
    NewBookListModel *model = list.Item[indexPath.row];
    vc.bookID = model.FictionId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 创作按钮的点击事件
-(void) clickCreateButton {
    if (kUserLogin == NO) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    WriteBookViewController *vc = [[WriteBookViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void) getProductionListData {
    NSString *ID  = @"";
    if (kUserLogin == YES) {
        ID = kUserID;
    }else{
        ID = @"00000000-0000-0000-0000-000000000000";
    }
    [self.helper productionWithAuthorid:ID success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            
            NewBookModel *model = [NewBookModel mj_objectWithKeyValues:response];
            [self.dataArray addObject:model];
        
            if(model.Item.count == 0){
                [self.emptyView removeFromSuperview];
                self.emptyView = [[EmptyDataView alloc]initWithFrame:self.view.bounds title:@"没有数据" actionTitle:nil];
                [self.tableView addSubview:self.emptyView];
                
            }else{
                [self.emptyView removeFromSuperview];
            }
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.tableView.mj_header endRefreshing];
        [self.view showFailedViewReloadBlock:^{
            [self getProductionListData];
        }];
    }];
}

@end
