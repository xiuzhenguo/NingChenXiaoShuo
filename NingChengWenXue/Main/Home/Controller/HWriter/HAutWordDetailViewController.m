//
//  HAutWordDetailViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/31.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAutWordDetailViewController.h"
#import "HAutWordDetailView.h"
#import "HComDetailTableViewCell.h"
#import "LeaveMessageModel.h"
#import "SPDetailModel.h"
#import "HReportView.h"
#import "NCHomePageHelper.h"

@interface HAutWordDetailViewController ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HAutWordDetailView *headView;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) HReportView *reportView;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *ReplyListArray;
@property (nonatomic, assign) NSInteger pagenum;
@property (nonatomic, strong) NSString *replyID;


@end

@implementation HAutWordDetailViewController

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
    self.title = @"留言";
    self.pagenum = 1;
    
    [self setUpNavButtonUI];
    
    [self setUpTableViewUI];
    // 添加底部发送按钮
    [self setUpFootButtonUI];
    
    [self getLeaveMessageDetailData];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getLeaveMessageDetailData];
    
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getLeaveMessageDetailData];
    
}

#pragma mark - 创建tableView视图
-(void) setUpTableViewUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 44 - 64) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[HComDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    // 添加头视图
//    [self setUpTableHeaderViewUI];
}

#pragma mark - tableView头视图创建
- (void) setUpTableHeaderViewUI {
    
    self.headView = [[HAutWordDetailView alloc] init];
    LeaveMessageModel *model = self.dataArray.firstObject;
    self.headView.viewModel = model;
    self.headView.frame = CGRectMake(0, 0, BXScreenW, self.headView.height);
    //    self.headView.backgroundColor = [UIColor orangeColor];
    self.tableView.tableHeaderView = self.headView;
}

#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ReplyListArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSLog(@"%f",(BXScreenW - 30 - 80)/9+60);
    return 15;
}

#pragma mark - 设置分区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 15)];
    
    UILabel *replyLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 15)];
    replyLab.textColor = BXColor(152,152,152);
    replyLab.font = THIRDFont;
    replyLab.text = [NSString stringWithFormat:@"共%ld人回复",self.ReplyListArray.count];
    [replyLab sizeToFit];
    [secView addSubview:replyLab];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(replyLab.frame), CGRectGetMinY(replyLab.frame)+7, BXScreenW, 0.5)];
    line.backgroundColor = BXColor(152,152,152);;
    [secView addSubview:line];
    
    self.tableView.sectionHeaderHeight = CGRectGetMaxY(replyLab.frame);
    return secView;
}

#pragma mark - tableViewCell设置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HComDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 测试时
    
    SPDetailModel *model = self.ReplyListArray[indexPath.row];
    cell.color = [UIColor orangeColor];
    
    cell.viewModel = model;
    
    tableView.rowHeight = cell.height;
    return cell;
}

#pragma mark - tableViewCell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SPDetailModel *model = self.ReplyListArray[indexPath.row];
    self.textField.placeholder = [NSString stringWithFormat:@"回复%@",model.AuthorName];
    self.replyID = model.UserId;
    // 弹出键盘
    [self.textField becomeFirstResponder];
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
    rightBtn.frame = CGRectMake(0, 0, 100, 30);
    [rightBtn setTitle:@"举报" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark - 创建底部评论按钮
-(void) setUpFootButtonUI {
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, BXScreenH - 44 - 64, BXScreenW, 44)];
    footView.backgroundColor = BXColor(101, 101, 101);
    [self.view addSubview:footView];
    
    UIButton *imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    [imgBtn setBackgroundImage:[UIImage imageNamed:@"表情"] forState:UIControlStateNormal];
    [footView addSubview:imgBtn];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 5, BXScreenW - 100, 34)];
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.placeholder = @"回复此留言···";
    self.textField.font = ELEFont;
    self.textField.textColor = BXColor(101,101,101);
    [footView addSubview:self.textField];
    
    
    self.sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 60, 0, 60, 44)];
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    self.sendBtn.titleLabel.font = THIRDFont;
    [self.sendBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    [footView addSubview:self.sendBtn];
    [self.sendBtn addTarget:self action:@selector(clickSendButton) forControlEvents:UIControlEventTouchUpInside];
}

