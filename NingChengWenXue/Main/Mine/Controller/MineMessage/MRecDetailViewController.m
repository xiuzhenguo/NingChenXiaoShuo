//
//  MRecDetailViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/18.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "MRecDetailViewController.h"
#import "MSenddetailTableViewCell.h"
#import "BCWelcomHepler.h"
#import "BoxdetailModel.h"

@interface MRecDetailViewController ()<UITableViewDelegate, UITableViewDataSource,UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) BCWelcomHepler *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation MRecDetailViewController

-(BCWelcomHepler *)helper{
    if (!_helper) {
        _helper = [BCWelcomHepler helper];
    }
    return _helper;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"收件";
    self.arr = @[@"收件人",@"标  题",@"时  间",@"内  容"];
    
    [self setUpNavButtonUI];
    
    [self setUpTableViewUI];
    
    [self getSendMessageDetailData];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    
    [self getSendMessageDetailData];
    
}

#pragma mark - 创建TableView
- (void) setUpTableViewUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.backgroundColor = BXColor(242, 242, 242);
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[MSenddetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 270)];
    self.tableView.tableFooterView = self.footView;
    
    [self setUpUITableFooterViewUI];
}

#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


#pragma mark - tableViewCell设置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MSenddetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    cell.nameStr = _arr[indexPath.row];
    cell.viewModel  = self.dataArray[indexPath.row];
    tableView.rowHeight = cell.height;
    
    return cell;
}

#pragma mark - tableView尾视图设置
-(void)setUpUITableFooterViewUI {
    UILabel *replyLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 70, 20)];
    replyLab.textColor = BXColor(101,101,101);
    replyLab.font = FIFFont;
    replyLab.text = @"回  复";
    [self.footView addSubview:replyLab];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 45, BXScreenW - 30, 150)];
    self.textView.backgroundColor = BXColor(242, 242, 242);
    self.textView.font = FIFFont;
    self.textView.text = @"请输入";
    self.textView.delegate = self;
    self.textView.textColor = BXColor(152,152,152);
    self.textView.layer.cornerRadius = 5;
    [self.footView addSubview:self.textView];
    
    UIButton *replyBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 225, BXScreenW - 30, 44)];
    replyBtn.backgroundColor = BXColor(236,105,65);
    replyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    replyBtn.layer.cornerRadius = 5;
    [self.footView addSubview:replyBtn];
    [replyBtn setTitle:@"回复" forState:UIControlStateNormal];
    [replyBtn addTarget:self action:@selector(clickReplyButton) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 开始编辑的时候的点击事件
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([self.textView.text isEqualToString:@"请输入"]) {
        self.textView.text = @"";
    }
    
    return YES;
}

#pragma mark - 回复功能的实现
-(void)clickReplyButton{
    if (self.textView.text.length == 0 || [self.textView.text isEqualToString:@"请输入"]) {
        [SVProgressHUD showErrorWithStatus:@"请填写内容"];
        return;
    }
    [self.helper wirteMessageWithUserId:kUserID ReceiveId:self.sendId ReceiveName:self.dataArray.firstObject MsgGene:@"4" Title:self.dataArray[1] Content:self.textView.text success:^(NSDictionary *response) {
        
        st_dispatch_async_main(^{
            
            [SVProgressHUD showSuccessWithStatus:@"回复成功"];
            [self.delegate receiveMessageDelegate:self.row];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        return ;
        
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
    }];
}


#pragma mark - 详情页数据的获取
-(void)getSendMessageDetailData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper receivedMessageBoxDetailWithUserId:kUserID MsgId:self.msgId MsgGener:self.type SendId:self.sendId success:^(NSDictionary *response) {
        
        st_dispatch_async_main(^{
            
            self.dataArray = [[NSMutableArray alloc] init];
            
            BoxdetailModel *model = [BoxdetailModel mj_objectWithKeyValues:response];
            
            [self.dataArray addObject:model.SendName];
            [self.dataArray addObject:model.Title];
            [self.dataArray addObject:model.Time];
            [self.dataArray addObject:model.Content];
            
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
            
            [self getSendMessageDetailData];
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
    
    [self.delegate receiveMessageDelegate:self.row];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
