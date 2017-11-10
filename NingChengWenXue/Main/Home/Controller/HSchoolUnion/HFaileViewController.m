//
//  HFaileViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HFaileViewController.h"
#import "NCHomePageHelper.h"

@interface HFaileViewController ()

@property (nonatomic, strong) UILabel *conLab;
@property (strong, nonatomic) NCHomePageHelper *helper;

@end

@implementation HFaileViewController

-(NCHomePageHelper *)helper{
    if (!_helper) {
        _helper = [NCHomePageHelper helper];
    }
    return _helper;
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
    self.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUILableUI];
    
    [self getFaileReasonData];
    
    [self setUpNavButtonUI];
}

#pragma mark - 创建视图
-(void) createUILableUI {
    self.conLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, BXScreenW - 30, BXScreenH - 64)];
    self.conLab.textColor = BXColor(101,101,101);
    self.conLab.font = FIFFont;
    [self.view addSubview:self.conLab];
}

-(void) getFaileReasonData {
    [self.helper createCmomunityFaildWithID:kUserID success:^(NSDictionary *response) {
        
        st_dispatch_async_main(^{
           
            ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:response];
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
        
            self.conLab.text = model.datas;
            self.conLab.numberOfLines = 0;
            [self.conLab sizeToFit];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        
        [self.view showFailedViewReloadBlock:^{
            [self getFaileReasonData];
        }];
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
    
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.delegate SchoolUnionFaildReason];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
