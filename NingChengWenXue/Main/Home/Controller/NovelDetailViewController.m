//
//  NovelDetailViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/20.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NovelDetailViewController.h"
#import "HeaderView.h"
#import "NovelIntTableViewCell.h"
#import "ViewModel.h"
#import "CatalogueTableViewCell.h"
#import "HCommTableViewCell.h"
#import "HAuthorsViewController.h"
#import "HReadPageViewController.h"
#import "HCatalogueViewController.h"
#import "HALLComViewController.h"
#import "NCHomePageHelper.h"
#import "NovelDatailModel.h"
#import "BookKeysModel.h"
#import "MuLuListModel.h"

@interface NovelDetailViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;
/**头视图**/
@property (nonatomic, strong) UIView *tableHeadView;
/**尾视图**/
@property (nonatomic, strong) UIView *tableFootView;
@property (nonatomic, strong) HeaderView *headView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIButton *btn;
/**网络数据**/
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation NovelDetailViewController

-(NCHomePageHelper *)helper{
    if (!_helper) {
        _helper = [NCHomePageHelper helper];
    }
    return _helper;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = true;//不设置为黑色背景
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
     [self getNovelDetailData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
   
    self.navigationController.navigationBar.translucent = true;//不设置为黑色背景
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    // 设置返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 100, 30);
    [leftBtn setImage:[UIImage imageNamed:@"返回-1"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = item;
    
    // 创建TableView
    [self setRootScrollViewUI];
//    // 添加底部的三个按钮
//    [self setUpFootButtonUI];
    
   
}


#pragma mark - 创建tableViewUI
-(void) setRootScrollViewUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 49)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[NovelIntTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerClass:[CatalogueTableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.tableView registerClass:[HCommTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 400)];
    self.tableView.tableHeaderView = self.tableHeadView;
    
//    [self setImageViewUI];
    // 设置tableView尾视图
//    [self setUpTableViewFootViewUI];
    
}

#pragma mark - 添加小说封面
-(void) setImageViewUI {
    
    NovelDatailModel *model = self.dataArray.firstObject;
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 250)];
    self.imgView.backgroundColor = [UIColor whiteColor];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.FictionImage] placeholderImage:[UIImage imageNamed:@"书"]];
    [self.tableHeadView addSubview:self.imgView];
    
    _headView = [[HeaderView alloc] init];
    _headView.backgroundColor = [UIColor whiteColor];
    _headView.model = model;
    [self.tableHeadView addSubview:_headView];
    _headView.frame = CGRectMake(0, 250, BXScreenW, self.headView.height);
    
    [_headView.moreBtn addTarget:self action:@selector(clickHeadViewMoreBtn) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 点击作者信息跳转作者详情页
-(void) clickHeadViewMoreBtn {
    NovelDatailModel *model = self.dataArray.firstObject;
    HAuthorsViewController *vc = [[HAuthorsViewController alloc] init];
    vc.autherID = model.AuthorId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewViewDelegate
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
// 每个分区的cell数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
#pragma mark - 设置tableViewCell
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 测试
    NovelDatailModel *model = self.dataArray.firstObject;
    if (indexPath.row == 0) {
        NovelIntTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.viewModel = model;
        tableView.rowHeight = cell.height;
       
        return cell;
    }else if (indexPath.row == 1) {
        CatalogueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.catNumLab.text = [NSString stringWithFormat:@"连载至%ld章",model.SectionIndex];
        tableView.rowHeight = 44;
        return cell;
    }else{
        HCommTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.comNumLab.text = [NSString stringWithFormat:@"(%ld)",model.EvalauteIndex];
//        cell.comNumLab.text = @"(120)";
        tableView.rowHeight = 54;
        return cell;
    }
}

#pragma mark - tableViewCell的点击方法的实现
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        HCatalogueViewController *vc = [[HCatalogueViewController alloc] init];
        vc.bookID = self.bookId;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2) {
        HALLComViewController *vc = [[HALLComViewController alloc] init];
        vc.novelID = self.bookId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 设置tableView的尾视图
- (void) setUpTableViewFootViewUI {
    UILabel *likeLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, BXScreenW - 30, 15)];
    likeLab.text = @"你也许会喜欢";
    likeLab.font = [UIFont boldSystemFontOfSize:15];
    likeLab.textColor = BXColor(35, 35, 35);
    
    UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 44.5, BXScreenW - 15, 0.5)];
    lineLab.backgroundColor = BXColor(195, 195, 195);
    
    UIScrollView * scv = [[UIScrollView alloc]init];
    scv.showsHorizontalScrollIndicator = NO;
    scv.showsVerticalScrollIndicator = NO;
    
    NovelDatailModel *modellist = self.dataArray.firstObject;
    
    for (int i=0; i<modellist.FictionList.count; i++) {
        BookKeysModel *model =  modellist.FictionList[i];
        UIButton * bookBtn = [[UIButton alloc]init];
        bookBtn.frame = CGRectMake(15+i*120, 60, 105, 60);
        scv.contentSize = CGSizeMake(modellist.FictionList.count*120, 105);
        bookBtn.tag = i+10;
        //        [bookBtn setBackgroundImage:[UIImage imageNamed:@"上首页_6"] forState:UIControlStateNormal];
        [bookBtn addTarget:self action:@selector(btnCli:) forControlEvents:1<<6];
        [scv addSubview: bookBtn];
        
        UILabel * classLab = [[UILabel alloc]initWithFrame:CGRectMake(15+i*120, 125, 105, 15)];
        classLab.font = [UIFont boldSystemFontOfSize:13];
        classLab.textColor = BXColor(35, 35, 35);
        [scv addSubview: classLab];
        
        UILabel *authorLab = [[UILabel alloc] initWithFrame:CGRectMake(15+i*120, CGRectGetMaxY(classLab.frame)+5, 105, 15)];
        authorLab.textColor = BXColor(101,101,101);
        authorLab.font = ELEFont;
        authorLab.text = [NSString stringWithFormat:@"著: %@",model.AuthorName];
//        authorLab.text = @"著: 作者";
        [scv addSubview:authorLab];
        
//        [bookBtn setBackgroundImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        [bookBtn sd_setImageWithURL:[NSURL URLWithString:model.FictionImage] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"书"]];
        
        classLab.text = model.FictionName;
        scv.frame = CGRectMake(0, 0, BXScreenW, CGRectGetMaxY(authorLab.frame) + 15);
    }
    
    UIView *view = [[UIView alloc] init];
    if (modellist.FictionList.count != 0) {
        view.frame = CGRectMake(0, CGRectGetMaxY(scv.frame), BXScreenW, 20);
        view.backgroundColor = BXColor(195, 195, 195);
    }else{
        view.frame = CGRectMake(0, CGRectGetMaxY(likeLab.frame), BXScreenW, 20);
        view.backgroundColor = [UIColor whiteColor];
    }
    
    self.tableFootView = [[UIView alloc] init];
    self.tableFootView.frame = CGRectMake(0, 0, BXScreenW, CGRectGetMaxY(view.frame));
    self.tableFootView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = self.tableFootView;
    
    [self.tableFootView addSubview:likeLab];
    [self.tableFootView addSubview:lineLab];
    [self.tableFootView addSubview: scv];
    [self.tableFootView addSubview:view];
}

