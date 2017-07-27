//
//  ViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/14.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ViewController.h"
#import "BXNavigationController.h"
#import "HomeViewController.h"
#import "CommunityViewController.h"
#import "WriteViewController.h"
#import "BookshelfViewController.h"
#import "MineViewController.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface ViewController ()<UITabBarControllerDelegate>

@property (nonatomic,strong)UIButton *button;
@end

@implementation ViewController
@synthesize button;
#pragma mark- setup
-(void)setup
{
    //  添加突出按钮
    [self addCenterButtonWithImage:[UIImage imageNamed:@"狐狸"] selectedImage:[UIImage imageNamed:@"我的钱"]];
    //  UITabBarControllerDelegate 指定为自己
    self.delegate=self;
    //  指定当前页——中间页
    //self.selectedIndex=0;
    //  设点button状态
    //button.selected=YES;
    //  设定其他item点击选中颜色
    
}
#pragma mark - addCenterButton
// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithImage:(UIImage*)buttonImage selectedImage:(UIImage*)selectedImage
{
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(pressChange:) forControlEvents:UIControlEventTouchUpInside];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //  设定button大小为适应图片
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    
    //  这个比较恶心  去掉选中button时候的阴影
    button.adjustsImageWhenHighlighted=NO;
    /*
     *  核心代码：设置button的center 和 tabBar的 center 做对齐操作， 同时做出相对的上浮
     */
    CGPoint center = self.tabBar.center;
    center.y = center.y - buttonImage.size.height/3;
    button.center = center;
    [self.view addSubview:button];
}

-(void)pressChange:(id)sender
{
    self.selectedIndex=2;
    button.selected=YES;
}

#pragma mark- TabBar Delegate

//  换页和button的状态关联上

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (self.selectedIndex==2) {
        button.selected=YES;
    }else
    {
        button.selected=NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBarVC];
//    [self setup];
    [self addButtonNotifation];
    
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_bg_1"]];
    [[UITabBar appearance] setShadowImage:[UIImage new]];

    // 去除顶部横线
//    [self.tabBar setClipsToBounds:YES];
//    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
}
//添加大圆按钮的通知
-(void)addButtonNotifation{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buttonHidden) name:@"buttonNotifationCenter" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buttonNotHidden) name:@"buttonNotHidden" object:nil];
}
-(void)buttonNotHidden{
    button.hidden=NO;
}
-(void)buttonHidden{
    button.hidden=YES;
}
// 初始化所有子控制器
- (void)setTabBarVC{
    
    [self setTabBarChildController:[[HomeViewController alloc] init] title:@"首页" image:@"首页" selectImage:@"首页_click"];
    
    [self setTabBarChildController:[[BookshelfViewController alloc] init] title:@"书架" image:@"书架" selectImage:@"书架_click"];
    
    [self setTabBarChildController:[[WriteViewController alloc] init] title:@"写写" image:@"狐狸" selectImage:@"狐狸_click"];
    
    
    [self setTabBarChildController:[[CommunityViewController alloc] init] title:@"社区" image:@"社区" selectImage:@"社区_click"];
    
    [self setTabBarChildController:[[MineViewController alloc] init] title:@"我的" image:@"我" selectImage:@"我_click"];
}


// 添加tabbar的子viewcontroller
- (void)setTabBarChildController:(UIViewController*)controller title:(NSString*)title image:(NSString*)imageStr selectImage:(NSString*)selectImageStr{
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:controller];
    nav.tabBarItem.title = title;
    
    nav.tabBarItem.image = [[UIImage imageNamed:imageStr]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageStr]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGBA(113, 109, 104, 1.0)} forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:RGBA(51, 135, 255, 1.0)} forState:UIControlStateSelected];
    
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

