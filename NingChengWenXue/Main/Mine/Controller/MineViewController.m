//
//  ProfileViewController.m
//  IrregularTabBar
//
//  Created by JYJ on 16/5/3.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"


@interface MineViewController ()<UINavigationControllerDelegate>

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"我的";
    
    [self addButton];
}

-(void) addButton {
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, BXScreenW - 60, 60)];
    loginBtn.backgroundColor = [UIColor lightGrayColor];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(clickLoginbutton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}

-(void) clickLoginbutton {
    LoginViewController *vc = [[LoginViewController alloc] init];

    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