#pragma mark - 尾视图的点击方法
-(void)btnCli:(UIButton*)sender{
   
    NovelDatailModel *list = self.dataArray.firstObject;
    BookKeysModel *model = list.FictionList[sender.tag - 10];
    NovelDetailViewController *vc = [[NovelDetailViewController alloc] init];
    vc.bookId = model.FictionId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 设置底部的三个按钮
- (void) setUpFootButtonUI {
    NovelDatailModel *model = self.dataArray.firstObject;
    NSString *str = [NSString stringWithFormat:@"%ld",model.PraiseCount];
    NSArray *imgArray = @[@"形状-10",@"赞"];
    NSArray *titleArray = @[@"狐仙卡",str];
    for (int i = 0; i < 2; i++) {
        // 创建自定义按钮
        UIButton *btn_click = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 创建普通状态按钮图片
        [btn_click setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        // 设置按钮普通状态标题
        [btn_click setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn_click setTitleColor:BXColor(101, 101, 101) forState:UIControlStateNormal];
        // 按钮坐标和尺寸
        btn_click.frame = CGRectMake(0 + (BXScreenW/3.0)*2*i, BXScreenH - 49, BXScreenW/3.0, 49);
        btn_click.titleLabel.font = THIRDFont;
        // 按钮图片和标题总高度
        CGFloat totalHeight = (btn_click.imageView.frame.size.height + btn_click.titleLabel.frame.size.height);
        // 设置按钮图片偏移
        [btn_click setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - btn_click.imageView.frame.size.height), 0.0, 0.0, -btn_click.titleLabel.frame.size.width)];
        // 设置按钮标题偏移
        [btn_click setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -btn_click.imageView.frame.size.width, -(totalHeight - btn_click.titleLabel.frame.size.height),0.0)];
        btn_click.tag = 1000 + i;
        [btn_click addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        // 加载按钮到视图
        [self.view addSubview:btn_click];
        if (i == 1) {
            self.btn = btn_click;
            if (model.IsPraise == 1) {
                [btn_click setImage:[UIImage imageNamed:@"赞1"] forState:UIControlStateNormal];
            }
        }
    }
    
    UIButton *readBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW/3.0, BXScreenH - 49, BXScreenW/3.0, 49)];
    [readBtn setTitle:@"立即阅读" forState:UIControlStateNormal];
    readBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    readBtn.backgroundColor = BXColor(236, 105, 65);
    [self.view addSubview:readBtn];
    [readBtn addTarget:self action:@selector(clickReadButton) forControlEvents:UIControlEventTouchUpInside];
}

