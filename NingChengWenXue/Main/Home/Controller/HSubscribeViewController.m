//
//  HSubscribeViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/22.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HSubscribeViewController.h"
#import "HSubTableViewCell.h"
#import "ViewModel.h"
#import "BookListModel.h"
#import "TuiJianModel.h"
#import "NCHomePageHelper.h"
#import "AllTypeModel.h"
#import "TypeListModel.h"

@interface HSubscribeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) NSArray *imgArray;
@property (nonatomic, strong) NSArray *btnArray;
@property (nonatomic, strong) NSMutableArray *btnSelected;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, strong) NCHomePageHelper *helper;

@end

@implementation HSubscribeViewController

-(NCHomePageHelper *)helper{
    if (!_helper) {
        _helper = [NCHomePageHelper helper];
    }
    return _helper;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"订阅";
    
    [self getTypeListData];
    
//    self.nameArray = @[@{@"FictionClassItem":@[@{@"FictionName":@"奇幻"},@{@"FictionName":@"悬疑"},@{@"FictionName":@"推理"},@{@"FictionName":@"武侠"},@{@"FictionName":@"仙侠"},@{@"FictionName":@"游戏"},@{@"FictionName":@"体育"},@{@"FictionName":@"科幻"},@{@"FictionName":@"历史"},@{@"FictionName":@"军事"}]},@{@"FictionClassItem":@[@{@"FictionName":@"校园"},@{@"FictionName":@"言情"},@{@"FictionName":@"都市"},@{@"FictionName":@"灵异"},@{@"FictionName":@"散文随笔"},@{@"FictionName":@"职场"},@{@"FictionName":@"剧本"},@{@"FictionName":@"诗歌"},@{@"FictionName":@"穿越"},@{@"FictionName":@"二次元"},@{@"FictionName":@"轻小说"}]}];
//    self.btnSelected = [[NSMutableArray alloc] init];
//    for (int i = 0; i < self.nameArray.count; i++) {
//        TuiJianModel *model = [TuiJianModel mj_objectWithKeyValues:self.nameArray[i]];
//        for (int j = 0; j < model.FictionClassItem.count; j++) {
//            BookListModel *mode = [BookListModel mj_objectWithKeyValues:model.FictionClassItem[j]];
//            [self.btnSelected addObject:mode];
//        }
//    }
    self.typeArray = @[@[@"都是异能 西方幻想",@"神秘/悬疑 灵异/惊悚",@"推理/案件",@"武侠",@"玄幻仙侠",@"情感/都市",@"情感/都市 商战/职业 官场 现代/近代",@"科幻/未来",@"宅文/二次元小说",@"军事/战争"],@[@"青春/校园/情感",@"耽美纯爱",@"古代言情 现代言情 女频幻想",@"变身/性逆转",@"散文/随笔",@"ACG同人 偶像同人",@"散文/随笔",@"古诗词/现代书",@"变身/性逆转",@"宅文/二次元小说",@"宅文/二次元小说"]];
    self.imgArray = @[@[@"奇幻",@"悬疑",@"推理",@"武侠",@"仙侠",@"游戏",@"体育",@"科幻",@"历史",@"军事"],@[@"校园",@"言情",@"都是",@"灵异",@"随笔",@"职场",@"剧本",@"诗词",@"穿越",@"二次元_1",@"轻小说_1"]];
    
    self.btnArray = @[@[@"奇幻_1",@"悬疑_1",@"推理_1",@"武侠_1",@"仙侠_1",@"游戏_1",@"体育_1",@"科幻_1",@"历史_1",@"军事_1"],@[@"校园_1",@"言情_1",@"都是_1",@"灵异_1",@"随笔_1",@"职场_1",@"剧本_1",@"诗歌_1",@"穿越_1",@"二次元_1",@"轻小说_1"]];
    
    
    [self setUpNavButtonUI];
    
    [self setUpTableViewUI];
    
    self.selectArray = [[NSMutableArray alloc] init];
}