-(void) clickSendButton {
    if (self.textField.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"评论不能为空"];
        return;
    }else{
        [self.textField resignFirstResponder];
        if (kUserLogin == NO) {
            LoginViewController *vc = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        NSString *reply = @"";
        if ([self.textField.placeholder isEqualToString:@"回复此留言···"]) {
            reply = @"00000000-0000-0000-0000-000000000000";
        }else{
            reply = self.replyID;
        }
        [self.helper replyLeaveMessageWithUserId:kUserID ReplyId:reply LeaveId:self.leaveId Content:self.textField.text success:^(NSDictionary *response) {
            st_dispatch_async_main(^{
                
                [SVProgressHUD showSuccessWithStatus:@"成功"];
                
//                NSDictionary *dic = [[NSDictionary alloc] init];
//                if ([reply isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
//                    dic = @{@"Id":@"",@"AuthorName":@"修车",@"Content":self.textField.text,@"ReplyId":@"00000000-0000-0000-0000-000000000000",@"UserId":kUserID,@"ReplyName":@""};
//                }else{
//                    dic = @{@"Id":@"",@"AuthorName":@"修车",@"Content":self.textField.text,@"ReplyId":self.replyID,@"UserId":kUserID,@"ReplyName":[self.textField.placeholder substringFromIndex:2]};
//                }
//                [_headView.comBtn setTitle:[NSString stringWithFormat:@"%ld",[_headView.comBtn.titleLabel.text integerValue] + 1] forState:UIControlStateNormal];
//                SPDetailModel *model = [SPDetailModel mj_objectWithKeyValues:dic];
//                [self.ReplyListArray addObject:model];
                self.textField.text = @"";
//                [self.tableView reloadData];
                [self getLeaveMessageDetailData];
            });
            
            return ;
            
        } faild:^(NSString *response, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.textField resignFirstResponder];
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    [self.delegate passLeaveMessageValues:self.row pinglun:[self.headView.comBtn.titleLabel.text integerValue]];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 举报按钮的点击事件的实现
-(void)rightNavBtnAction:(UIButton *)sender{
   
    self.reportView = [[HReportView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    
    
    [self.view.window addSubview:self.reportView];
    __weak typeof(self)weakSelf = self;
    [self.reportView setFinishButtonTitle:^(NSString *title){
        [weakSelf handleSingleTapGesture];
        NSLog(@"%@",title);
        [weakSelf ReportCommentary:title];
    }];
}

- (void)handleSingleTapGesture{
    [self.reportView removeFromSuperview];
}

#pragma mark - 留言详情的获取
-(void) getLeaveMessageDetailData {
    [self.helper leaveMessageDetailWithLeaveId:self.leaveId PageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            if (self.pagenum == 1) {
                self.ReplyListArray = [[NSMutableArray alloc] init];
            }
            LeaveMessageModel *model = [LeaveMessageModel mj_objectWithKeyValues:response];
            
            [self.dataArray addObject:model];
            for (int i = 0; i < model.ReplyList.count; i++) {
                SPDetailModel *mode = [SPDetailModel mj_objectWithKeyValues:model.ReplyList[i]];
                [self.ReplyListArray addObject:mode];
            }
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self setUpTableHeaderViewUI];
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
            [self getLeaveMessageDetailData];
        }];
    }];
}

#pragma mark - 举报
-(void)ReportCommentary:(NSString *)title {
    if (kUserLogin == NO) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    LeaveMessageModel *model = self.dataArray.firstObject;
    [self.helper juBaoWithObjType:@"3" ObjId:self.leaveId ObjClass:title UserId:model.LeaveUserId OptionId:kUserID success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:response];
            [SVProgressHUD showSuccessWithStatus:model.Message];
            
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"失败"];
    }];
}

@end