-(void) clickButton:(UIButton *)sender {
    if (sender.tag == 1001) {
        if (kUserLogin == NO) {
            LoginViewController *vc = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        NovelDatailModel *model = self.dataArray.firstObject;
        [self.helper novelClickZanWithFictionId:model.FictionId UserId:kUserID success:^(NSDictionary *response) {
            st_dispatch_async_main(^{
                
                [SVProgressHUD showSuccessWithStatus:@"成功"];
                
                if (model.IsPraise == 0) {
                    
                    [sender setImage:[UIImage imageNamed:@"赞1"] forState:UIControlStateNormal];
                    [sender setTitle:[NSString stringWithFormat:@"%ld",[sender.titleLabel.text integerValue] + 1] forState:UIControlStateNormal];
                    model.IsPraise = 1;
                }else{
                    [sender setImage:[UIImage imageNamed:@"赞"] forState:UIControlStateNormal];
                    [sender setTitle:[NSString stringWithFormat:@"%ld",[sender.titleLabel.text integerValue] - 1] forState:UIControlStateNormal];
                    model.IsPraise = 0;
                }
            });
            
            return ;
        } faild:^(NSString *response, NSError *error) {
            [SVProgressHUD showSuccessWithStatus:@"失败"];
        }];
        
    }
}

#pragma mark -立即阅读按钮的点击事件
-(void) clickReadButton {
    
    NSString *userId = @"00000000-0000-0000-0000-000000000000";
    if (kUserLogin == YES) {
        userId = kUserID;
    }
    [self.helper clickReadNovelWithFictionId:self.bookId UserId:userId success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            self.dataArray = [[NSMutableArray alloc] init];
            
            MuLuListModel *model = [MuLuListModel mj_objectWithKeyValues:response];
            HReadPageViewController *vc = [[HReadPageViewController alloc] init];
            vc.bookId = model.FictionId;
            vc.secID = model.SectionId;
            vc.SectionName = model.Title;
            vc.SectionIndex = model.SectionIndex;
            [self.navigationController pushViewController:vc animated:YES];
                        
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        
    }];
}


#pragma mark - 小说详情数据的获取
-(void) getNovelDetailData {
    NSString *userId = @"00000000-0000-0000-0000-000000000000";
    if (kUserLogin == YES) {
        userId = kUserID;
    }
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper novelDetailFictionWithID:self.bookId UserId:userId success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            self.dataArray = [[NSMutableArray alloc] init];
            
            NovelDatailModel *model = [NovelDatailModel mj_objectWithKeyValues:response];
            
            [self.dataArray addObject:model];
            
            // 添加底部的三个按钮
            [self setUpFootButtonUI];
            [self setImageViewUI];
            [self setUpTableViewFootViewUI];
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self.tableView reloadData];
        
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.view showFailedViewReloadBlock:^{
//            [self.view showActivityWithImage:kLoadingImage];
            [self getNovelDetailData];
        }];
    }];
}

#pragma mark - 返回按钮点击事件
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
