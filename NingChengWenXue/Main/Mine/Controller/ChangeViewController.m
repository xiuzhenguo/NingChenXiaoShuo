//
//  ChangeViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/10/13.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ChangeViewController.h"
#import "BCWelcomHepler.h"

@interface ChangeViewController ()

@property (strong, nonatomic) BCWelcomHepler *helper;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation ChangeViewController

-(BCWelcomHepler *)helper{
    if (!_helper) {
        _helper = [BCWelcomHepler helper];
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
    self.view.backgroundColor = BXColor(242, 242, 242);
    [self setUpNavButtonUI];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, BXScreenW, 44)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, BXScreenW-15, 44)];
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.text = self.textStr;
    self.textField.textColor = BXColor(152,152,152);
    self.textField.font = FIFFont;
    self.textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [backView addSubview:self.textField];
    
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
    if (self.row == 1) {
        [self changeMineSign];
    }else if (self.row == 2){
        [self changeMineName];
    }else{
        [self changeMineBorthday];
    }
}

#pragma mark - 修改个性签名
-(void)changeMineSign{
    [self.view showHudWithActivity:@""];
    NSString *userID = @"";
    if (self.type == 1) {
        userID = self.userid;
    }else{
        userID = kUserID;
    }
    [self.helper changeMineSignWithUserId:userID UserSign:self.textField.text success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            [self.view hideHubWithActivity];
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [self.delegate changeMineInformationDelegate:self.row Content:self.textField.text];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [SVProgressHUD showErrorWithStatus:@"失败"];
    }];
}

#pragma mark - 修改昵称
-(void)changeMineName{
    [self.view showHudWithActivity:@""];
    NSString *userID = @"";
    if (self.type == 1) {
        userID = self.userid;
    }else{
        userID = kUserID;
    }
    [self.helper changeMineNameWithUserId:userID UserName:self.textField.text success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            [self.view hideHubWithActivity];
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [self.delegate changeMineInformationDelegate:self.row Content:self.textField.text];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [SVProgressHUD showErrorWithStatus:@"失败"];
    }];
}

#pragma mark - 修改出生日期
-(void)changeMineBorthday{
    [self.view showHudWithActivity:@""];
    NSString *userID = @"";
    if (self.type == 1) {
        userID = self.userid;
    }else{
        userID = kUserID;
    }
    [self.helper changeMineBirthdayWithUserId:userID UserBirthday:self.textField.text success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            [self.view hideHubWithActivity];
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [self.delegate changeMineInformationDelegate:self.row Content:self.textField.text];
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
