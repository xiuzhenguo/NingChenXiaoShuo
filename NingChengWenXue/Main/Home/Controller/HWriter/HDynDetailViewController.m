//
//  HDynDetailViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/31.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HDynDetailViewController.h"
#import "HComDetailHeadView.h"
#import "HComDetailTableViewCell.h"
#import "ViewModel.h"
#import "HReportView.h"

@interface HDynDetailViewController ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong) HComDetailHeadView *headView;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) HReportView *reportView;


@end

@implementation HDynDetailViewController

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
    
    [self setUpNavButtonUI];
    
    [self setUpTableViewUI];
    // 添加底部发送按钮
    [self setUpFootButtonUI];
}

#pragma mark - 创建tableView视图
-(void) setUpTableViewUI {
    self.tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 44 - 64) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[HComDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    // 添加头视图
    [self setUpTableHeaderViewUI];
}

#pragma mark - tableView头视图创建
- (void) setUpTableHeaderViewUI {
    
//    self.headView = [[HComDetailHeadView alloc] init];
//    ViewModel *model = [[ViewModel alloc] init];
//    self.headView.viewModel = model;
//    self.headView.frame = CGRectMake(0, 0, BXScreenW, self.headView.height);
//    //    self.headView.backgroundColor = [UIColor orangeColor];
//    self.tableView.tableHeaderView = self.headView;
}

#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 13;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSLog(@"%f",(BXScreenW - 30 - 80)/9+60);
    return (BXScreenW - 30 - 80)/9+60;
}

#pragma mark - 设置分区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *secView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 100)];
    UILabel *zanNumLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 15)];
    zanNumLab.textColor = BXColor(152,152,152);
    zanNumLab.font = THIRDFont;
    zanNumLab.text = @"共334人赞过";
    [zanNumLab sizeToFit];
    [secView addSubview:zanNumLab];
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(zanNumLab.frame), 7, BXScreenW, 0.5)];
    lineLab.backgroundColor = BXColor(152,152,152);;
    [secView addSubview:lineLab];
    CGFloat width = (BXScreenW - 30 - 80)/9;
    UIButton *imgBtn = [[UIButton alloc] init];
    for (int i = 0; i<9; i++) {
        imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(15+(width+10)*i, CGRectGetMaxY(zanNumLab.frame)+15, width, width)];
        imgBtn.backgroundColor = [UIColor orangeColor];
        [imgBtn setImage:[UIImage imageNamed:@"huli"] forState:UIControlStateNormal];
        [secView addSubview:imgBtn];
    }
    
    UILabel *replyLab = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(imgBtn.frame)+15, 200, 15)];
    replyLab.textColor = BXColor(152,152,152);
    replyLab.font = THIRDFont;
    replyLab.text = @"共334人回复";
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
    
    //    ViewModel *model = [[ViewModel alloc] init];
    //    cell.viewModel = model;
    NSString *str = @"访问发改委凤凰网访问衣服顾问费微服务额发育为规范违法违规服务业符文页股份于为规范微风过温哥华V时代广场符文页规范物业罆";
    
    cell.color = BXColor(0, 0, 255);
    cell.str = str;
    
    tableView.rowHeight = cell.height;
    return cell;
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
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.textField resignFirstResponder];
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 离线作品按钮的点击事件的实现
-(void)rightNavBtnAction:(UIButton *)sender{
    NSLog(@"举报");
    self.reportView = [[HReportView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    
    
    [self.view.window addSubview:self.reportView];
    __weak typeof(self)weakSelf = self;
    [self.reportView setFinishButtonTitle:^(NSString *title){
        [weakSelf handleSingleTapGesture];
        NSLog(@"%@",title);
    }];
}

- (void)handleSingleTapGesture{
    [self.reportView removeFromSuperview];
}

@end
