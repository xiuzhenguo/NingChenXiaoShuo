//
//  PreviewSecViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/8/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "PreviewSecViewController.h"
#import "NCWriteHelper.h"

@interface PreviewSecViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NCWriteHelper *helper;

@end

@implementation PreviewSecViewController

- (NCWriteHelper *)helper{

    if (!_helper) {
        _helper = [NCWriteHelper helper];
    }
    return _helper;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.backgroundColor =[UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpUITabelViewUI];
}

#pragma mark - 创建TableView视图
-(void) setUpUITabelViewUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - tableViewCell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - tableViewCell设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - 获取章节内容
-(void)getNovelSectionDetailData{
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper PreviewNovelSectionWithSectionid:self.sectionID success:^(NSDictionary *response) {

        st_dispatch_async_main(^{
            
            
        });
        
        return ;
        
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.view showFailedViewReloadBlock:^{
            [self getNovelSectionDetailData];
        }];
    }];
}

@end
