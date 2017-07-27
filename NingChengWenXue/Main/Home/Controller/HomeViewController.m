//
//  HomeViewController.m
//  IrregularTabBar
//
//  Created by JYJ on 16/5/3.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import "HomeViewController.h"
#import "HeadButtonView.h"
#import "ScrollTableViewCell.h"
#import "RootTableHeaderView.h"
#import "WeekChartTableViewCell.h"
#import "ViewModel.h"
#import "TyrantTableViewCell.h"
#import "WordsTableViewCell.h"
#import "NovelCollectionViewCell.h"
#import "NovelDetailViewController.h"
// 跑马灯
#import "UIColor+Wonderful.h"
#import "SXMarquee.h"
#import "SXHeadLine.h"
// 排行榜
#import "HBillboardViewController.h"
// 分类
#import "HclassifyViewController.h"
// 超精华
#import "HEssenceViewController.h"
// 推荐
#import "HRecommendViewController.h"
#import "HSchUniViewController.h"
#import "HSecMoreViewController.h"
#import "HMoreBtnViewController.h"
#import "HSubscribeViewController.h"
#import "HSearchViewController.h"
#import "NCHomePageHelper.h"
#import "SysMessageModel.h"
#import "TuiJianModel.h"
#import "BookListModel.h"
#import "BookKeysModel.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, SDCycleScrollViewDelegate ,BFBtnClickDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UITableView *rootTableView;
@property(nonatomic, strong) UIView *headView;
@property(nonatomic, strong) UIView *tableFootView;
@property(nonatomic, strong) HeadButtonView *buttonView;
@property(nonatomic, strong) NSArray *typeArray;
@property(nonatomic, strong) NSArray *nameArray;
@property(nonatomic, strong) NSArray *imgArray;
/** 跑马灯 **/
@property(nonatomic, strong) SXHeadLine *headLine;
@property(nonatomic, strong) UIView *footView;
@property(nonatomic, strong) UIImageView *cellHeaderImg;

/**分区头设置数组**/
@property(nonatomic, strong) NSArray *cellHeadImgArray;
@property(nonatomic, strong) NSArray *cellHeadnameArray;
@property(nonatomic, strong) NSArray *cellHeadColorArray;

/**tableview尾视图**/
@property(nonatomic, strong) UICollectionView *colletionView;
/**导航栏搜索按钮**/
@property (nonatomic, strong) UIButton *searchBtn;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (strong, nonatomic) NSMutableArray *sysMessageArray;
@property (nonatomic, strong) NSArray *fictionArray;
@property (nonatomic, strong) NSArray *collectArray;
@property (nonatomic, strong) NSArray *DaShangArray;
@property (nonatomic, strong) NSArray *MaWangArray;
@property (nonatomic, strong) NSArray *TuHaoArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) CGFloat collectionHeight;


@end


@implementation HomeViewController

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
    self.navigationController.navigationBar.translucent = true;//不设置为黑色背景
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self getSearchNovelData];
    // 系统消息的获取
    [self getSysmessageDate];

    self.collectionHeight = 0;
    
#pragma mark - 创建头部搜索按钮
    self.searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 225, 24)];
    self.searchBtn.alpha = 0.7;
    [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"搜索_bg-1"] forState:UIControlStateNormal];
    [self.searchBtn setImage:[UIImage imageNamed:@"fangdajing"] forState:UIControlStateNormal];
    [self.searchBtn setTitle:@"大主宰" forState:UIControlStateNormal];
    self.searchBtn.titleLabel.font = THIRDFont;
    [self.searchBtn addTarget:self action:@selector(clickSearchButton) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBtn setTitleColor:BXColor(152, 152, 152) forState:UIControlStateNormal];
    self.navigationItem.titleView = self.searchBtn;
    
    self.typeArray = @[@"玄幻·奇幻",@"古代言情·穿越架空",@"武侠仙侠"];
    self.nameArray = @[@"大主宰",@"邪神",@"王爷",@"遮天",@"穿越"];
    self.imgArray = @[@"大主宰",@"斗破苍穹",@"古代调香师",@"九鼎记",@"全职高手"];
    self.cellHeadImgArray = @[@"玄幻-2",@"言情-1",@"武侠仙侠",@"打赏",@"收藏_1",@"码王",@"土豪"];
    self.cellHeadnameArray = @[@"奇幻·玄幻",@"古代言情·穿越架空",@"武侠仙侠",@"打赏周榜",@"收藏周榜",@"码王周榜",@"土豪周榜"];
    self.cellHeadColorArray = @[BXColor(253,198,70),BXColor(253,116,157),BXColor(149,195,255),BXColor(252,151,118),BXColor(244,184,15),BXColor(102,135,170),BXColor(248,118,152)];
    
    [self setRootTableView];
    
    [self getRecommendAndRankListData];
    // 轮播图的获取
    [self getLunBoPictrueData];
    
    
    self.rootTableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
