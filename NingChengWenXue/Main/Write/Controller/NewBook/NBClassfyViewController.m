//
//  NBClassfyViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/15.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBClassfyViewController.h"
#import "NBClassfyTableViewCell.h"
#import "NBClassfyCollectionViewCell.h"
#import "NCHomePageHelper.h"
#import "NCWriteHelper.h"
#import "AllTypeModel.h"
#import "TypeListModel.h"

@interface NBClassfyViewController ()<UITableViewDelegate, UITableViewDataSource, MyCellDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *colletionView;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) NSMutableArray *footArray;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) NCWriteHelper *help;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation NBClassfyViewController

-(NCHomePageHelper *)helper{
    if (!_helper) {
        _helper = [NCHomePageHelper helper];
    }
    return _helper;
}

-(NCWriteHelper *)help{
    if (!_help) {
        _help = [NCWriteHelper helper];
    }
    return _help;
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
    self.title = @"作品标签";
    
    [self.ortherArray insertObject:@"+自定义" atIndex:0];
    self.footArray = [[NSMutableArray alloc] init];
    NSDictionary *dic = [[NSDictionary alloc] init];
    for (int i = 0; i < self.ortherArray.count; i++) {
        if (i == 0) {
            dic = @{@"ClassName":self.ortherArray[i],@"IsCheck":@NO};
        }else{
            dic = @{@"ClassName":self.ortherArray[i],@"IsCheck":@YES};
        }
        
        TypeListModel *model = [TypeListModel mj_objectWithKeyValues:dic];
        [self.footArray addObject:model];
    }
    
    [self setUpNavButtonUI];
    
    [self setUpTableViewUI];
    
    [self getGenerData];
}

#pragma mark - 创建CollectionView视图
- (void) setUpTableViewUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.backgroundColor = BXColor(242,242,242);
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self setUpTableFootViewUI];
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

#pragma mark - TableViewCell的设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NBClassfyTableViewCell * cell = [NBClassfyTableViewCell setMyTableViewCellWithTableView:tableView];
    AllTypeModel *list = self.dataArray[indexPath.row];
    cell.delegate  = self;
    for (int i = 0; i < list.Item.count; i++) {
        TypeListModel *model = list.Item[i];
        if (self.typeID == model.Id) {
            model.IsCheck = YES;
        }else{
            model.IsCheck = NO;
        }
    }
    cell.section = indexPath.row;
    cell.arr       = list.Item;
    cell.titleLab.text = list.GenerName;
    tableView.rowHeight = cell.height;

    return cell;
   
    
}

#pragma mark - 分区头设置
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 60)];
    backView.backgroundColor = [UIColor whiteColor];
    
    UILabel *linelab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 5, 15)];
    linelab.backgroundColor = BXColor(236,105,65);
    [backView addSubview:linelab];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(25, 15, BXScreenW - 50, 15)];
    titleLab.font = FIFFont;
    titleLab.textColor = BXColor(40, 40, 40);
    titleLab.text = @"官方标签";
    [backView addSubview:titleLab];
    
    UILabel *jieshiLab = [[UILabel alloc] initWithFrame:CGRectMake(25, 35, BXScreenW - 40, 15)];
    jieshiLab.font = THIRDFont;
    jieshiLab.textColor = BXColor(152,152,152);
    jieshiLab.text = @"只能选择一个，选择后，可享受推荐、首页投稿等福利";
    [backView addSubview:jieshiLab];
    
    return backView;
}

#pragma mark - tableViewCell上按钮点击事件回调
- (void)createUIButtonWithTitle:(UIButton *)title Section:(NSInteger)section{
    AllTypeModel *list = self.dataArray[section];
    NSInteger tag = (title.tag - 1000) - (section*100);
    if (!title.selected) {
        TypeListModel *model = list.Item[tag];
        self.typeID = model.Id;
     
    }else{
        self.typeID = -10000000000000;
        
    }
    [self.tableView reloadData];
}

#pragma mark - 创建tableView的尾视图
-(void) setUpTableFootViewUI {
    
    self.footView = [[UIView alloc] init];
    self.footView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = self.footView;
    
    UILabel *linelab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 5, 15)];
    linelab.backgroundColor = BXColor(236,105,65);
    [self.footView addSubview:linelab];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(25, 15, BXScreenW - 50, 15)];
    titleLab.font = FIFFont;
    titleLab.textColor = BXColor(40, 40, 40);
    titleLab.text = @"其他标签";
    [self.footView addSubview:titleLab];
    
    UILabel *jieshiLab = [[UILabel alloc] initWithFrame:CGRectMake(25, 35, BXScreenW - 40, 15)];
    jieshiLab.font = THIRDFont;
    jieshiLab.textColor = BXColor(152,152,152);
    jieshiLab.text = @"可以选择3个让更多读者发现你的作品";
    [self.footView addSubview:jieshiLab];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, BXScreenW, 0.5)];
    line.backgroundColor = BXColor(195,195,195);
    [self.footView addSubview:line];
    
    [self setUpFootViewButtonUI];
}

