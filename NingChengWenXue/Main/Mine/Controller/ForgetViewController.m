//
//  ForgetViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/15.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ForgetViewController.h"
#import "BXTabBar.h"
#import "ETTimeManager.h"
#import "BCWelcomHepler.h"
#import "HelperUtil.h"

@interface ForgetViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) TPKeyboardAvoidingScrollView *rootScrollView;
@property (nonatomic, strong) UITextField *accountField;
@property (nonatomic, strong) UITextField *phonenumField;
@property (nonatomic, strong) UITextField *codeField;
@property (nonatomic, strong) UITextField *passWordField;
@property (nonatomic, strong) UIButton *codeButton;

@property (copy, nonatomic) ETTimerHandle processHanle;
@property (copy, nonatomic) ETTimerHandle finishHanle;
@property (strong, nonatomic) BCWelcomHepler *helper;

@end

static NSString * Get_ID_Key = @"getregistid";

@implementation ForgetViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNavButtonUI];
    self.title = @"忘记密码";
    // 创建scrollView
    [self setRootScrollView];
    // 创建图片
    [self setImageUI];
    // 创建textField
    [self setAllTextField];
    // 创建重设密码按钮
    [self setResetButton];
}

#pragma mark - 创建跟视图ScrollView
-(void) setRootScrollView {
    self.rootScrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
//    self.rootScrollView.backgroundColor = [UIColor lightGrayColor];
    self.rootScrollView.delegate = self;
    self.rootScrollView.showsVerticalScrollIndicator = false;
    self.rootScrollView.contentSize = CGSizeMake(BXScreenW, BXScreenH);
    [self.view addSubview:self.rootScrollView];
    
}

#pragma mark - 创建坐标及横线
-(void) setImageUI {
    
    NSArray *imgArray = @[@"账号",@"手机",@"验证码",@"密码"];
    for (int i = 0; i<4; i++) {
        UIButton *headBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 53*i, 20, 52)];
        [headBtn setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        [self.rootScrollView addSubview:headBtn];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(15, 52 + 53*i, BXScreenW - 30, 1)];
        line.backgroundColor = BXColor(152, 152, 152);
        [self.rootScrollView addSubview:line];
    }
}

#pragma mark - 创建textField
- (void) setAllTextField {
    
    self.accountField = [[UITextField alloc] initWithFrame:CGRectMake(55, 0, BXScreenW - 70, 52)];
    self.accountField.placeholder = @"请输入您的账号";
    self.accountField.textColor = The_Prompt_Color_Nine;
    [self.rootScrollView addSubview:self.accountField];
    
    // 手机号码
    self.phonenumField = [[UITextField alloc] initWithFrame:CGRectMake(55, 53, BXScreenW - 70, 52)];
    self.phonenumField.placeholder = @"请输入您的手机号";
    self.phonenumField.textColor = The_Prompt_Color_Nine;
    [self.rootScrollView addSubview:self.phonenumField];
    
    // 短信验证码
    self.codeField = [[UITextField alloc] initWithFrame:CGRectMake(55, 106, BXScreenW - 210, 52)];
    self.codeField.placeholder = @"请输入短信验证码";
    self.codeField.textColor = The_Prompt_Color_Nine;
    [self.rootScrollView addSubview:self.codeField];
    
    // 密码
    self.passWordField = [[UITextField alloc] initWithFrame:CGRectMake(55, 161, BXScreenW - 70, 52)];
    self.passWordField.placeholder = @"请输入密码";
    self.passWordField.textColor = The_Prompt_Color_Nine;
    [self.rootScrollView addSubview:self.passWordField];
    
    // 获取验证码按钮
    self.codeButton = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 156, 106, 136, 54)];
    [self.codeButton setTitleColor:BXColor(251, 80, 0) forState:UIControlStateNormal];
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.codeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    //    // button标题居右显示
    self.codeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.codeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.codeButton addTarget:self action:@selector(clickCodeButton) forControlEvents:UIControlEventTouchUpInside];
    [self.rootScrollView addSubview:self.codeButton];
}

#pragma mark - 创建重置密码按钮
-(void) setResetButton {
    UIButton *resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 330, BXScreenW - 80, 50)];
    resetBtn.backgroundColor = BXColor(236, 105, 65);
    [resetBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    [self.rootScrollView addSubview:resetBtn];
    resetBtn.layer.cornerRadius = 10;
    [resetBtn addTarget:self action:@selector(clickResetButton) forControlEvents:UIControlEventTouchUpInside];
}



#pragma mark - 获取验证码
-(void) clickCodeButton {
    
    if (self.phonenumField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    
    if ([HelperUtil checkTelNumber:self.phonenumField.text]) {
        
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
    [weakSelf.helper sendMobileCodeWithPhone:weakSelf.phonenumField.text success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [SVProgressHUD showSuccessWithStatus:@"验证码已发送，请注意查收"];
            self.processHanle = ^(NSInteger timeInterVal){
                st_dispatch_async_main(^{
                    [weakSelf.codeButton setTitleColor:BXColor(152, 152, 152) forState:UIControlStateNormal];
                    NSString *buttonTitle = [NSString stringWithFormat:@"获取验证码(%ld)",(long)timeInterVal];
                    [weakSelf.codeButton setTitle:buttonTitle forState:UIControlStateNormal];
                    weakSelf.codeButton.userInteractionEnabled = false;
                });
            };
            self.finishHanle = ^(NSInteger timeInterVal){
                //        weakSelf.getCode  = BXColor(152, 152, 152);
                [weakSelf.codeButton setTitleColor:BXColor(251, 80, 0) forState:UIControlStateNormal];
                [weakSelf.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                weakSelf.codeButton.userInteractionEnabled = true;
            };
            ETTimeTask *task = [ETTimeManager sharedETTimeManager].taskDic[Get_ID_Key];
            if (task) {
                [task setTaskWithOwner:self process:self.processHanle finish:self.finishHanle];
            }
            
        });
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"失败"];
    }];
    
    self.processHanle = ^(NSInteger timeInterVal){
        st_dispatch_async_main(^{
            [weakSelf.codeButton setTitleColor:BXColor(152, 152, 152) forState:UIControlStateNormal];
            NSString *buttonTitle = [NSString stringWithFormat:@"获取验证码(%ld)",(long)timeInterVal];
            [weakSelf.codeButton setTitle:buttonTitle forState:UIControlStateNormal];
            weakSelf.codeButton.userInteractionEnabled = false;
        });
    };
    self.finishHanle = ^(NSInteger timeInterVal){
        //        weakSelf.getCode  = BXColor(152, 152, 152);
        [weakSelf.codeButton setTitleColor:BXColor(251, 80, 0) forState:UIControlStateNormal];
        [weakSelf.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        weakSelf.codeButton.userInteractionEnabled = true;
    };
    ETTimeTask *task = [ETTimeManager sharedETTimeManager].taskDic[Get_ID_Key];
    if (task) {
        [task setTaskWithOwner:self process:self.processHanle finish:self.finishHanle];
    }
}

#pragma mark - 重置密码按钮的点击事件
-(void) clickResetButton {
    if (self.accountField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入账号"];
        return;
    }
    if (self.phonenumField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (self.codeField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if (self.passWordField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
        return;
    }
    [self.helper forgeterWithCode:self.codeField.text NewPassword:self.passWordField.text Phone:self.phonenumField.text UserName:self.accountField.text success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:response];
            if (model.StatusCode == 200) {
                
                [SVProgressHUD showSuccessWithStatus:@"重置密码成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showSuccessWithStatus:model.Message];
            }
        });
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"失败"];
    }];
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

@end