//    self.colletionView.mj_footer = [MJDIYHeader]
    self.rootTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark - 搜索按钮的点击事件
-(void) clickSearchButton {
    HSearchViewController *vc = [[HSearchViewController alloc] init];

    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [tableView reloadData];
//        
//        // 拿到当前的下拉刷新控件，结束刷新状态
//    });
    self.pageNum = 1;
    [self getSearchNovelData];
    // 系统消息的获取
    [self getSysmessageDate];
    [self getRecommendAndRankListData];
    // 轮播图的获取
    [self getLunBoPictrueData];
    [self getDingYueNovelData];
}

-(void) loadMoreData{
    self.pageNum++;
    [self getDingYueNovelData];
}

#pragma mark - 创建TableView
-(void) setRootTableView {
    
    self.rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 52) style:(UITableViewStyleGrouped)];
    self.rootTableView.delegate = self;
    self.rootTableView.dataSource = self;
    self.rootTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.rootTableView];
    self.rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rootTableView.backgroundColor =BXColor(195, 195, 195);
    self.rootTableView.estimatedRowHeight = 500;
    
    [self.rootTableView registerClass:[ScrollTableViewCell class] forCellReuseIdentifier:@"thirdcell"];
    [self.rootTableView registerClass:[ScrollTableViewCell class] forCellReuseIdentifier:@"firstcell"];
    [self.rootTableView registerClass:[ScrollTableViewCell class] forCellReuseIdentifier:@"secondcell"];
    [self.rootTableView registerClass:[WeekChartTableViewCell class] forCellReuseIdentifier:@"fightCell"];
    [self.rootTableView registerClass:[WeekChartTableViewCell class] forCellReuseIdentifier:@"collectCell"];
    [self.rootTableView registerClass:[WordsTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.rootTableView registerClass:[TyrantTableViewCell class] forCellReuseIdentifier:@"tyrantCell"];

    self.headView = [[UIView alloc] init];
    self.headView.frame = CGRectMake(0, 0, BXScreenW, 372);
    self.headView.backgroundColor = BXColor(195, 195, 195);
    self.rootTableView.tableHeaderView = self.headView;
    
//    self.tableFootView = [[UIView alloc] init];
//    self.tableFootView.frame = CGRectMake(0, 0, BXScreenW, 500);
//    self.tableFootView.backgroundColor = BXColor(195, 195, 195);
//    self.rootTableView.tableFooterView = self.tableFootView;
    
    // 调用按钮
    [self setHeadEightButton];
    
    [self setTableFooterViewUI];
    
}

