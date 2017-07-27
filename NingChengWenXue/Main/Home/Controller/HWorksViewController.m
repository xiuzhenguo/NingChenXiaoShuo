//
//  HWorksViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/22.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HWorksViewController.h"
#import "HAWorksTableViewCell.h"
#import "NovelDetailViewController.h"
#import "NCHomePageHelper.h"
#import "WriterNovelModel.h"

@interface HWorksViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) EmptyDataView *emptyView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pagenum;

@end

@implementation HWorksViewController

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
    self.pagenum = 1;
    
    [self addTableView];
    
    [self getAutherNovelListData];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getAutherNovelListData];
    
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getAutherNovelListData];
    
}


#pragma mark - 创建tableView
-(void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_frame.size.width, Screen_frame.size.height - 49 - 200 - 44 - 50) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[HAWorksTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark - tableViewCell设置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HAWorksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    WriterNovelModel *model = self.dataArray[indexPath.row];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.FictiomImage] placeholderImage:[UIImage imageNamed:@"书"]];
    cell.nameLab.text = model.FictionName;
    cell.timeLab.text = model.UpdateTime;
    cell.numLab.text = [NSString stringWithFormat:@"%ld阅读/%ld评论/%ld收藏",model.ReadCount,model.PostCount,model.CollectCount];
    
    return cell;
}

#pragma mark - tableView点击事件跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WriterNovelModel *model = self.dataArray[indexPath.row];
    NovelDetailViewController *vc = [[NovelDetailViewController alloc] init];
    vc.bookId = model.FictionId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 作者作品集合
-(void) getAutherNovelListData {
    
    [self.helper autherNovelListWithID:self.aurhorID PageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] success:^(NSArray *response) {
        st_dispatch_async_main(^{
            if (self.pagenum == 1) {
                self.dataArray = [[NSMutableArray alloc] init];
            }
            for (int i=0; i<response.count; i++) {
                WriterNovelModel *model = [WriterNovelModel mj_objectWithKeyValues:response[i]];
                
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
        [self.tableView.mj_footer endRefreshing];
        [self.view showFailedViewReloadBlock:^{
            [self getAutherNovelListData];
        }];
    }];
}

@end