#pragma mark - 创建tableView尾视图上的自定义按钮
- (void) setUpFootViewButtonUI {
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=15; //设置每一行的间距
    
    self.colletionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    //注册cell单元格
    self.colletionView.delegate=self;
    self.colletionView.dataSource=self;
    self.colletionView.backgroundColor = [UIColor whiteColor];
    self.colletionView.showsVerticalScrollIndicator = NO;
    [self.footView addSubview:self.colletionView];
    
    //注册cell单元格
    [self.colletionView registerClass:[NBClassfyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    if (self.footArray.count % 4 == 0) {
        self.colletionView.frame=CGRectMake(0, 61, BXScreenW, 15+43*(self.footArray.count / 4));
    }else{
        self.colletionView.frame=CGRectMake(0, 61, BXScreenW, 15+43*(self.footArray.count / 4 + 1));
    }
    self.footView.frame = CGRectMake(0, 0, BXScreenW, 61 + self.colletionView.frame.size.height);
}

#pragma mark - collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.footArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NBClassfyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    TypeListModel *model = self.footArray[indexPath.row];
    cell.nameLab.text = model.ClassName;
    if (model.IsCheck == YES) {
        cell.nameLab.backgroundColor = BXColor(236,105,65);
        cell.nameLab.textColor = [UIColor whiteColor];
    }else{
        cell.nameLab.backgroundColor = [UIColor whiteColor];
        cell.nameLab.textColor = BXColor(101,101,101);
    }
   
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.footArray.count; i++) {
            TypeListModel *model = self.footArray[i];
            if (model.IsCheck == YES) {
                [array addObject:model];
            }
            if (array.count == 3) {
                [SVProgressHUD showErrorWithStatus:@"其他标签最多只能选3个"];
                return;
            }
        }
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"输入自定义标签" message:@"自定义标签最长6个中文字符" preferredStyle:UIAlertControllerStyleAlert];
        
        __weak typeof(alertControl) wAlert = alertControl;
        [wAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
            if ([[wAlert.textFields.firstObject text] length] > 12) {
                [SVProgressHUD showErrorWithStatus:@"标签最长6个中文字符"];
                return;
            }else{
                
                NSDictionary *dic = @{@"ClassName":[wAlert.textFields.firstObject text],@"IsCheck":@YES};
                TypeListModel *model = [TypeListModel mj_objectWithKeyValues:dic];
                [self.footArray insertObject:model atIndex:1];
        
            }
            [self.colletionView removeFromSuperview];
            [self.tableView reloadData];
            [self setUpTableFootViewUI];
            
            
        }]];
        
        [wAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [wAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
            
        }];
        
        // 3.显示alertController:presentViewController
        [self presentViewController:wAlert animated:YES completion:nil];
    }else{
        TypeListModel *model = self.footArray[indexPath.row];
        model.IsCheck =! model.IsCheck;
        [self.colletionView reloadData];
    }
    
}

#pragma mark ---- UICollectionViewDelegateFlowLayout


//设置每个 UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((375 - 60)/4, 29);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 10, 15);
}


#pragma mark - 设置导航栏按钮
-(void) setUpNavButtonUI {
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 80, 30);
    [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = item;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 30);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [rightBtn addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark - 右侧完成按钮的点击事件
-(void) clickRightButton {
    if (self.typeID == -10000000000000) {
        [SVProgressHUD showErrorWithStatus:@"请选择官方标签"];
        return;
    }
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.footArray.count; i++) {
        TypeListModel *model = self.footArray[i];
        if (model.IsCheck == YES) {
            [array addObject:model.ClassName];
        }
    }
    
    [self.view showHudWithActivity:@"正在加载"];
    [self.help novelShuXingWithFictionId:self.bookId Key:[array componentsJoinedByString:@","] Category:self.typeID success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            [self.view hideHubWithActivity];
            [SVProgressHUD showSuccessWithStatus:@"成功"];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        return ;
    
     } faild:^(NSString *response, NSError *error) {
         [self.view hideHubWithActivity];
         [SVProgressHUD showErrorWithStatus:@"失败"];
     }];
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 数据的获取
-(void) getGenerData {
    
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper generWithsuccess:^(NSArray *response) {
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            
            for (int i=0; i<response.count; i++) {
                AllTypeModel *model = [AllTypeModel mj_objectWithKeyValues:response[i]];
                
                [self.dataArray addObject:model];
                
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
            [self getGenerData];
        }];
    }];
}

@end
