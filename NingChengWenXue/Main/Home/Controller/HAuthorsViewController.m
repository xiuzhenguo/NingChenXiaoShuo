//
//  HAuthorsViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/21.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAuthorsViewController.h"
#import "HWorksViewController.h"
#import "HDynamicViewController.h"
#import "HAutherHeadView.h"
#import "HAutCardViewController.h"
#import "HAutMedalViewController.h"
#import "HAutDataViewController.h"
#import "HAutPerViewController.h"
#import "HAutAttViewController.h"
#import "HAutWordViewController.h"
#import "NCHomePageHelper.h"
#import "WriterDetailModel.h"

@interface HAuthorsViewController ()<YPTabBarDelegate>

@property (nonatomic, strong) UIImageView *headImgView;
@property (nonatomic, strong) HAutherHeadView *hautherView;
@property (strong, nonatomic) NCHomePageHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *readBtn;
@property (nonatomic, strong) UILabel *gzlable;
@property (nonatomic, strong) HWorksViewController *controller1;
@property (nonatomic, strong) HDynamicViewController *controller2;

@end

@implementation HAuthorsViewController

-(NCHomePageHelper *)helper{
    if (!_helper) {
        _helper = [NCHomePageHelper helper];
    }
    return _helper;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = true;//不设置为黑色背景
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BXColor(195, 195, 195);
    
    
    // 设置返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 100, 30);
    [leftBtn setImage:[UIImage imageNamed:@"返回-1"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = item;
    
    [self setUpHeadImageViewUI];
    [self setUpButtonUI];
    [self setUpTypeViewUI];
    [self setUpFollowButton];
    [self getAutherDetailData];
}

#pragma mark - 添加头部视图
-(void) setUpHeadImageViewUI {
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 200)];
    self.headImgView.image = [UIImage imageNamed:@"bg"];
    self.headImgView.userInteractionEnabled = YES;
    [self.view addSubview:self.headImgView];
    
    _hautherView = [[HAutherHeadView alloc] initWithFrame:CGRectMake(0, 64, BXScreenW, 136)];
    _hautherView.backgroundColor = [UIColor clearColor];
    [self.headImgView addSubview:_hautherView];
    
    [_hautherView.cardBtn addTarget:self action:@selector(clickCardButton) forControlEvents:UIControlEventTouchUpInside];
    
    [_hautherView.medalBtn addTarget:self action:@selector(cicckMedalButton) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 添加头部的粉丝、关注等四个按钮
- (void) setUpButtonUI {
    WriterDetailModel *model = self.dataArray.firstObject;
    NSArray *array = @[@"粉丝",@"关注",@"留言",@"资料"];
    NSArray *numArray = @[[NSString stringWithFormat:@"%ld",model.FansCount],[NSString stringWithFormat:@"%ld",model.AttentionCount],[NSString stringWithFormat:@"%ld",model.LeaveCount],@"个人"];
    for (int i = 0; i<4; i++) {
        UIButton *backView = [[UIButton alloc] initWithFrame:CGRectMake((BXScreenW/4.0)*i, CGRectGetMaxY(_hautherView.frame), (BXScreenW/4.0), 40)];
        backView.backgroundColor = [UIColor whiteColor];
        [backView addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
        backView.tag = 1000 + i;
        [self.view addSubview:backView];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 5.5, (BXScreenW/4.0), 15)];
        lable.text = numArray[i];
        if (i != 3) {
            lable.font = [UIFont boldSystemFontOfSize:13];
        }else{
            lable.font = THIRDFont;
        }
        lable.textColor = BXColor(35, 35, 35);
        lable.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:lable];
        if (i == 0) {
            self.gzlable = lable;
        }
        
        UILabel *numlab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20.5, BXScreenW/4.0, 15)];
        numlab.text = array[i];
        numlab.font = THIRDFont;
        numlab.textAlignment = NSTextAlignmentCenter;
        numlab.textColor = BXColor(152, 152, 152);
        [backView addSubview:numlab];
        
        
    }
    
    for (int i = 0; i < 3; i++) {
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake((BXScreenW/4.0)*(i+1), CGRectGetMaxY(_hautherView.frame)+10, 1, 20)];
        lineLab.backgroundColor = BXColor(195, 195, 195);
        [self.view addSubview:lineLab];
    }
    
}


