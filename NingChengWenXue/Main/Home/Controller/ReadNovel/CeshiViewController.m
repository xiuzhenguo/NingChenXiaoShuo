//
//  CeshiViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/1.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CeshiViewController.h"
#import "TReaderTextController.h"
#import "TReaderBook.h"
#import "TReaderManager.h"
#import "TReaderMark.h"
#import "UIView+NIB.h"
#import "TYAttributedLabel.h"

#import "NCHomePageHelper.h"
#import "MuLuListModel.h"

@interface CeshiViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic, weak) UIPageViewController * pageViewController;

@property (nonatomic, strong) TReaderBook *readerBook;
@property (nonatomic, strong) TReaderChapter *chapter;
@property (nonatomic, assign) CGSize renderSize;    // 渲染大小
@property (nonatomic, assign) NSInteger curPage;    // 当前页数
@property (nonatomic, assign) NSInteger readOffset; // 当前页在本章节位移

@property (nonatomic, strong) NCHomePageHelper *helper;
@property (nonatomic, strong) NSMutableArray *sectionArray;//分区头数组(放标题)
@property (nonatomic, strong) NSMutableArray *secIDArray;
@property (nonatomic, strong) NSString *preID;// 上一章主键
@property (nonatomic, strong) NSString *nextID;//下一章主键
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CeshiViewController

-(NCHomePageHelper *)helper{
    if (!_helper) {
        _helper = [NCHomePageHelper helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [[NSMutableArray alloc] init];
    self.sectionArray = [[NSMutableArray alloc] init];
    self.secIDArray = [[NSMutableArray alloc] init];
    
    
    [self addPageViewController];
    
//    [self openBookWithChapterIndex:1];
    
//    [self showReaderPage:0];
    
    [self getNovelContentData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - add view
- (void)addPageViewController
{
    UIPageViewController *pageViewController = _style == TReaderTransitionStylePageCur ? [[UIPageViewController alloc]init] : [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:nil];
    pageViewController.delegate = self;
    pageViewController.dataSource = self;
    //    pageViewController.spineLocation = UIPageViewControllerSpineLocationNone;
    pageViewController.view.frame = self.view.bounds;
    
    [self addChildViewController:pageViewController];
    [self.view addSubview:pageViewController.view];
    _pageViewController = pageViewController;
    
    _renderSize = [TReaderTextController renderSizeWithFrame:pageViewController.view.frame];
    
}

//显示第几页数据
- (void)showReaderPage:(NSUInteger)page
{
    _curPage = page;
    TReaderTextController *readerController = [self readerControllerWithPage:page chapter:_chapter];
    [_pageViewController setViewControllers:@[readerController]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:nil];
}

- (TReaderTextController *)readerControllerWithPage:(NSUInteger)page chapter:(TReaderChapter *)chapter
{
    TReaderTextController *readerViewController = [[TReaderTextController alloc]init];
    [self confogureReaderController:readerViewController page:page chapter:chapter];
    return readerViewController;
}

- (void)confogureReaderController:(TReaderTextController *)readerViewController page:(NSUInteger)page chapter:(TReaderChapter *)chapter
{
    if (_style == TReaderTransitionStylePageCur) {
        _curPage = page;
    }
    readerViewController.readerChapter = chapter;
    readerViewController.readerPager = [chapter chapterPagerWithIndex:page];
//    readerViewController.ste = chapter[page];
    if (readerViewController.readerPager) {
        NSRange range = readerViewController.readerPager.pageRange;
        _readOffset = range.location+range.length/3;
    }
}

#pragma mark - Reader Setting
// 读取书籍数据
- (void)openBookWithChapterIndex:(NSInteger)chapterIndex
{
    if (!_readerBook) {
        _readerBook = [[TReaderBook alloc]init];
        // test data
        _readerBook.bookId = 123456;
        _readerBook.bookName = @"Chapter";
        _readerBook.totalChapter = 7;
    }
    
//    _chapter = [self getBookChapter:chapterIndex];
}

// 跳转到章节
- (void)turnToBookChapter:(NSInteger)chapterIndex
{
    [self openBookWithChapterIndex:chapterIndex];
    [self showReaderPage:0];
}

- (void)turnToBookChapter:(NSInteger)chapterIndex chapterOffset:(NSInteger)chapterOffset
{
//    _chapter = [self getBookChapter:chapterIndex];
    NSInteger pageIndex = [_chapter pageIndexWithChapterOffset:chapterOffset];
    [self showReaderPage:pageIndex];
}


- (TReaderChapter *)getBookPreChapter
{
    TReaderChapter *chapter = [_readerBook openBookPreChapter];
    [chapter parseChapterWithRenderSize:_renderSize];
    return chapter;
}

- (TReaderChapter *)getBookNextChapter
{
    TReaderChapter *chapter = [_readerBook openBookNextChapter];
    [chapter parseChapterWithRenderSize:_renderSize];
    return chapter;
}


#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSLog(@"go pre");
    
    TReaderTextController *curReaderVC = (TReaderTextController *)viewController;
    NSInteger currentPage = curReaderVC.readerPager.pageIndex;
    _curPage = currentPage;
    
    TReaderChapter *chapter = curReaderVC.readerChapter;
    
    if (_chapter != chapter) {
        _chapter = chapter;
        [_readerBook resetChapter:chapter];
    }
    
    TReaderTextController *readerVC = [[TReaderTextController alloc]init];
    if (currentPage > 0) {
        [self confogureReaderController:readerVC page:currentPage-1 chapter:chapter];
        NSLog(@"总页码%ld 11当前页码%ld",chapter.totalPage,_curPage+1);
        return readerVC;
    }else {
//        if ([_readerBook havePreChapter]) {
//            NSLog(@"--获取上一章");
//            TReaderChapter *preChapter = [self getBookPreChapter];
//            [self confogureReaderController:readerVC page:preChapter.totalPage-1 chapter:preChapter];
//            NSLog(@"总页码%ld 22当前页码%ld",chapter.totalPage,_curPage+1);
//            return readerVC;
//        }else {
            NSLog(@"已经是第一页了");
            [self.pageViewController removeFromParentViewController];
        
        self.loadType = 1;
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
                [self addPageViewController];
//                [self showReaderPage:_curPage+1];
                [self getBookChapter:1 Model:model];
//                [self confogureReaderController:readerVC page:_chapter.totalPage-1 chapter:chapter];
                
            });
            
            return ;
        } faild:^(NSString *response, NSError *error) {
            [self.view hideHubWithActivity];
            
        }];
        return readerVC;

        
//        }
    }
    return readerVC;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    NSLog(@"go after");
    
    TReaderTextController *curReaderVC = (TReaderTextController *)viewController;
    NSInteger currentPage = curReaderVC.readerPager.pageIndex;
    _curPage = currentPage;
    
    TReaderChapter *chapter = curReaderVC.readerChapter;
    
    if (_chapter != chapter) {
        _chapter = chapter;
        [_readerBook resetChapter:chapter];
    }
    
    TReaderTextController *readerVC = [[TReaderTextController alloc]init];
    if (currentPage < chapter.totalPage - 1) {
        [self confogureReaderController:readerVC page:currentPage+1 chapter:chapter];
        NSLog(@"总页码%ld 当前页码%ld",chapter.totalPage,_curPage+1);
        return readerVC;
    }else {
        
//        if ([_chapter.chapterContent isEqualToString:self.novelArray.lastObject]) {
//            NSLog(@"--获取下一章");
//            NSLog(@"%@",self.novelArray.lastObject);
            [self getNextNovelContent];
//            TReaderChapter *nextChapter = [self getBookNextChapter];
//            [self confogureReaderController:readerVC page:0 chapter:nextChapter];
//            NSLog(@"总页码%ld 当前页码%ld",chapter.totalPage,_curPage+1);
            return  readerVC;
//        }else {
//            NSLog(@"已经是最后一页了");
//           
//            return nil;
//        }
        
        
        
    }
    return readerVC;
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
            
            self.preID = model.Pre;
            self.nextID = model.Next;
            
            
            [self getBookChapter:1 Model:model];
            
            
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
//        [self.collectionView.mj_footer endRefreshing];
//        [self.collectionView.mj_header endRefreshing];
//        [self.collectionView showFailedViewReloadBlock:^{
//            [self getNovelContentData];
//        }];
    }];
}

