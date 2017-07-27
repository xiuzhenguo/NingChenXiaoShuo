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

@end
