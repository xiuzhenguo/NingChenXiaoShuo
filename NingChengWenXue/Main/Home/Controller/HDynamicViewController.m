//
//  HDynamicViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/22.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HDynamicViewController.h"
#import "HADynamTableViewCell.h"
#import "HAFourImgTableViewCell.h"
#import "HDynDetailViewController.h"
#import "HDynListViewController.h"
#import "NCHomePageHelper.h"
#import "WriterDynModel.h"
#import "DynFictionModel.h"
#import "NovelDetailViewController.h"
#import "HReadPageViewController.h"

@interface HDynamicViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableFootView;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) EmptyDataView *emptyView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pagenum;

@end

@implementation HDynamicViewController

-(NCHomePageHelper *)helper{
    if (!_helper) {
        _helper = [NCHomePageHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    [self addTableView];
    
    [self getDongTaiListData];
}

#pragma mark - 创建tableView
-(void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 49 - 200 - 44 - 50) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[HADynamTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[HAFourImgTableViewCell class] forCellReuseIdentifier:@"cell1"];
    
    self.tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 80)];
    self.tableFootView.backgroundColor = BXColor(195, 195, 195);
    self.tableView.tableFooterView = self.tableFootView;
    
    
}

#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count == 0) {
        return 0;
    }else{
        return 1;
    }
}


#pragma mark - tableViewCell设置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WriterDynModel *model = self.dataArray.firstObject;
    if (model.ActionGener == 1 || model.ActionGener == 4) {
        
        HADynamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.viewModel = model;
        
        tableView.rowHeight = cell.height;
        return cell;
    }else{
        HAFourImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.num = 4;
        cell.viewModel = model;
        tableView.rowHeight = cell.height;
        return cell;
    }
}

#pragma mark - tableView点击事件跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WriterDynModel *model = self.dataArray.firstObject;
    if (model.ActionGener == 1 || model.ActionGener == 4){
        NovelDetailViewController *vc = [[NovelDetailViewController alloc] init];
        vc.bookId = model.FictionId;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        HReadPageViewController *vc = [[HReadPageViewController alloc] init];
        vc.bookId = model.FictionId;
        vc.secID = model.FictionSectionId;
        vc.pushType = 2;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 设置tableView尾视图
-(void) setUpTableFootViewUI {
    UIButton *footBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 44)];
    footBtn.backgroundColor = [UIColor whiteColor];
    [footBtn setTitle:@"全部动态 》" forState:UIControlStateNormal];
    footBtn.titleLabel.font = FIFFont;
    [footBtn setTitleColor:BXColor(101,101,101) forState:UIControlStateNormal];
    [self.tableFootView addSubview:footBtn];
    [footBtn addTarget:self action:@selector(clickFootButton) forControlEvents:UIControlEventTouchUpInside];
}

-(void) clickFootButton {
    HDynListViewController *vc = [[HDynListViewController alloc] init];
    vc.autherId = self.autherId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 动态数据的获取
-(void) getDongTaiListData {
    [self.helper autherDongTaiListWithID:self.autherId PageIndex:@"1" success:^(NSArray *response) {
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
           
            for (int i=0; i<response.count; i++) {
                WriterDynModel *model = [WriterDynModel mj_objectWithKeyValues:response[i]];
                
                [self.dataArray addObject:model];
                
            }
            if (self.dataArray.count != 0) {
                // 添加尾视图
                [self setUpTableFootViewUI];
            }
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self.tableView reloadData];
           
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.view showFailedViewReloadBlock:^{
            [self getDongTaiListData];
        }];
    }];
}


@end
