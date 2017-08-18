//
//  HComDetailViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HComDetailViewController.h"
#import "HComDetailHeadView.h"
#import "HComDetailTableViewCell.h"
#import "ViewModel.h"
#import "HReportView.h"
#import "NCHomePageHelper.h"
#import "ShuPingListModel.h"
#import "SPDetailModel.h"
#import "HAuthorsViewController.h"

@interface HComDetailViewController ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HComDetailHeadView *headView;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) HReportView *reportView;

@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) EmptyDataView *emptyView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *replyArray;
@property (nonatomic, assign) NSInteger pagenum;
@property (nonatomic, strong) NSString *replyID;


@end

@implementation HComDetailViewController

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
    self.title = @"评论";
    self.pagenum = 1;
    
    [self setUpNavButtonUI];
    
    [self setUpTableViewUI];
    // 添加底部发送按钮
    [self setUpFootButtonUI];
    
    [self getShuPingDetailData];
    
    [self getReplyShuPingListData];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getShuPingDetailData];
    [self getReplyShuPingListData];
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getReplyShuPingListData];
    
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
//    // 添加头视图
//    [self setUpTableHeaderViewUI];
}

#pragma mark - tableView头视图创建
- (void) setUpTableHeaderViewUI {
    
    self.headView = [[HComDetailHeadView alloc] init];
    ShuPingListModel *model = self.dataArray.firstObject;
    self.headView.viewModel = model;
    self.headView.frame = CGRectMake(0, 0, BXScreenW, self.headView.height);
    self.tableView.tableHeaderView = self.headView;
    [self.headView.zanBtn addTarget:self action:@selector(clickZanButton:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 点赞功能的实现
-(void)clickZanButton:(UIButton *)sender {
    if (kUserLogin == NO) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
//    ShuPingListModel *model = self.dataArray.firstObject;
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper clickShuPingWithPostId:self.secID UserId:kUserID success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [self.view hideHubWithActivity];
            [SVProgressHUD showSuccessWithStatus:@"成功"];
            if (sender.selected) {
                
                [sender setTitle:[NSString stringWithFormat:@"%ld",[sender.titleLabel.text integerValue] - 1] forState:UIControlStateNormal];
                [sender setImage:[UIImage imageNamed:@"赞"] forState:UIControlStateNormal];
                sender.selected = NO;
                
            }else{
               
                [sender setTitle:[NSString stringWithFormat:@"%ld",[sender.titleLabel.text integerValue] + 1] forState:UIControlStateNormal];
                [sender setImage:[UIImage imageNamed:@"点赞_click"] forState:UIControlStateNormal];
                sender.selected = YES;
                
            }
            [self getShuPingDetailData];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [SVProgressHUD showSuccessWithStatus:@"失败"];
    }];
}

#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.replyArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSLog(@"%f",(BXScreenW - 30 - 80)/9+60);
    if ([self.headView.zanBtn.titleLabel.text isEqualToString:@"0"]) {
        return 30;
    }else{
        return (BXScreenW - 30 - 80)/9+60;
    }
}

#pragma mark - 设置分区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ShuPingListModel *list = self.dataArray.firstObject;
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 100)];
    UILabel *zanNumLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 15)];
    zanNumLab.textColor = BXColor(152,152,152);
    zanNumLab.font = THIRDFont;
    zanNumLab.text = [NSString stringWithFormat:@"共%ld人赞过",list.ApplaudItem.count];
    [zanNumLab sizeToFit];
    [secView addSubview:zanNumLab];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(zanNumLab.frame), 7, BXScreenW, 0.5)];
    lineLab.backgroundColor = BXColor(152,152,152);;
    [secView addSubview:lineLab];
    CGFloat width = (BXScreenW - 30 - 70)/8;
    UIButton *imgBtn = [[UIButton alloc] init];
    for (int i = 0; i<list.ApplaudItem.count; i++) {
        SPDetailModel *model = list.ApplaudItem[i];
        imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(15+(width+10)*i, CGRectGetMaxY(zanNumLab.frame)+15, width, width)];
        [imgBtn sd_setImageWithURL:[NSURL URLWithString:model.UserHeadImage] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"huli"]];
        imgBtn.tag = 1000 + i;
        [imgBtn addTarget:self action:@selector(clickImageButton:) forControlEvents:UIControlEventTouchUpInside];
        [secView addSubview:imgBtn];
    }
    
    UILabel *replyLab = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(imgBtn.frame)+15, 200, 15)];
    replyLab.textColor = BXColor(152,152,152);
    replyLab.font = THIRDFont;
    replyLab.text = [NSString stringWithFormat:@"共%ld人回复",self.replyArray.count];
    [replyLab sizeToFit];
    [secView addSubview:replyLab];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(replyLab.frame), CGRectGetMinY(replyLab.frame)+7, BXScreenW, 0.5)];
    line.backgroundColor = BXColor(152,152,152);;
    [secView addSubview:line];
    
    secView.frame = CGRectMake(0, 0, BXScreenW, CGRectGetMaxY(replyLab.frame));
    
