//
//  PreviewSecViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/8/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "PreviewSecViewController.h"
#import "NCWriteHelper.h"

@interface PreviewSecViewController ()

@property (nonatomic, strong) NCWriteHelper *helper;

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
}

#pragma mark - 获取章节内容
-(void)getNovelSectionDetailData{
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper PreviewNovelSectionWithSectionid:self.sectionID success:^(NSDictionary *response) {

        st_dispatch_async_main(^{
//            [self.view hideHubWithActivity];
//            [self.view hidEmptyDataView];
//            [self.view hidFailedView];
//            model.FictionName = self.tectfield.text;
//            [SVProgressHUD showSuccessWithStatus:@"更改成功"];
//            [self.tableView reloadData];
        });
        
        return ;
        
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
    }];
}

@end