#pragma mark - 卡片按钮的点击事件
-(void) clickCardButton {
    
    HAutCardViewController *vc = [[HAutCardViewController alloc] init];
    vc.authorID = self.autherID;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 勋章按钮的点击事件
-(void) cicckMedalButton {
    HAutMedalViewController *vc = [[HAutMedalViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 粉丝、关注等按钮的点击事件
-(void) clickBackButton:(UIButton *)sender {
    if (sender.tag == 1000) {
        HAutPerViewController *vc = [[HAutPerViewController alloc] init];
        vc.autherId = self.autherID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1001) {
        HAutAttViewController *vc = [[HAutAttViewController alloc] init];
        vc.autherId = self.autherID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1002) {
        HAutWordViewController *vc = [[HAutWordViewController alloc] init];
        vc.authorId = self.autherID;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        HAutDataViewController *vc = [[HAutDataViewController alloc] init];
        vc.autherId = self.autherID;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 创建分类栏
-(void) setUpTypeViewUI {
    // 创建分类栏
    [self setTabBarFrame:CGRectMake(0, 250, BXScreenW, 44)
        contentViewFrame:CGRectMake(0, 294, BXScreenW, BXScreenH - 44)];
    
    self.tabBar.itemTitleColor = BXColor(35,35,35);
    self.tabBar.itemTitleSelectedColor = BXColor(236,105,65);
    self.tabBar.itemTitleFont = [UIFont boldSystemFontOfSize:15];
    [self.tabBar setScrollEnabledAndItemWidth:kScreenWidth/2];
    self.tabBar.itemFontChangeFollowContentScroll = YES;
    self.tabBar.itemSelectedBgScrollFollowContent = YES;
    self.tabBar.itemSelectedBgColor = BXColor(236,105,65);
    [self.tabBar setItemSelectedBgInsets:UIEdgeInsetsMake(42, 0, 0, 0) tapSwitchAnimated:NO];
    [self setContentScrollEnabledAndTapSwitchAnimated:YES];
    
    [self initViewControllers];
}



#pragma mark - 添加动态和作品的Controller
- (void)initViewControllers {
    WriterDetailModel *model = self.dataArray.firstObject;
    self.controller1 = [[HWorksViewController alloc] init];
    
    self.controller2 = [[HDynamicViewController alloc] init];
    
    self.controller1.yp_tabItemTitle = [NSString stringWithFormat:@"作品(%ld)",model.FictionCount];
    self.controller2.yp_tabItemTitle = [NSString stringWithFormat:@"动态(%ld)",model.FirendCount];
    self.controller1.aurhorID = self.autherID;
    self.controller2.autherId = self.autherID;
    
    self.viewControllers = [NSMutableArray arrayWithObjects:self.controller1, self.controller2, nil];
    
}

#pragma mark - 创建底部的两个按钮
-(void) setUpFollowButton {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, BXScreenH - 49, BXScreenW, 49)];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    
    self.readBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW/3.0, 0, BXScreenW/3.0, 49)];
    [self.readBtn setTitle:@"立即关注" forState:UIControlStateNormal];
    self.readBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.readBtn.backgroundColor = BXColor(236, 105, 65);
    [self.readBtn addTarget:self action:@selector(clickGuanZhuButton:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:self.readBtn];
    
    // 创建自定义按钮
    UIButton *btn_click = [UIButton buttonWithType:UIButtonTypeCustom];
    // 创建普通状态按钮图片
    [btn_click setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    // 设置按钮普通状态标题
    [btn_click setTitle:@"给他留言" forState:UIControlStateNormal];
    [btn_click setTitleColor:BXColor(101, 101, 101) forState:UIControlStateNormal];
    // 按钮坐标和尺寸
    btn_click.frame = CGRectMake((BXScreenW/3.0)*2, 0, BXScreenW/3.0, 49);
    btn_click.titleLabel.font = THIRDFont;
    // 按钮图片和标题总高度
    CGFloat totalHeight = (btn_click.imageView.frame.size.height + btn_click.titleLabel.frame.size.height);
    // 设置按钮图片偏移
    [btn_click setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - btn_click.imageView.frame.size.height), 0.0, 0.0, -btn_click.titleLabel.frame.size.width)];
    // 设置按钮标题偏移
    [btn_click setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -btn_click.imageView.frame.size.width, -(totalHeight - btn_click.titleLabel.frame.size.height),0.0)];
    // 加载按钮到视图
//    [footView addSubview:btn_click];
}

#pragma mark - 返回按钮点击事件
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 作者详情的获取
-(void) getAutherDetailData {
    NSString *userId = @"00000000-0000-0000-0000-000000000000";
    if (kUserLogin == YES) {
        userId = kUserID;
    }
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper autherDetailWithID:self.autherID UserId:userId PageIndex:@"1" success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            self.dataArray = [[NSMutableArray alloc] init];
            
            WriterDetailModel *model = [WriterDetailModel mj_objectWithKeyValues:response];
            
            [self.dataArray addObject:model];
            
            _hautherView.model = model;
            
            [self setUpButtonUI];
            
            if (model.IsFirend == 0) {
                [self.readBtn setTitle:@"立即关注" forState:UIControlStateNormal];
            }else{
                [self.readBtn setTitle:@"已关注" forState:UIControlStateNormal];
            }
            [self initViewControllers];
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        
        [self.view showFailedViewReloadBlock:^{
            [self getAutherDetailData];
        }];
    }];
}

#pragma mark - 关注按钮的点击事件
-(void)clickGuanZhuButton:(UIButton *)sender{
    WriterDetailModel *model = self.dataArray.firstObject;
    if (kUserLogin == NO) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }else{
        [self.helper attentionUserWithUserId:kUserID AppentionId:self.autherID success:^(NSDictionary *response) {
            st_dispatch_async_main(^{
                [self.view hideHubWithActivity];
                ETHttpModel *mode = [ETHttpModel mj_objectWithKeyValues:response];
                [SVProgressHUD showSuccessWithStatus:mode.datas];
                if (model.IsFirend == 0) {
                    model.IsFirend = 1;
                    [self.readBtn setTitle:@"已关注" forState:UIControlStateNormal];
                    self.gzlable.text = [NSString stringWithFormat:@"%ld",[self.gzlable.text integerValue]+1];
                }else{
                    model.IsFirend = 0;
                    [self.readBtn setTitle:@"立即关注" forState:UIControlStateNormal];
                    self.gzlable.text = [NSString stringWithFormat:@"%ld",[self.gzlable.text integerValue]-1];
                }
            });
            
            return ;
        } faild:^(NSString *response, NSError *error) {
            [self.view hideHubWithActivity];
            [SVProgressHUD showSuccessWithStatus:@"失败"];
        }];
    }
}

@end