#pragma mark - 创建CollectionView视图
- (void) setUpTableViewUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = BXColor(242,242,242);
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HSubTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UILabel *headerLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 45)];
    headerLab.backgroundColor = BXColor(242, 242, 242);
    headerLab.text = @"选择所有你喜欢的分类";
    headerLab.textAlignment = NSTextAlignmentCenter;
    headerLab.font = [UIFont systemFontOfSize:18];
    headerLab.textColor = BXColor(40,40,40);
    self.tableView.tableHeaderView = headerLab;
    
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.btnArray[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.btnArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

#pragma mark - 分区头设置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AllTypeModel *model = self.dataArray[section];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 30)];
    backView.backgroundColor = BXColor(242, 242, 242);
    
    UILabel *title = [[UILabel alloc] init];
    title.text = model.GenerName;
    title.font = FIFFont;
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = BXColor(195,195,195);
    CGRect titWidth = Adaptive_Width(title.text, title.font);
    title.frame = CGRectMake(BXScreenW/2.0-titWidth.size.width/2.0 - 29, 0, titWidth.size.width+58, 15);
    [backView addSubview:title];
    
    UILabel *leftLine = [[UILabel alloc] initWithFrame:CGRectMake(15, 7.5, BXScreenW/2.0 - 15 - CGRectGetWidth(title.frame)/2.0, 0.5)];
    leftLine.backgroundColor = BXColor(195,195,195);
    [backView addSubview:leftLine];
    
    UILabel *rightLine = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(title.frame), 7.5, BXScreenW/2.0 - 15 - CGRectGetWidth(title.frame)/2.0, 0.5)];
    rightLine.backgroundColor = BXColor(195,195,195);
    [backView addSubview:rightLine];
    
    return backView;
}

#pragma mark - TableViewCell的设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    HSubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AllTypeModel *modelList = self.dataArray[indexPath.section];
    TypeListModel *model = modelList.Item[indexPath.row];
    cell.nameLab.text = model.ClassName;
    cell.typeLab.text = model.ClassDesc;
    cell.imgBtn.selected = model.IsCheck;
    cell.imgView.image = [UIImage imageNamed:self.imgArray[indexPath.section][indexPath.row]];

    [cell.imgBtn addTarget:self action:@selector(ciclkImgButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.imgBtn setImage:[UIImage imageNamed:@"默认_1"] forState:UIControlStateNormal];
    [cell.imgBtn setImage:[UIImage imageNamed:self.btnArray[indexPath.section][indexPath.row]] forState:UIControlStateSelected];
    cell.imgBtn.tag = 1000 + indexPath.section * 100 + indexPath.row;
    
    return cell;
}

-(void)ciclkImgButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSInteger tag10 = (sender.tag - 1000) / 100;
    NSInteger tag1 = (sender.tag - 1000) % 100;
    AllTypeModel *modelList = self.dataArray[tag10];
    TypeListModel *model = modelList.Item[tag1];
    if (sender.selected) {
//        _btnSelected[tag10][tag1] = @"1";
        model.IsCheck = YES;
        [self.selectArray addObject:[NSString stringWithFormat:@"%ld",model.Id]];
    } else {
//        _btnSelected[tag10][tag1] = @"0";
        model.IsCheck = NO;

        [self.selectArray removeObject:[NSString stringWithFormat:@"%ld",model.Id]];
        
    }
 
}

#pragma mark - 类别的数据获取
-(void) getTypeListData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper getAllGenerWithUserId:kUserID Success:^(NSArray *response) {
        st_dispatch_async_main(^{
            
            self.dataArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                AllTypeModel *model = [AllTypeModel mj_objectWithKeyValues:response[i]];
                
                [self.dataArray addObject:model];
                
            }
            if(self.dataArray.count == 0){
                [self.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
            }
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self.tableView reloadData];
            
            for (int i = 0; i < self.dataArray.count; i++) {
                AllTypeModel *model = self.dataArray[i];
                for (int j = 0; j < model.Item.count; j ++ ) {
                    TypeListModel *viewModel = model.Item[j];
                    if (viewModel.IsCheck == true) {
                        [self.selectArray addObject:[NSString stringWithFormat:@"%ld",viewModel.Id]];
                    }
                }
            }
            
            NSLog(@"%@",self.selectArray);
            
            
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        
        [self.view hideHubWithActivity];
        [self.view showFailedViewReloadBlock:^{
//            [self.view showActivityWithImage:kLoadingImage];
            [self getTypeListData];
        }];
        [SVProgressHUD showSuccessWithStatus:@"失败"];
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
    
     UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 100, 30);
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 离线作品按钮的点击事件的实现
-(void)rightNavBtnAction:(UIButton *)sender{
    if (self.selectArray.count == 0) {
        [SVProgressHUD showSuccessWithStatus:@"请选择类型"];
        return;
    }
    NSString *keyclass = [self.selectArray componentsJoinedByString:@","];
    [self.helper userPreferSetWithId:kUserID KeyClass:keyclass Sex:@"" Success:^(NSDictionary *response) {
        st_dispatch_async_main(^{

//            [SVProgressHUD showSuccessWithStatus:@"成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        });
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"失败"];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;//不设置为黑色背景
}

@end
