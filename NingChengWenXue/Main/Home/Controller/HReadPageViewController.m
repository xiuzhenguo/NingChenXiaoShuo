//
//  HReadPageViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/24.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HReadPageViewController.h"
#import "HReadMenuView.h"
#import "HComListViewController.h"
#import "HCatalogueViewController.h"
#import "NovelConCollectionViewCell.h"
#import "NCBookshelfHelper.h"
#import "NCHomePageHelper.h"
#import "MuLuListModel.h"
#import "TReaderBook.h"
#import "TReaderManager.h"
#import "TReaderMark.h"
#import "UIView+NIB.h"
#import "TYAttributedLabel.h"
#import "NovelDetailViewController.h"
#import "HAuthorsViewController.h"
#import "HDynListViewController.h"
#import "ReadHeadCollectionReusableView.h"

@interface HReadPageViewController ()<UIGestureRecognizerDelegate,LSYMenuViewDelegate,UINavigationControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) HReadMenuView *menuView;
@property (nonatomic, strong) NCBookshelfHelper *help;
@property (nonatomic, strong) NCHomePageHelper *helper;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *sectionArray;//分区头数组(放标题)
@property (nonatomic, strong) NSMutableArray *secIDArray;
@property (nonatomic, strong) NSString *preID;// 上一章主键
@property (nonatomic, strong) NSString *nextID;//下一章主键

@property (nonatomic, strong) TReaderBook *readerBook;
@property (nonatomic, strong) TReaderChapter *chapter;
@property (nonatomic, assign) CGSize renderSize;    // 渲染大小
@property (nonatomic, assign) NSInteger curPage;    // 当前页数
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) NSString *sectionId;
@property (nonatomic, weak) UIActivityIndicatorView *indicatorView;

@end

@implementation HReadPageViewController

-(NCBookshelfHelper *)help{
    if (!_help) {
        _help = [NCBookshelfHelper helper];
    }
    return _help;
}

-(NCHomePageHelper *)helper{
    if (!_helper) {
        _helper = [NCHomePageHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BXColor(240,226,226);
    
    self.navigationController.delegate = self;
    [self setUpCollectionViewUI];
    
    [self setUpMenuViewUI];
    
    self.dataArray = [[NSMutableArray alloc] init];
    self.sectionArray = [[NSMutableArray alloc] init];
    self.secIDArray = [[NSMutableArray alloc] init];
    [self.secIDArray addObject:self.secID];
    [self getNovelContentData];
    // 上方标题
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, BXScreenW, 20)];
    self.titleLab.font = THIRDFont;
    self.titleLab.backgroundColor = BXColor(240,226,226);
    self.titleLab.textColor = BXColor(152, 152, 152);
    //        headLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleLab];
    
    [self.view addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showToolMenu)];
        tap.delegate = self;
        tap;
    })];
    
       
    self.collectionView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNextMoreData)];
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.loadType = 1;
    [self getNovelContent];
    
}

#pragma mark - 下拉加载数据
-(void)loadNextMoreData{
    self.loadType = 2;
    [self getNextNovelContent];
}

#pragma mark - 创建CollectionViewUI
-(void)setUpCollectionViewUI{
    self.flowLayout=[[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.flowLayout.minimumLineSpacing = 0;
//    self.flowLayout.itemSize = CGSizeMake(BXScreenW, BXScreenH - 40);
    
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
    //注册头视图
    [self.collectionView registerClass:[ReadHeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell"];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSLog(@"%ld",self.dataArray.count);
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    arr = self.dataArray[section];
    return arr.count;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(BXScreenW, BXScreenH - 40);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NovelConCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = BXColor(240,226,226);
    
    cell.contentLab.attributedText = self.dataArray[indexPath.section][indexPath.row];
    
    return cell;
}

#pragma mark - 确定是当前内容的章节
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    self.SectionIndex = indexPath.section;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.y / scrollView.frame.size.height;
    
    for (int i = 0; i < self.novelArray.count; i++) {
        _chapter.chapterContent = self.novelArray[i];
        [_chapter parseChapter];
        if (page < _chapter.totalPage) {
            self.titleLab.text = self.sectionArray[i];
            return;
        }
        page = page - _chapter.totalPage;
    }
    

}

//#pragma mark - 分区头设置
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        ReadHeadCollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
        header.backgroundColor = BXColor(240,226,226);
        header.titleLab.text = self.sectionArray[indexPath.section];
        
        
        return header;
    }
    
    return nil;
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){BXScreenW,0};
}

