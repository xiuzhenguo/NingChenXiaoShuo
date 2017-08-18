//
//  LoginViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/14.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "LoginViewController.h"
#import "PhoneLoginView.h"
#import "BXTabBar.h"
#import "AccountLoginView.h"
#import "ForgetViewController.h"
#import "RigestViewController.h"
#import "BCWelcomHepler.h"
#import "HelperUtil.h"

@interface LoginViewController ()<UINavigationControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, strong) UIImageView *headerImg;
@property (nonatomic, strong) PhoneLoginView *phoneView;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *rigestBtn;
@property (nonatomic, strong) UIButton *forgettn;
@property (nonatomic, strong) AccountLoginView *accountLoginView;
@property (strong, nonatomic) BCWelcomHepler *helper;
@property (copy, nonatomic) ETTimerHandle processHanle;
@property (copy, nonatomic) ETTimerHandle finishHanle;

@end

@implementation LoginViewController

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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.navigationController.delegate = self;
    // 添加scrollView视图
    [self addScrollView];
   
    // 添加登录按钮
    [self setLoginOrRigestButton];
    
}

#pragma - mark 创建底部视图
- (void) addScrollView {
    
    self.scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
//    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.contentSize = CGSizeMake(BXScreenW, BXScreenH);
    [self.view addSubview:self.scrollView];
    
    _accountLoginView = [[AccountLoginView alloc] initWithFrame:CGRectMake(0, 390/2 , BXScreenW, 106)];
    [self.scrollView addSubview:_accountLoginView];
    
    _phoneView = [[PhoneLoginView alloc] initWithFrame:CGRectMake(0, 390/2 , BXScreenW, 106)];
    _phoneView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:_phoneView];
    [_phoneView.getCode addTarget:self action:@selector(clickCodeButton) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加顶部视图
    [self addHeaderImageView];
    
    // 添加三方登录按钮
//    _threeLoginView = [[ThreeLoginView alloc] initWithFrame:CGRectMake(0, 537, BXScreenW, 80)];
//    _threeLoginView.backgroundColor = [UIColor whiteColor];
//    [self.scrollView addSubview:_threeLoginView];
}

#pragma mark - 添加顶部视图
-(void) addHeaderImageView {
 
    self.headerImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 390/2)];
    self.headerImg.backgroundColor = [UIColor whiteColor];
    self.headerImg.image = [UIImage imageNamed:@"1"];
    self.headerImg.userInteractionEnabled = YES;
    [self.scrollView addSubview: self.headerImg];
    self.headerImg.userInteractionEnabled = YES;
    
    // 添加关闭按钮
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 45, 15, 30, 30)];
    [backBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [self.headerImg addSubview:backBtn];
    [backBtn addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加登录方式按钮
    // 手机登录
    UIButton *phoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 140, BXScreenW/2 - 60, 35)];
    [phoneBtn setTitle:@"手机登录" forState:UIControlStateNormal];
    phoneBtn.titleLabel.font = [UIFont systemFontOfSize:23];
    [self.headerImg addSubview:phoneBtn];
    // button标题居左显示
    phoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    phoneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [phoneBtn addTarget:self action:@selector(clickPhoneBtn) forControlEvents:UIControlEventTouchUpInside];
    
    // 账号登录
    UIButton *accountBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW/2, 140, BXScreenW/2 - 60, 35)];
    [accountBtn setTitle:@"账号登录" forState:UIControlStateNormal];
    accountBtn.titleLabel.font = [UIFont systemFontOfSize:23];
    [self.headerImg addSubview:accountBtn];
    // button标题居左显示
    accountBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    accountBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [accountBtn addTarget:self action:@selector(clickAccountBtn) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 登录、注册、忘记密码按钮
-(void) setLoginOrRigestButton {
    //登录按钮
    self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 390/2 + 106 + 38, BXScreenW - 80, 50)];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = BXColor(236, 105, 65);
    self.loginBtn.layer.cornerRadius = 10;
    [self.loginBtn addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.loginBtn];
    // 注册按钮
    self.rigestBtn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW/2 - 60, 417, 120, 14)];
    [self.rigestBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    self.rigestBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.rigestBtn setTitleColor:BXColor(152, 152, 152) forState:UIControlStateNormal];
    [self.scrollView addSubview:self.rigestBtn];
    [self.rigestBtn addTarget:self action:@selector(clickRigestButton) forControlEvents:UIControlEventTouchUpInside];
    // 忘记密码按钮
    self.forgettn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW/2 - 60, 449, 120, 14)];
    [self.forgettn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgettn setTitleColor:BXColor(152, 152, 152) forState:UIControlStateNormal];
    self.forgettn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.scrollView addSubview:self.forgettn];
    [self.forgettn addTarget:self action:@selector(clickForgetPassWordBtn) forControlEvents:UIControlEventTouchUpInside];
    self.forgettn.hidden = YES;
    