#pragma mark - 上拉加载获取数据（加载下一章章节内容）
-(void) getNextNovelContent{
    if ([self.nextID isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
        [SVProgressHUD showErrorWithStatus:@"本章节已是最后一章"];
//        [self.collectionView.mj_footer endRefreshing];
//        [self.collectionView.mj_header endRefreshing];
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
           
            
            [self getBookChapter:1 Model:model];
//            [self.collectionView.mj_footer endRefreshing];
//            [self.collectionView.mj_header endRefreshing];
            
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
//        [self.collectionView.mj_footer endRefreshing];
//        [self.collectionView.mj_header endRefreshing];
//        [self.view showFailedViewReloadBlock:^{
//            [self getNextNovelContent];
//        }];
    }];
}

#pragma mark - 下拉加载获取数据（加载上一章章节内容）
-(void) getNovelContent{
    if ([self.preID isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
        [SVProgressHUD showErrorWithStatus:@"本章节第一章"];
//        [self.collectionView.mj_footer endRefreshing];
//        [self.collectionView.mj_header endRefreshing];
        return;
    }
    self.loadType = 1;
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
            
            [self getBookChapter:1 Model:model];
//            [self.collectionView.mj_footer endRefreshing];
//            [self.collectionView.mj_header endRefreshing];
            
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
//        [self.collectionView.mj_footer endRefreshing];
//        [self.collectionView.mj_header endRefreshing];
//        [self.view showFailedViewReloadBlock:^{
//            [self getNovelContent];
//        }];
    }];
}


#pragma mark - 获取章节
- (TReaderChapter *)getBookChapter:(NSInteger)chapterIndex Model:(MuLuListModel *)model
{
    
    TReaderChapter *chapter = [self openBookWithChapter:chapterIndex Model:model];
    
    [chapter parseChapterWithRenderSize:_renderSize];
    [self changecollectionCount:chapter.totalPage chapter:chapter];
    _chapter = chapter;
    return chapter;
}

- (CGRect)renderFrameWithFrame:(CGRect)frame
{
    return CGRectMake(15, 0, CGRectGetWidth(frame)-30, CGRectGetHeight(frame));
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
    self.muArray = [[NSMutableArray alloc] init];
    _chapter = chapter;
    if (_loadType != 1) {
//        for (int i = 0; i < count; i++) {
//            TYAttributedLabel *label = [[TYAttributedLabel alloc] init];
//            label.attributedText = [chapter chapterPagerWithIndex:i].attString;
//            [self.muArray addObject:label.attributedText];
//        }
//        [self.dataArray addObject:self.muArray];
        [self showReaderPage:0];
//        [self.collectionView reloadData];
    }else{// 下拉加载
        for (int i = 0; i < count; i++) {
            TYAttributedLabel *label = [[TYAttributedLabel alloc] init];
            label.attributedText = [chapter chapterPagerWithIndex:i].attString;
            [self.muArray addObject:label.attributedText];
        }
//        [self.dataArray insertObject:self.muArray atIndex:0];
        [self showReaderPage:count-1];
        
        
    }
    
}


@end
