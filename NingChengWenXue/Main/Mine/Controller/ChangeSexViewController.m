//
//  ChangeSexViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/10/13.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ChangeSexViewController.h"
#import "BCWelcomHepler.h"

@interface ChangeSexViewController ()

@property (nonatomic, strong) UIButton *boyButton;
@property (nonatomic, strong) UIButton *girlButton;
@property (nonatomic, strong) UIImageView *boyImage;
@property (nonatomic, strong) UIImageView *girlImage;
@property (nonatomic, strong) UILabel *boyLab;
@property (nonatomic, strong) UILabel *girlLab;
@property (strong, nonatomic) BCWelcomHepler *helper;

@end

@implementation ChangeSexViewController

-(BCWelcomHepler *)helper{
    if (!_helper) {
        _helper = [BCWelcomHepler helper];
    }
    return _helper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BXColor(242, 242, 242);
    self.title = @"性别";
    
    self.boyButton = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW/2.0 - 66.5, 75, 133, 173)];
    [self.view addSubview:self.boyButton];
    [self.boyButton addTarget:self action:@selector(clickBoyButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self setUpBoyButtonUI];
    
    self.girlButton = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW/2.0 - 66.5, 300, 133, 173)];
    [self.view addSubview:self.girlButton];
    [self.girlButton addTarget:self action:@selector(clickGirlButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self setUpGirlButtonUI];
    
    [self setUpNavButtonUI];
    
}

-(void)setUpBoyButtonUI{
    self.boyImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 133, 133)];
    self.boyImage.image = [UIImage imageNamed:@"性别__男"];
    [self.boyButton addSubview:self.boyImage];
    
    self.boyLab = [[UILabel alloc] initWithFrame:CGRectMake(self.boyButton.frame.size.width/2.0 - 47.5, 133+15, 95, 25)];
    self.boyLab.font = SIXFont;
    self.boyLab.backgroundColor = BXColor(199,199,199);
    self.boyLab.text = @"我是男生";
    self.boyLab.textAlignment = NSTextAlignmentCenter;
    self.boyLab.textColor = [UIColor whiteColor];
    self.boyLab.layer.cornerRadius = 10;
    self.boyLab.clipsToBounds = YES;
    [self.boyButton addSubview:self.boyLab];
}

-(void)setUpGirlButtonUI{
    self.girlImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 133, 133)];
    self.girlImage.image = [UIImage imageNamed:@"性别__女"];
    [self.girlButton addSubview:self.girlImage];
    
    self.girlLab = [[UILabel alloc] initWithFrame:CGRectMake(self.girlButton.frame.size.width/2.0 - 47.5, 133+15, 95, 25)];
    self.girlLab.font = SIXFont;
    self.girlLab.backgroundColor = BXColor(199,199,199);
    self.girlLab.text = @"我是女生";
    self.girlLab.textAlignment = NSTextAlignmentCenter;
    self.girlLab.textColor = [UIColor whiteColor];
    self.girlLab.layer.cornerRadius = 10;
    self.girlLab.clipsToBounds = YES;
    [self.girlButton addSubview:self.girlLab];
}

#pragma mark - 选择男生按钮的点击事件
-(void)clickBoyButton{
    self.boyButton.selected = YES;
    self.boyImage.image = [UIImage imageNamed:@"性别_男_选中"];
    self.boyLab.backgroundColor = BXColor(0,160,233);
    self.girlButton.selected = NO;
    self.girlImage.image = [UIImage imageNamed:@"性别__女"];
    self.girlLab.backgroundColor = BXColor(199,199,199);
}

#pragma mark - 选择女生按钮的点击事件
-(void)clickGirlButton{
    self.boyButton.selected = NO;
    self.boyImage.image = [UIImage imageNamed:@"性别__男"];
    self.boyLab.backgroundColor = BXColor(199,199,199);
    self.girlButton.selected = YES;
    self.girlImage.image = [UIImage imageNamed:@"性别__女_选中"];
    self.girlLab.backgroundColor = BXColor(234,104,162);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 30);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark - 右侧确定按钮的点击事件
-(void) clickRightButton {
    if (self.boyButton.selected == NO && self.girlButton.selected == NO) {
        [SVProgressHUD showSuccessWithStatus:@"请选择性别"];
        return;
    }
    NSString *sex = @"";
    if (self.boyButton.selected == YES) {
        sex = @"1";
    }else{
        sex = @"3";
    }
    NSString *userID = @"";
    if (self.type == 1) {
        userID = self.userid;
    }else{
        userID = kUserID;
    }
    [self.helper changeMineSexWithUserId:userID UserSex:sex success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            [self.view hideHubWithActivity];
            [SVProgressHUD showSuccessWithStatus:@"成功"];
            [self.delegate changeMineSexDelegate:sex];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [SVProgressHUD showErrorWithStatus:@"失败"];
    }];
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