#pragma mark - 添加菜单栏
-(void) setUpMenuViewUI {
    _menuView = [[HReadMenuView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    _menuView.delegate = self;
    [self.view addSubview:_menuView];
    _menuView.hidden = YES;
    [_menuView.topView.backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    // 添加字体放大的点击方法
    [_menuView.topView.addFontBtn addTarget:self action:@selector(clickAddFontButton) forControlEvents:UIControlEventTouchUpInside];
    // 添加字体缩小的点击方法
    [_menuView.topView.subFontBtn addTarget:self action:@selector(clickSubFontButton) forControlEvents:UIControlEventTouchUpInside];
    // 评论按钮的点击方法
    [_menuView.boomView.commentBtn addTarget:self action:@selector(clickCommentButton) forControlEvents:UIControlEventTouchUpInside];
    // 收藏按钮的点击方法
    [_menuView.boomView.collectBtn addTarget:self action:@selector(clickCollectionButton) forControlEvents:UIControlEventTouchUpInside];
    // 目录按钮的点击事件
    [_menuView.topView.cataButton addTarget:self action:@selector(clickCataButton) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 进入章节目录
-(void) clickCataButton {
    HCatalogueViewController *vc = [[HCatalogueViewController alloc] init];
    vc.bookID = self.bookId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 字体放大功能的实现
-(void) clickAddFontButton {
    
    [TReaderManager saveFontSize:[TReaderManager fontSize]+1];
    self.dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.novelArray.count; i++) {
        _chapter.chapterContent = self.novelArray[i];
        [_chapter parseChapter];
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (int i = 0; i < _chapter.totalPage; i++) {
            TYAttributedLabel *label = [[TYAttributedLabel alloc] init];
            label.attributedText = [_chapter chapterPagerWithIndex:i].attString;
            [arr addObject:label.attributedText];
        }
        [self.dataArray addObject:arr];
    }
    
    [self.collectionView reloadData];
}

#pragma mark - 字体减小功能的实现
-(void) clickSubFontButton {
    [TReaderManager saveFontSize:[TReaderManager fontSize]-1];
    
    self.dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.novelArray.count; i++) {
        _chapter.chapterContent = self.novelArray[i];
        [_chapter parseChapter];
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (int i = 0; i < _chapter.totalPage; i++) {
            TYAttributedLabel *label = [[TYAttributedLabel alloc] init];
            label.attributedText = [_chapter chapterPagerWithIndex:i].attString;
            [arr addObject:label.attributedText];
        }
        [self.dataArray addObject:arr];
    }
    
    [self.collectionView reloadData];
}

#pragma mark - 进入评论列表页面
-(void) clickCommentButton {
    HComListViewController *vc = [[HComListViewController alloc] init];
    vc.bookID = self.bookId;
    vc.secID = self.secIDArray[self.SectionIndex];
    vc.SectionIndex = self.SectionIndex;
    vc.SectionName = self.titleLab.text;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 收藏小说功能的实现
-(void)clickCollectionButton {
    NSLog(@"收藏");
    if (kUserLogin == NO) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    [self.view showHudWithActivity:@"正在加载"];
    [self.help removeNovelWithFictionId:self.bookId UserId:kUserID success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [self.view hideHubWithActivity];
            if (_menuView.boomView.collectBtn.selected == NO) {
                [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                [_menuView.boomView.collectBtn setImage:[UIImage imageNamed:@"收藏_click"] forState:UIControlStateNormal];
                _menuView.boomView.collectBtn.selected = YES;
            }else{
                [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
                [_menuView.boomView.collectBtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
                _menuView.boomView.collectBtn.selected = NO;
            }
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [SVProgressHUD showSuccessWithStatus:@"失败"];
    }];
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
//    [self jiluNovelSectonList];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if (self.pushType ==1) {//从动态列表页面直接跳阅读页
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[HDynListViewController class]]) {
                [arr addObject:controller];
            }
        }
    }else if (self.pushType == 2){//从作者也跳阅读页
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[HAuthorsViewController class]]) {
                [arr addObject:controller];
            }
        }
    }else{// 从详情页跳入阅读页面
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[NovelDetailViewController class]]) {
                
                [arr addObject:controller];
            }
        }
    }
    [self.navigationController popToViewController:arr.lastObject animated:YES];
}


