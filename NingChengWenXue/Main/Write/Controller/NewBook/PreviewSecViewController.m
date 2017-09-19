//
//  PreviewSecViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/8/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "PreviewSecViewController.h"
#import "NCWriteHelper.h"
#import "HReadMenuView.h"
#import "HComListViewController.h"
#import "NovelConCollectionViewCell.h"
#import "SectionListModel.h"
#import "TReaderBook.h"
#import "TReaderManager.h"
#import "TReaderMark.h"
#import "UIView+NIB.h"
#import "TYAttributedLabel.h"
#import "ReadHeadCollectionReusableView.h"

@interface PreviewSecViewController ()<UIGestureRecognizerDelegate,LSYMenuViewDelegate,UINavigationControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) HReadMenuView *menuView;
@property (nonatomic, strong) NCWriteHelper *helper;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) TReaderBook *readerBook;
@property (nonatomic, strong) TReaderChapter *chapter;
@property (nonatomic, assign) CGSize renderSize;    // 渲染大小
@property (nonatomic, assign) NSInteger curPage;    // 当前页数
@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation PreviewSecViewController

- (NCWriteHelper *)helper{

    if (!_helper) {
        _helper = [NCWriteHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.delegate = self;
    [self setUpCollectionViewUI];
    
    [self setUpMenuViewUI];
    
    self.dataArray = [[NSMutableArray alloc] init];
    if (self.loadType == 1) {
        [self getBookChapter:1 Model:self.sectionModel];
    }else{
        [self getNovelContentData];
        
    }
    // 上方标题
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, BXScreenW, 20)];
    self.titleLab.font = THIRDFont;
    self.titleLab.backgroundColor = BXColor(240,226,226);
    self.titleLab.textColor = BXColor(152, 152, 152);
    [self.view addSubview:self.titleLab];
    
    [self.view addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showToolMenu)];
        tap.delegate = self;
        tap;
    })];
}

#pragma mark - 创建CollectionViewUI
-(void)setUpCollectionViewUI{
    self.flowLayout=[[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.flowLayout.minimumLineSpacing = 0;
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    //    self.collectionView.pagingEnabled = YES;
    //    self.collectionView.bounces = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.collectionView.frame=CGRectMake(0, 40, BXScreenW, BXScreenH-40);
    self.flowLayout.itemSize = self.collectionView.bounds.size;
    
    [_collectionView registerClass:[NovelConCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NovelConCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = BXColor(240,226,226);

    cell.contentLab.attributedText = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - 添加菜单栏
-(void) setUpMenuViewUI {
    _menuView = [[HReadMenuView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    _menuView.delegate = self;
    [self.view addSubview:_menuView];
    _menuView.hidden = YES;
    [_menuView.topView.backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    _menuView.topView.fontbtn.hidden = YES;
    _menuView.boomView.hidden = YES;
    _menuView.topView.cataButton.hidden = YES;
}

#pragma mark - 实现菜单栏出现的方法
-(void)showToolMenu
{
    [self.menuView showAnimation:YES];
    self.titleLab.hidden = YES;
}

- (void)menuViewMark{
    [self.menuView hiddenAnimation:YES];
    self.titleLab.hidden = NO;
}

#pragma mark - 返回按钮点击事件
-(void)clickBackButton{

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 章节内容的获取
-(void) getNovelContentData{
    [self.view showHudWithActivity:@"正在加载"];
    NSString *userId = @"00000000-0000-0000-0000-000000000000";
    if (kUserLogin == YES) {
        userId = kUserID;
    }
    [self.helper PreviewNovelSectionWithSectionid:self.sectionID success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            self.dataArray = [[NSMutableArray alloc] init];
            SectionListModel *model = [SectionListModel mj_objectWithKeyValues:response];
            self.titleLab.text = model.SectionName;
            
            [self getBookChapter:1 Model:model];
            [self.collectionView.mj_footer endRefreshing];
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView showFailedViewReloadBlock:^{
            [self getNovelContentData];
        }];
    }];
}

#pragma mark - 获取章节
- (TReaderChapter *)getBookChapter:(NSInteger)chapterIndex Model:(SectionListModel *)model
{
    
    TReaderChapter *chapter = [self openBookWithChapter:chapterIndex Model:model];
    _renderSize = [self renderSizeWithFrame:self.collectionView.frame];
    [chapter parseChapterWithRenderSize:_renderSize];
    [self changecollectionCount:chapter.totalPage chapter:chapter];
    _chapter = chapter;
    return chapter;
}

- (CGRect)renderFrameWithFrame:(CGRect)frame
{
    return CGRectMake(15, 0, BXScreenW-20, BXScreenH-40);
}

- (CGSize)renderSizeWithFrame:(CGRect)frame
{
    return [self renderFrameWithFrame:frame].size;
}

- (TReaderChapter *)openBookWithChapter:(NSInteger)chapter Model:(SectionListModel *)model
{
    TReaderChapter *readerChapter = [[TReaderChapter alloc]init];
    readerChapter.chapterIndex = chapter;
    NSError *error = nil;
    readerChapter.chapterTitle = model.SectionName;
    
    
    readerChapter.chapterContent = model.SectionContent;
    
    if (error) {
        NSLog(@"open book chapter error:%@",error);
        return nil;
    }
    return readerChapter;
}


-(void) changecollectionCount:(NSInteger)count chapter:(TReaderChapter *)chapter {
    
    for (int i = 0; i < count; i++) {
        TYAttributedLabel *label = [[TYAttributedLabel alloc] init];
        label.attributedText = [chapter chapterPagerWithIndex:i].attString;
        [self.dataArray addObject:label.attributedText];
    }
    [self.collectionView reloadData];
    
}

#pragma mark - 视图即将出现
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.translucent = true;//不设置为黑色背景
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

#pragma mark- 视图即将消失
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