//    // 画前直线
//    UIView *frontOrLine = [[UIView alloc] initWithFrame:CGRectMake(50, 508, BXScreenW/2 - 65, 1)];
//    frontOrLine.backgroundColor = BXColor(152, 152, 152);
//    [self.scrollView addSubview:frontOrLine];
//    // 画后直线
//    UIView *behindOrLine = [[UIView alloc] initWithFrame:CGRectMake(BXScreenW/2 + 15, 508, BXScreenW/2 - 65, 1)];
//    behindOrLine.backgroundColor = BXColor(152, 152, 152);
//    [self.scrollView addSubview:behindOrLine];
//    
//    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(BXScreenW/2 - 15, 501, 30, 14)];
//    lable.text = @"或";
//    lable.textColor = BXColor(152, 152, 152);
//    lable.font = [UIFont systemFontOfSize:16];
//    [self.scrollView addSubview:lable];
//    lable.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - 点击手机登录按钮方法
-(void)clickPhoneBtn {
    self.headerImg.image = [UIImage imageNamed:@"1"];
    _phoneView.hidden = NO;
    _accountLoginView.hidden = NO;
    self.forgettn.hidden = YES;
}

#pragma mark - 点击账号登录按钮方法
-(void)clickAccountBtn {
    self.headerImg.image = [UIImage imageNamed:@"2"];
    _phoneView.hidden = YES;
    _accountLoginView.hidden = NO;
    self.forgettn.hidden = NO;
}

#pragma mark - 登录按钮的点击事件
-(void) clickLoginButton {
    if (!_phoneView.hidden) {
        
        [self phoneNumLoginType];
        
    }else{
        [self ZHangHaoLoginType];
        NSLog(@"111111111账号登录");
    }
}

#pragma mark - 获取验证码
-(void) clickCodeButton {
    
    if (_phoneView.phoneNum.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    
    if ([HelperUtil checkTelNumber:self.phoneView.phoneNum.text]) {
        
        [self configureTimeInterval];
        [[ETTimeManager sharedETTimeManager] beginTimeTaskWithOwner:self Key:Get_ID_Key timeInterval:60 process:self.processHanle finish:self.finishHanle];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的电话号码" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
}

#pragma mark - 验证码发送获取
-(void) configureTimeInterval {
    WEAKSELF
    [weakSelf.helper sendMobileCodeWithPhone:_phoneView.phoneNum.text success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [SVProgressHUD showSuccessWithStatus:@"验证码已发送，请注意查收"];
            self.processHanle = ^(NSInteger timeInterVal){
                st_dispatch_async_main(^{
                    [weakSelf.phoneView.getCode setTitleColor:BXColor(152, 152, 152) forState:UIControlStateNormal];
                    NSString *buttonTitle = [NSString stringWithFormat:@"获取验证码(%ld)",(long)timeInterVal];
                    [weakSelf.phoneView.getCode setTitle:buttonTitle forState:UIControlStateNormal];
                    weakSelf.phoneView.getCode.userInteractionEnabled = false;
                });
            };
            self.finishHanle = ^(NSInteger timeInterVal){
                //        weakSelf.getCode  = BXColor(152, 152, 152);
                [weakSelf.phoneView.getCode setTitleColor:BXColor(251, 80, 0) forState:UIControlStateNormal];
                [weakSelf.phoneView.getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
                weakSelf.phoneView.getCode.userInteractionEnabled = true;
            };
            ETTimeTask *task = [ETTimeManager sharedETTimeManager].taskDic[Get_ID_Key];
            if (task) {
                [task setTaskWithOwner:self process:self.processHanle finish:self.finishHanle];
            }
        });
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"失败"];
    }];
    
    
}


#pragma mark - 手机号登录
-(void) phoneNumLoginType {
    WEAKSELF
    [weakSelf.helper loginWithPhoneNumber:self.phoneView.phoneNum.text Code:self.phoneView.codeField.text success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:response];
            if (model.StatusCode == 200) {
                
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                [[NSUserDefaults standardUserDefaults]setObject:model.datas forKey:KServiceAccount];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kLoginStateKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [SVProgressHUD showSuccessWithStatus:model.Message];
            }
        });
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"失败"];
    }];
}

#pragma mark - 账号登录
-(void) ZHangHaoLoginType {
    WEAKSELF
    [weakSelf.helper loginWithAccount:_accountLoginView.accountNum.text Password:_accountLoginView.passwordField.text success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:response];
            if (model.StatusCode == 200) {
                
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                [[NSUserDefaults standardUserDefaults]setObject:model.datas forKey:KServiceAccount];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kLoginStateKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [SVProgressHUD showSuccessWithStatus:model.Message];
            }
        });
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"失败"];
    }];
    
}

#pragma mark - 点击关闭按钮返回
-(void) clickBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 注册账号
- (void) clickRigestButton {
    RigestViewController *vc = [[RigestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 忘记密码
-(void) clickForgetPassWordBtn {
    ForgetViewController *vc = [[ForgetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

#pragma mark - UINavigationControllerDelegate(隐藏导航栏)
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

@end