#pragma mark - 章节内容的获取
-(void) getNovelContentData{
    [self.view showHudWithActivity:@"正在加载"];
    NSString *userId = @"00000000-0000-0000-0000-000000000000";
    if (kUserLogin == YES) {
        userId = kUserID;
    }
    [self.helper getNovelContentWithSectionId:self.secID UserId:userId success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            self.novelArray = [[NSMutableArray alloc] init];
            MuLuListModel *model = [MuLuListModel mj_objectWithKeyValues:response];
            [self.novelArray addObject:model.Content];
            [self.sectionArray addObject:model.Title];
            self.titleLab.text = model.Title;
            self.preID = model.Pre;
            self.nextID = model.Next;
            self.sectionId = model.SectionId;
            
            [self getBookChapter:1 Model:model];
            [self.collectionView.mj_footer endRefreshing];
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
            if (model.IsCollect == 0) {
                [_menuView.boomView.collectBtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
                _menuView.boomView.collectBtn.selected = NO;
            }else{
                [_menuView.boomView.collectBtn setImage:[UIImage imageNamed:@"收藏_click"] forState:UIControlStateNormal];
                _menuView.boomView.collectBtn.selected = YES;
            }
            
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

#pragma mark - 上拉加载获取数据（加载下一章章节内容）
-(void) getNextNovelContent{
    if ([self.nextID isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
        [SVProgressHUD showErrorWithStatus:@"本章节已是最后一章"];
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
        return;
    }
    [self.view showHudWithActivity:@"正在加载"];
    NSString *userId = @"00000000-0000-0000-0000-000000000000";
    if (kUserLogin == YES) {
        userId = kUserID;
    }
    [self.helper getNovelContentWithSectionId:self.nextID UserId:userId success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            
            MuLuListModel *model = [MuLuListModel mj_objectWithKeyValues:response];
            [self.novelArray addObject:model.Content];
            [self.sectionArray addObject:model.Title];
            [self.secIDArray addObject:model.SectionId];
            self.nextID = model.Next;
            self.sectionId = model.SectionId;
            
            [self getBookChapter:1 Model:model];
            [self.collectionView.mj_footer endRefreshing];
            [self.collectionView.mj_header endRefreshing];
            
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
        [self.view showFailedViewReloadBlock:^{
            [self getNextNovelContent];
        }];
    }];
}

#pragma mark - 下拉加载获取数据（加载上一章章节内容）
-(void) getNovelContent{
    if ([self.preID isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
        [SVProgressHUD showErrorWithStatus:@"本章节第一章"];
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
        return;
    }
    [self.view showHudWithActivity:@"正在加载"];
    NSString *userId = @"00000000-0000-0000-0000-000000000000";
    if (kUserLogin == YES) {
        userId = kUserID;
    }
    [self.helper getNovelContentWithSectionId:self.preID UserId:userId success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];

            MuLuListModel *model = [MuLuListModel mj_objectWithKeyValues:response];
            [self.novelArray insertObject:model.Content atIndex:0];
            [self.sectionArray insertObject:model.Title atIndex:0];
            [self.secIDArray insertObject:model.SectionId atIndex:0];
            self.preID = model.Pre;
            self.sectionId = model.SectionId;
            
            [self getBookChapter:1 Model:model];
            [self.collectionView.mj_footer endRefreshing];
            [self.collectionView.mj_header endRefreshing];
            
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
        [self.view showFailedViewReloadBlock:^{
            [self getNovelContent];
        }];
    }];
}


#pragma mark - 获取章节
- (TReaderChapter *)getBookChapter:(NSInteger)chapterIndex Model:(MuLuListModel *)model
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
    return CGRectMake(15, 0, CGRectGetWidth(frame) - 20, CGRectGetHeight(frame));
}

- (CGSize)renderSizeWithFrame:(CGRect)frame
{
    return [self renderFrameWithFrame:frame].size;
}

- (TReaderChapter *)openBookWithChapter:(NSInteger)chapter Model:(MuLuListModel *)model
{
    TReaderChapter *readerChapter = [[TReaderChapter alloc]init];
    readerChapter.chapterIndex = chapter;
    NSError *error = nil;
    readerChapter.chapterTitle = model.Title;
    
    
    readerChapter.chapterContent = model.Content;
    
    if (error) {
        NSLog(@"open book chapter error:%@",error);
        return nil;
    }
    return readerChapter;
}


-(void) changecollectionCount:(NSInteger)count chapter:(TReaderChapter *)chapter {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if (_loadType != 1) {
        for (int i = 0; i < count; i++) {
            TYAttributedLabel *label = [[TYAttributedLabel alloc] init];
            label.attributedText = [chapter chapterPagerWithIndex:i].attString;
            [arr addObject:label.attributedText];
        }
        [self.dataArray addObject:arr];
         [self.collectionView reloadData];
    }else{// 下拉加载
        for (int i = 0; i < count; i++) {
            TYAttributedLabel *label = [[TYAttributedLabel alloc] init];
            label.attributedText = [chapter chapterPagerWithIndex:i].attString;
            [arr addObject:label.attributedText];
        }
        [self.dataArray insertObject:arr atIndex:0];
        [self.collectionView reloadData];
        
        int64_t delayInSeconds = 0;      // 延迟的时间
        /*
         *@parameter 1,时间参照，从此刻开始计时
         *@parameter 2,延时多久，此处为秒级，还有纳秒等。10ull * NSEC_PER_MSEC
         */
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // do something
            NSIndexPath *path=[NSIndexPath indexPathForItem:arr.count - 1 inSection:0];
            NSLog(@"%@",path);
            [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
        });
        
        
    }
    
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

//-(void)jiluNovelSectonList{
//    [self.helper RecordsNovelSectionWithFictionId:self.bookId SectionId:self.sectionId UserId:kUserID TextLength:@"0" success:^(NSDictionary *response) {
//        
//        NSLog(@"234567");
//        
//    } faild:^(NSString *response, NSError *error) {
//        
//    }];
//}


@end