//    self.tableView.sectionHeaderHeight = CGRectGetMaxY(replyLab.frame);
    return secView;
}

#pragma mark - 点击点赞头像跳入作者页
-(void) clickImageButton:(UIButton *)sender {
    ShuPingListModel *list = self.dataArray.firstObject;
    SPDetailModel *model = list.ApplaudItem[sender.tag - 1000];
    HAuthorsViewController *vc = [[HAuthorsViewController alloc] init];
    vc.autherID = model.UserId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableViewCell设置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HComDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 测试时
    
    SPDetailModel *model = self.replyArray[indexPath.row];
    cell.color = [UIColor orangeColor];
   
    cell.viewModel = model;
//    NSString *str = @"幕嘟嘟回复虞姬：访问发改委凤凰网访问衣服顾问费微服务额发育为规范违法违规服务业符文页股份于为规范微风过温哥华V时代广场符文页规范物业罆";
//    cell.str = str;
    
    tableView.rowHeight = cell.height;
    return cell;
}

#pragma mark - tableViewCell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SPDetailModel *model = self.replyArray[indexPath.row];
    self.textField.placeholder = [NSString stringWithFormat:@"回复%@",model.AuthorName];
    self.replyID = model.UserId;
    // 弹出键盘
    [self.textField becomeFirstResponder];
    NSLog(@"22222");
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
    self.textField.placeholder = @"回复此评论···";
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
            return;
        }
        NSString *reply = @"";
        if ([self.textField.placeholder isEqualToString:@"回复此评论···"]) {
            reply = @"";
        }else{
            reply = self.replyID;
        }
        [self.helper replyShuPingWithUserId:kUserID ReplyId:reply PostId:self.secID Content:self.textField.text success:^(NSDictionary *response) {
            st_dispatch_async_main(^{
                
                [SVProgressHUD showSuccessWithStatus:@"成功"];
                
//                NSDictionary *dic = [[NSDictionary alloc] init];
//                if ([reply isEqualToString:@""]) {
//                    dic = @{@"Id":@"",@"AuthorName":@"修车",@"Content":self.textField.text,@"ReplyId":@"00000000-0000-0000-0000-000000000000",@"UserId":kUserID,@"ReplyName":@""};
//                }else{
//                    dic = @{@"Id":@"",@"AuthorName":@"修车",@"Content":self.textField.text,@"ReplyId":self.replyID,@"UserId":kUserID,@"ReplyName":[self.textField.placeholder substringFromIndex:2]};
//                }
//                
//                SPDetailModel *model = [SPDetailModel mj_objectWithKeyValues:dic];
//                [self.replyArray addObject:model];
                self.textField.text = @"";
                [self getShuPingDetailData];
                [self getReplyShuPingListData];
            });
            
            return ;
        } faild:^(NSString *response, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"评论失败"];
        }];
        
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.textField resignFirstResponder];
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    if (self.headView.zanBtn.selected) {
        self.type = 1;
    }else{
        self.type = 0;
    }
    [self.delegate passTrendValues:self.row zancount:[self.headView.zanBtn.titleLabel.text integerValue] pinglun:[self.headView.comBtn.titleLabel.text integerValue] type:self.type];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 举报按钮的点击事件的实现
-(void)rightNavBtnAction:(UIButton *)sender{
    self.reportView = [[HReportView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    
    [self.view.window addSubview:self.reportView];
    __weak typeof(self)weakSelf = self;
    [self.reportView setFinishButtonTitle:^(NSString *title){
        [weakSelf handleSingleTapGesture];
        [weakSelf ReportCommentary:title];
    }];
}

- (void)handleSingleTapGesture{
    [self.reportView removeFromSuperview];
}

#pragma mark - 书评信息的获取
-(void) getShuPingDetailData {
    NSString *userId = @"00000000-0000-0000-0000-000000000000";
    if (kUserLogin == YES) {
        userId = kUserID;
    }
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper shuPingDetailWithId:self.secID UserId:userId success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            self.dataArray = [[NSMutableArray alloc] init];
            
            ShuPingListModel *model = [ShuPingListModel mj_objectWithKeyValues:response];
            
            [self.dataArray addObject:model];
            
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
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 书评回复列表获取
-(void)getReplyShuPingListData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper replyShuPingListWithID:self.secID PageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] success:^(NSArray *response) {
        st_dispatch_async_main(^{
            if (self.pagenum == 1) {
                self.replyArray = [[NSMutableArray alloc] init];
            }
            for (int i=0; i<response.count; i++) {
                SPDetailModel *model = [SPDetailModel mj_objectWithKeyValues:response[i]];
                
                [self.replyArray addObject:model];
                
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
        [self.view showFailedViewReloadBlock:^{
            [self getShuPingDetailData];
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
    ShuPingListModel *model = self.dataArray.firstObject;
    [self.helper juBaoWithObjType:@"1" ObjId:self.secID ObjClass:title UserId:model.AuthorId OptionId:kUserID success:^(NSDictionary *response) {
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
