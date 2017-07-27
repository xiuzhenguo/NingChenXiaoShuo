//
//  TestViewController.m
//  RefreshTest
//
//  Created by imac on 16/8/12.
//  Copyright © 2016年 imac. All rights reserved.
//

#import "TestViewController.h"
#import "TestCell.h"

@interface TestViewController ()<UITableViewDelegate, UITableViewDataSource,TestCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) NSArray *imgArray;
@property (nonatomic, strong) NSArray *btnArray;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"订阅";
    _nameArray = [NSArray array];
    _nameArray = @[@[@"奇幻",@"悬疑",@"推理",@"武侠",@"仙侠",@"游戏",@"体育",@"科幻",@"历史",@"军事"],@[@"校园",@"言情",@"都市",@"灵异",@"散文随笔",@"职场",@"剧本",@"诗歌",@"穿越",@"二次元",@"轻小说"]];
    _typeArray = @[@[@"都是异能 西方幻想",@"神秘/悬疑 灵异/惊悚",@"推理/案件",@"武侠",@"玄幻仙侠",@"情感/都市",@"情感/都市 商战/职业 官场 现代/近代",@"科幻/未来",@"宅文/二次元小说",@"军事/战争"],@[@"青春/校园/情感",@"耽美纯爱",@"古代言情 现代言情 女频幻想",@"变身/性逆转",@"散文/随笔",@"ACG同人 偶像同人",@"散文/随笔",@"古诗词/现代书",@"变身/性逆转",@"宅文/二次元小说",@"宅文/二次元小说"]];
    _imgArray = @[@[@"奇幻",@"悬疑",@"推理",@"武侠",@"仙侠",@"游戏",@"体育",@"科幻",@"历史",@"军事"],@[@"校园",@"言情",@"都是",@"灵异",@"随笔",@"职场",@"剧本",@"诗词",@"穿越",@"二次元_1",@"轻小说_1"]];
    _btnArray = @[@[@"奇幻_1",@"悬疑_1",@"推理_1",@"武侠_1",@"仙侠_1",@"游戏_1",@"体育_1",@"科幻_1",@"历史_1",@"军事_1"],@[@"校园_1",@"言情_1",@"都是_1",@"灵异_1",@"随笔_1",@"职场_1",@"剧本_1",@"诗歌_1",@"穿越_1",@"二次元_1",@"轻小说_1"]];
    
    [self setUpNavButtonUI];
    
    [self setUpTableViewUI];
}

#pragma mark - 创建CollectionView视图
- (void) setUpTableViewUI {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH-64)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = BXColor(242,242,242);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;//不设置为黑色背景
}


#pragma mark -UITableView- Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_nameArray[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _nameArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell"];
    if (!cell) {
        cell = [[TestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TestCell"];
    }
    cell.testLb.text = _nameArray[indexPath.section][indexPath.row];
    cell.testBtn.tag = indexPath.row;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

#pragma mark -TestCell Delegate
-(void)SelectedCell:(UIButton *)sender{
//    if (sender.selected) {
//        [_chooseArr addObject:_testArr[sender.tag]];//选中添加
//    }else{
//        [_chooseArr removeObject:_testArr[sender.tag]];//再选取消
//    }
//    for (int i=0; i<_chooseArr.count; i++) {
//        NSLog(@"%@",_chooseArr[i]);//便于观察选中后的数据
//    }
    NSLog(@"==============");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