#pragma mark - 创建轮播图下方的按钮及跑马灯
- (void) setHeadEightButton {
    
    _buttonView = [[HeadButtonView alloc] initWithFrame:CGRectMake(0, 176, BXScreenW, 146)];
    _buttonView.backgroundColor = [UIColor whiteColor];
    [self.headView addSubview:_buttonView];
    
    NSLog(@"%ld",_buttonView.btnArray.count);
    for (int i = 0; i<_buttonView.btnArray.count; i++) {
        
        [_buttonView.btnArray[i] addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 创建跑马灯
    [self AddHeaderLine];
    self.footView.frame = CGRectMake(0, 322, BXScreenW, 40);
    [self.headView addSubview:self.footView];
    self.cellHeaderImg.image = [UIImage imageNamed:@"消息_1"];
    [self.headLine setBgColor:[UIColor whiteColor] textColor:BXColor(236,105,65) textFont:[UIFont systemFontOfSize:13]];
}

#pragma mark - UITableViewViewDelegate
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
// 每个分区的cell数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section < 3) {
        return 1;
    }else if (section == 3){
        if (self.DaShangArray.count >= 3) {
            return 3;
        }else{
            return self.DaShangArray.count;
        }
    }else if (section == 4){
        if (self.collectArray.count >= 3) {
            return 3;
        }else{
            return self.collectArray.count;
        }
    }else if (section == 5){
        if (self.MaWangArray.count >= 3) {
            return 3;
        }else{
            return self.MaWangArray.count;
        }
    }else{
        if (self.TuHaoArray.count >= 3) {
            return 3;
        }else{
            return self.TuHaoArray.count;
        }
        
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    self.rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (indexPath.section == 0) {
    
        ScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstcell" forIndexPath:indexPath];
        BookListModel *tuijianModel = self.fictionArray[indexPath.section];
        
        [cell countOfButton:tuijianModel.FictionList.count namearray:tuijianModel.FictionList imgarray:tuijianModel.FictionList];
        cell.delegate = self;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.rowHeight = 165;
        
        return cell;
    }else if (indexPath.section == 1){
        ScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondcell" forIndexPath:indexPath];
        BookListModel *tuijianModel = self.fictionArray[indexPath.section];
        
        [cell countOfButton:tuijianModel.FictionList.count namearray:tuijianModel.FictionList imgarray:tuijianModel.FictionList];
        cell.delegate = self;
        tableView.rowHeight = 165;
        return cell;
    }else if (indexPath.section == 2){
        ScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thirdcell" forIndexPath:indexPath];
        BookListModel *tuijianModel = self.fictionArray[indexPath.section];
        
        [cell countOfButton:tuijianModel.FictionList.count namearray:tuijianModel.FictionList imgarray:tuijianModel.FictionList];
        cell.delegate = self;
        tableView.rowHeight = 165;
        return cell;
    }else if (indexPath.section == 3){
        BookListModel * model = self.DaShangArray[indexPath.row];
        WeekChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fightCell" forIndexPath:indexPath];
        model.row = indexPath.row;
        BOOL setFlag = YES;
        for (ViewModel * isShow in self.DaShangArray) {
            if (isShow.isShowBig) {
                setFlag = NO;
                break;
            }
        }
        
        if (setFlag&&indexPath.row==0) {
            model.isShowBig = YES;
        }
        cell.row = indexPath.row + 1;
        cell.viewModel = model;
        tableView.rowHeight = cell.hetght;
        return cell;
    }else if (indexPath.section == 4){
        WeekChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectCell" forIndexPath:indexPath];
        BookListModel * model = self.collectArray[indexPath.row];
        model.row = indexPath.row;
        BOOL setFlag = YES;
        for (ViewModel * isShow in self.collectArray) {
            if (isShow.isShowBig) {
                setFlag = NO;
                break;
            }
        }
        if (setFlag&&indexPath.row==0) {
            model.isShowBig = YES;
        }
        cell.row = indexPath.row + 1;
        cell.viewModel = model;
        tableView.rowHeight = cell.hetght;
        return cell;
    }else if (indexPath.section == 5 ) {
        WordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        BookListModel * model = self.MaWangArray[indexPath.row];
        model.row = indexPath.row;
        BOOL setFlag = YES;
        for (ViewModel * isShow in self.MaWangArray) {
            if (isShow.isShowBig) {
                setFlag = NO;
                break;
            }
        }
        if (setFlag&&indexPath.row==0) {
            model.isShowBig = YES;
        }
        cell.cellrow = indexPath.row + 1;
        cell.viewModel = model;
        tableView.rowHeight = cell.hetght;
    
        return cell;
    }else{
    
        TyrantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tyrantCell" forIndexPath:indexPath];
        BookListModel * model = self.TuHaoArray[indexPath.row];
        model.row = indexPath.row;
        BOOL setFlag = YES;
        for (ViewModel * isShow in self.TuHaoArray) {
            if (isShow.isShowBig) {
                setFlag = NO;
                break;
            }
        }
        if (setFlag&&indexPath.row==0) {
            model.isShowBig = YES;
        }
        cell.row = indexPath.row + 1;
        cell.viewModel = model;
        tableView.rowHeight = cell.hetght;
        return cell;
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 0) {
//        return 50;
        return 5;
    }else if (section == 1){
//        return 50;
        return 5;
    }else if (section == 2){
//        return 50;
        return 5;
    }else if (section == 3){
        return 5;
    }else if (section == 4){
        return 5;
    }else if (section == 5){
        return 5;
    }else if (section == 6){
        return 10;
    }else{
        return 0.01;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

#pragma mark - tableview分区头设置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    RootTableHeaderView *head = [[RootTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 50)];
    head.backgroundColor = [UIColor whiteColor];
    if (section < 3) {
       BookListModel *model = self.fictionArray[section];
        head.titleLab.text = model.ClassName;
    }else{
        
        head.titleLab.text = self.cellHeadnameArray[section];
    }
    head.titleLab.textColor = self.cellHeadColorArray[section];
    head.headImage.image = [UIImage imageNamed:self.cellHeadImgArray[section]];
    head.moreBtn.tag = 10000+section;
    [head.moreBtn addTarget:self action:@selector(clickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    return head;
}

#pragma mark - tableView分区尾设置
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = BXColor(195, 195, 195);
//    [self AddHeaderLine];
//    if (section == 0) {
//        [self AddHeaderLine];
//        [footView addSubview:self.footView];
//        self.cellHeaderImg.image = [UIImage imageNamed:@"消息_2"];
//        [self.headLine setBgColor:[UIColor whiteColor] textColor:BXColor(253,198,70) textFont:THIRDFont];
//    }else if (section == 1) {
//        [self AddHeaderLine];
//        [footView addSubview:self.footView];
//        self.cellHeaderImg.image = [UIImage imageNamed:@"消息_3"];
//        [self.headLine setBgColor:[UIColor whiteColor] textColor:BXColor(253,116,157) textFont:THIRDFont];
//    }else if (section == 2) {
//        [self AddHeaderLine];
//        [footView addSubview:self.footView];
//        self.cellHeaderImg.image = [UIImage imageNamed:@"消息_4"];
//        [self.headLine setBgColor:[UIColor whiteColor] textColor:BXColor(149,195,255) textFont:THIRDFont];
//    }
    

    return footView;

}

#pragma mark - tableviewCell点击方法的实现
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *dataArr = [[NSArray alloc] init];
    
    if (indexPath.section > 2 && indexPath.section < 7) {
        if (indexPath.section == 3) {
            dataArr = self.DaShangArray;
            
        }else if (indexPath.section == 4){
            dataArr = self.collectArray;
        }else if (indexPath.section == 5){
            dataArr = self.MaWangArray;
        }else{
            dataArr = self.TuHaoArray;
        }
        BookListModel * model = dataArr[indexPath.row];
        if (model.isShowBig) {
            if (indexPath.section == 3 || indexPath.section == 4) {
                NovelDetailViewController *vc = [[NovelDetailViewController alloc] init];
                vc.bookId = model.FictionId;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                NSLog(@"跳作者页面");
            }
            
        }else{
            for (ViewModel * isShow in dataArr) {
                if (isShow.row == indexPath.row) {
                    isShow.isShowBig = YES;
                }else{
                    isShow.isShowBig = NO;
                }
            }
            [self.rootTableView reloadData];
            NSLog(@"小变大改变UI");
        }
    }
    
    
    
}

#pragma mark - 实现滑动模块小说的点击方法
-(void)BFCell:(ScrollTableViewCell *)bfcell didClickBFBtnTag:(NSInteger)BFBtnTag currentBFBtn:(UIButton *)sender{
    
    ScrollTableViewCell *cell = (ScrollTableViewCell *)[[[sender superview]superview]superview];
    NSIndexPath *indexPathAll = [self.rootTableView indexPathForCell:cell];
    NSLog(@"当前点击的是%ld行id为%zd",indexPathAll.section,BFBtnTag-10000);
    BookListModel *tuijianModel = self.fictionArray[indexPathAll.section];
    BookKeysModel *model = tuijianModel.FictionList[BFBtnTag - 10000];
    NSLog(@"%@",model.FictionId);
    NovelDetailViewController *vc = [[NovelDetailViewController alloc] init];
    vc.bookId = model.FictionId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate(轮播图的点击方法)

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
}

#pragma mark - 上方排行榜、分类等按钮点击方法
-(void) clickButton:(UIButton *)btn {
    // 排行榜
    if (btn.tag == 1000) {
        HBillboardViewController *vc = [[HBillboardViewController alloc] init];
        vc.typeStr = @"排行榜";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1001) {
        HclassifyViewController *vc = [[HclassifyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1002) {
        NSLog(@"啦啦啦");
        HBillboardViewController *vc = [[HBillboardViewController alloc] init];
        vc.typeStr = @"完本榜";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1003) {
        HSchUniViewController *vc = [[HSchUniViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1004) {
        HEssenceViewController *vc = [[HEssenceViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1005) {
        HRecommendViewController *vc = [[HRecommendViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag == 1006) {
        HMoreBtnViewController *vc = [[HMoreBtnViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 分区头更多按钮的点击方法
-(void) clickMoreButton:(UIButton *)sender {
    if (sender.tag - 10000 < 3) {
        HSecMoreViewController *vc = [[HSecMoreViewController alloc] init];
        BookListModel *model = self.fictionArray[sender.tag - 10000];
        vc.title = model.ClassName;
        vc.classId = [NSString stringWithFormat:@"%ld",model.ClassId];
        [self.navigationController pushViewController:vc animated:YES];
    }else{

        HBillboardViewController *vc = [[HBillboardViewController alloc] init];
        NSMutableString *mString = [NSMutableString stringWithString:self.cellHeadnameArray[sender.tag - 10000]];
        //第一个参数是要删除的字符的索引，第二个是从此位开始要删除的位数
        [mString deleteCharactersInRange:NSMakeRange(2, 1)];
        vc.typeStr = mString;
        NSLog(@"%@",vc.typeStr);
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


#pragma mark - 创建tableView尾视图
-(void) setTableFooterViewUI {
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(23, 0, BXScreenW - 46, 50)];
    imgView.image = [UIImage imageNamed:@"我要上首页"];
    
    UILabel *fengLab = [[UILabel alloc] initWithFrame:CGRectMake(23, 70, BXScreenW - 146, 15)];
    fengLab.text = @"能添加自己喜欢的风格哦!";
    fengLab.textColor = BXColor(40, 40, 40);
    fengLab.font = ELEFont;
    
    UIButton *subBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 123, 70, 100, 15)];
    [subBtn setTitle:@"订阅>>" forState:UIControlStateNormal];
    subBtn.titleLabel.font = ELEFont;
    [subBtn setTitleColor:BXColor(240,96,95) forState:UIControlStateNormal];
    subBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    subBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [subBtn addTarget:self action:@selector(clickSubButton) forControlEvents:UIControlEventTouchUpInside];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=15; //设置每一行的间距

    self.colletionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    //注册cell单元格
    self.colletionView.delegate=self;
    self.colletionView.dataSource=self;
    self.colletionView.scrollEnabled = NO;
    self.colletionView.backgroundColor = [UIColor whiteColor];
    self.colletionView.showsVerticalScrollIndicator = NO;
    self.colletionView.frame=CGRectMake(0, 95, BXScreenW, 440);
    self.tableFootView = [[UIView alloc] init];
    self.tableFootView.backgroundColor = [UIColor whiteColor];
    self.rootTableView.tableFooterView = self.tableFootView;
    [self.tableFootView addSubview:self.colletionView];
    // 添加上首页图片
    [self.tableFootView addSubview:imgView];
    [self.tableFootView addSubview:fengLab];
    // 添加订阅按钮
    [self.tableFootView addSubview:subBtn];
    
    //注册cell单元格
    [self.colletionView registerClass:[NovelCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

#pragma mark - collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NovelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    BookKeysModel *model = self.dataArray[indexPath.item];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.FictionImage] placeholderImage:[UIImage imageNamed:@"书"]];
    cell.nameLab.text = model.FictionName;
    cell.writorLab.text = model.AuthorName;
    cell.typeLab.text = model.FictionStatusName;
    
    
    return cell;

}

#pragma mark ---- UICollectionViewDelegateFlowLayout


//设置每个 UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((BXScreenW - 60)/3, 125);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

#pragma mark - collectionViewCell 的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BookKeysModel *model = self.dataArray[indexPath.item];
    NovelDetailViewController *vc = [[NovelDetailViewController alloc] init];
    vc.bookId = model.FictionId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 点击订阅按钮跳转的点击事件
-(void) clickSubButton {
    if (kUserLogin == YES) {
        HSubscribeViewController *vc = [[HSubscribeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - 创建跑马灯
-(void) AddHeaderLine {
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 40)];
    self.footView.backgroundColor = [UIColor whiteColor];
    
    self.cellHeaderImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
    [self.footView addSubview:_cellHeaderImg];
    
    self.headLine = [[SXHeadLine alloc]initWithFrame:CGRectMake(50, 0, BXScreenW - 50, 40)];
//    self.headLine.messageArray = @[@"库里43分，勇士吊打骑士",@"伦纳德死亡缠绕詹姆斯，马刺大胜骑士",@"乐福致命失误，骑士惨遭5连败",@"五小阵容发威，雄鹿吊打骑士", @"天猫的双十一，然而并没卵用"];
    
    [self.footView addSubview:self.headLine];
}

#pragma mark - ScrollViewDelegate -
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollY = scrollView.contentOffset.y;
    [self.view endEditing:true];
    if (scrollY<0) {
        self.searchBtn.hidden = YES;
    }else{
        self.searchBtn.hidden = NO;
    }
    
    if (scrollY>64) {
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
        self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.translucent = NO;//不设置为黑色背景
        [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"搜索_灰"] forState:UIControlStateNormal];
#pragma mark - 判断是否进入过阅读页面(设置tabbar功能)

    }else{
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
        self.navigationController.navigationBar.translucent = YES;
        [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"搜索_bg-1"] forState:UIControlStateNormal];
        

    }
}

- (void)viewWillAppear:(BOOL)animated{

    if (self.rootTableView.contentOffset.y == 0) {
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
        self.navigationController.navigationBar.translucent = YES;//不设置为黑色背景
        [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"搜索_bg-1"] forState:UIControlStateNormal];
        
    }else{
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
        self.navigationController.navigationBar.translucent = NO;//不设置为黑色背景
    }
    
    // 订阅小说数据的获取
    self.pageNum = 1;
    [self getDingYueNovelData];
}

#pragma mark - 系统消息的获取
-(void) getSysmessageDate {

    [self.helper SysMessageWithSuccess:^(NSArray *response) {
        st_dispatch_async_main(^{
            
            self.sysMessageArray = [[NSMutableArray alloc] init];
            self.headLine.messageArray = [[NSMutableArray alloc] init];
            NSMutableArray *myMutableArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                
                SysMessageModel *model = [SysMessageModel mj_objectWithKeyValues:response[i]];
                [self.sysMessageArray addObject:model];
                NSLog(@"%@",model);
                NSLog(@"%@",self.sysMessageArray);
                [myMutableArray addObject:model.Title];
            }
            
            self.headLine.messageArray = [myMutableArray copy];
            [self.headLine setScrollDuration:0.5 stayDuration:3];
            self.headLine.hasGradient = YES;
            [self.headLine changeTapMarqueeAction:^(NSInteger index) {
                
                NSLog(@"你点击了第 %ld 个button！内容：%@", index, self.headLine.messageArray[index]);
            }];
            [self.headLine start];
            
        });
        return ;
        
    } faild:^(NSString *response, NSError *error) {
//        [SVProgressHUD showSuccessWithStatus:@"失败"];
        
    }];
}

#pragma mark - 推荐与排行榜的数据获取
-(void) getRecommendAndRankListData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper recommendAndRankListWithSuccess:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            self.fictionArray = [[NSArray alloc] init];
            self.collectArray = [[NSArray alloc] init];
            TuiJianModel *model = [TuiJianModel mj_objectWithKeyValues:response];
            self.fictionArray = model.FictionClassItem;
            self.collectArray = model.Collect;
            self.DaShangArray = model.DaShang;
            self.MaWangArray = model.MaWang;
            self.TuHaoArray = model.TuHao;
            [self.view hideHubWithActivity];
            [self.rootTableView reloadData];
        });
       
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
//        [self.view showFailedViewReloadBlock:^{
//            [self.view showActivityWithImage:kLoadingImage];
//            [self getSysmessageDate];
//        }];
        [SVProgressHUD showSuccessWithStatus:@"失败"];
        
    }];
}

#pragma mark - 轮播图数据解析
-(void) getLunBoPictrueData {
    [self.helper CarouselPictrueWithSuccess:^(NSArray *response) {
        st_dispatch_async_main(^{
            
            NSMutableArray *picArray = [[NSMutableArray alloc] init];
            for (int i=0; i<response.count; i++) {
                SysMessageModel *model = [SysMessageModel mj_objectWithKeyValues:response[i]];
                
                [picArray addObject:model.FictionImage];
            }
            
            [self setHeadCycleScrollView:picArray];
            
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
//        [SVProgressHUD showSuccessWithStatus:@"失败"];
    }];
}

#pragma mark - 创建顶部轮播图
- (void) setHeadCycleScrollView:(NSMutableArray *)dataArray {
    
    NSArray *groupImgs = [dataArray copy];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 176) delegate:self placeholderImage:[UIImage imageNamed:@"上首页_1"]];
    cycleScrollView.delegate = self;
    cycleScrollView.imageURLStringsGroup = groupImgs;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.headView addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // --- 轮播时间间隔，默认1.0秒，可自定义
    cycleScrollView.autoScrollTimeInterval = 2.0;
}

#pragma mark - 订阅小说数据的获取
- (void) getDingYueNovelData {
    NSString *ID  = @"";
    if (kUserLogin == YES) {
        ID = kUserID;
        NSLog(@"%@",kUserID);
    }else{
        ID = @"";
    }
   
    [self.helper subscribeNovelWithId:ID KeyClass:@"" Sex:@"" PageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageNum] Success:^(NSArray *response) {
        st_dispatch_async_main(^{
            if (self.pageNum == 1) {
                
                self.dataArray = [[NSMutableArray alloc] init];
            }
            for (int i=0; i<response.count; i++) {
                BookKeysModel *model = [BookKeysModel mj_objectWithKeyValues:response[i]];
                
                [self.dataArray addObject:model];
            }

            if (self.dataArray.count % 3 == 0) {
                self.colletionView.frame = CGRectMake(0, 95, BXScreenW, (self.dataArray.count/3)*140);
            }else{
                self.colletionView.frame = CGRectMake(0, 95, BXScreenW, (self.dataArray.count/3 + 1)*140);
            }
            self.tableFootView.frame = CGRectMake(0, 0, BXScreenW, CGRectGetMaxY(self.colletionView.frame));
            [self.rootTableView reloadData];
            [self.colletionView reloadData];
            [self.rootTableView.mj_header endRefreshing];
            [self.rootTableView.mj_footer endRefreshing];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.rootTableView.mj_header endRefreshing];
        [self.rootTableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 搜索默认小说名
-(void) getSearchNovelData {
    [self.helper hotdefaultWithSuccess:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:response];
            if (model.StatusCode == 200) {
                
                [self.searchBtn setTitle:model.datas forState:UIControlStateNormal];
            }else{
                
            }
        });
    } faild:^(NSString *response, NSError *error) {
        
    }];
}

@end
