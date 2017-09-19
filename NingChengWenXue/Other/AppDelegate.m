//
//  AppDelegate.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/14.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "AppDelegate.h"
#import "BXNavigationController.h"
#import "HomeViewController.h"
#import "CommunityViewController.h"
#import "WriteViewController.h"
#import "BookshelfViewController.h"
#import "MineViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    // 设置窗口的根控制器
    
    CYTabBarController * tabbar = [[CYTabBarController alloc]init];
    
    /**
     *  style 1 (中间按钮突出 ， 设为按钮 , 底部有文字 ， 闲鱼)
     */
    
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:[HomeViewController new]];
    [tabbar addChildController:nav1 title:@"首页" imageName:@"首页" selectedImageName:@"首页_click"];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:[BookshelfViewController new]];
    [tabbar addChildController:nav2 title:@"书架" imageName:@"书架" selectedImageName:@"书架_click"];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:[CommunityViewController new]];
    [tabbar addChildController:nav3 title:@"社区" imageName:@"社区" selectedImageName:@"社区_click"];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:[MineViewController new]];
    [tabbar addChildController:nav4 title:@"我的" imageName:@"我" selectedImageName:@"我_click"];
    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:[WriteViewController new]];
    [tabbar addCenterController:nav5 bulge:YES title:@"写写" imageName:@"狐狸" selectedImageName:@"狐狸_click"];
    self.window.rootViewController = tabbar;

    
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:.01 alpha:.8]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    [self.window makeKeyAndVisible];
    
    // 状态栏字体颜色
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KServiceAccount];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLoginStateKey];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
