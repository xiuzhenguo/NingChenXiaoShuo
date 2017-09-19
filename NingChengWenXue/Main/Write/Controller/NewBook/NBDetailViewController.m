//
//  NBDetailViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/18.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBDetailViewController.h"
#import "NCWriteHelper.h"

@interface NBDetailViewController ()

@property (strong, nonatomic) NCWriteHelper *helper;
@property (nonatomic, strong) UILabel *contentLab;

@end

@implementation NBDetailViewController

-(NCWriteHelper *)helper{
    if (!_helper) {
        _helper = [NCWriteHelper helper];
    }
    return _helper;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;//不设置为黑色背景
    UIImage *colorImage = [NavLineImage imageWithColor:[UIColor clearColor] size:CGSizeMake(BXScreenW, 0.5)];
    [self.navigationController.navigationBar setBackgroundImage:colorImage forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[NavLineImage imageWithColor:BXColor(195, 195, 195) size:CGSizeMake(BXScreenW, 0.5)]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"详情";
    
    [self setUpNavButtonUI];
    
    [self setUpUILableUI];
    
    [self getApplyFaileReasonData];
}

#pragma mark - 创建显示UILabe
-(void) setUpUILableUI {
    self.contentLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, BXScreenW - 30, BXScreenH - 30)];
    self.contentLab.font = THIRDFont;
    self.contentLab.textColor = BXColor(40, 40, 40);
    [self.view addSubview:self.contentLab];
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
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 申请失败原因的获取
-(void)getApplyFaileReasonData {
    
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper faileApplySignNovelWithFictionId:self.bookID success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:response];
            if (model.StatusCode == 200) {
                self.contentLab.text = model.datas;
                self.contentLab.numberOfLines = 0;
                [self.contentLab sizeToFit];
            }else{
                
                [SVProgressHUD showErrorWithStatus:model.Message];
            }
            
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.view showFailedViewReloadBlock:^{
            [self getApplyFaileReasonData];
        }];
    }];
}

@end
