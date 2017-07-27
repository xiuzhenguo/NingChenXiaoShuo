//
//  CYTabBarController.m
//  蚁巢
//
//  Created by 张春雨 on 2016/11/17.
//  Copyright © 2016年 张春雨. All rights reserved.
//

#import "CYTabBarController.h"

@interface CYTabBarController ()
/** center button of place ( -1:none center button >=0:contain center button) */
@property(assign , nonatomic) NSInteger centerPlace;
/** Whether center button to bulge */
@property(assign , nonatomic,getter=is_bulge) BOOL bulge;
/** items */
@property (nonatomic,strong) NSMutableArray <UITabBarItem *>*items;
@end

@implementation CYTabBarController{int tabBarItemTag;BOOL firstInit;}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.centerPlace = -1;
    
    //Observer Device Orientation
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OrientationDidChange) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    
    
}

/**
 *  Initialize selected
 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!firstInit)
    {
        firstInit = YES;
        if (self.centerPlace != -1 && self.items[self.centerPlace].tag != -1){
            NSLog(@"啦啦啦啦 %ld",(long)self.centerPlace);
            self.selectedIndex = self.centerPlace - 4;
        }else{
            self.selectedIndex = 0;
        }
        [self.tabbar setValue:[NSNumber numberWithInteger:self.selectedIndex] forKey:@"selectButtoIndex"];
    }
}

/**
 *  Add other button for child’s controller
 */
- (void)addChildController:(id)Controller title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    UIViewController *vc = [self findViewControllerWithobject:Controller];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    vc.tabBarItem.tag = tabBarItemTag++;
    NSLog(@"www%d",tabBarItemTag);
    [self.items addObject:vc.tabBarItem];
    [self addChildViewController:Controller];
}

/**
 *  Add center button
 */
- (void)addCenterController:(id)Controller bulge:(BOOL)bulge title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    _bulge = bulge;
    if (Controller) {
        
        [self addChildController:Controller title:title imageName:imageName selectedImageName:selectedImageName];
        NSLog(@"qqqq%d",tabBarItemTag - 1);
        self.centerPlace = tabBarItemTag-1;
    }else{
        UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:title
                                                          image:[UIImage imageNamed:imageName]
                                                  selectedImage:[UIImage imageNamed:selectedImageName]];
        item.tag = -1;
        [self.items addObject:item];
        self.centerPlace = tabBarItemTag;
    }
}

/**
 *  Device Orientation func
 */
- (void)OrientationDidChange{
    self.tabbar.frame = [self tabbarFrame];
}

- (CGRect)tabbarFrame{
    return CGRectMake(0, [UIScreen mainScreen].bounds.size.height-51,
                      [UIScreen mainScreen].bounds.size.width, 51);
}

/**
 *  getter
 */
- (CYTabBar *)tabbar{
    if (!_tabbar && self.items.count) {
        _tabbar = [[CYTabBar alloc]initWithFrame:[self tabbarFrame]];
        [_tabbar setValue:[NSNumber numberWithBool:self.bulge] forKey:@"bulge"];
        [_tabbar setValue:self forKey:@"controller"];
        [_tabbar setValue:[NSNumber numberWithInteger:self.centerPlace] forKey:@"centerPlace"];
        _tabbar.items = self.items;
        
        //remove tabBar
        for (UIView *loop in self.tabBar.subviews) {
            [loop removeFromSuperview];
        }
        self.tabBar.hidden = YES;
        [self.tabBar removeFromSuperview];
        
        
    }
    return _tabbar;
}
- (NSMutableArray <UITabBarItem *>*)items{
    if(!_items){
        _items = [NSMutableArray array];
    }
    return _items;
}


/**
 *  Update current select controller
 */
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    if (selectedIndex >= self.viewControllers.count){
        @throw [NSException exceptionWithName:@"selectedTabbarError"
                                       reason:@"Don't have the controller can be used, index beyond the viewControllers."
                                     userInfo:nil];
    }
    [super setSelectedIndex:selectedIndex];
    
    UIViewController *viewController = [self findViewControllerWithobject:self.viewControllers[selectedIndex]];
    [self.tabbar removeFromSuperview];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-52, [UIScreen mainScreen].bounds.size.width, 1)];
    line1.backgroundColor =BXColor(220, 220, 220);
    [viewController.view addSubview:line1];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-65,
                                                                      [UIScreen mainScreen].bounds.size.width, 65)];
    line.image = [UIImage imageNamed:@"tab_bg_1"];
    [viewController.view addSubview:line];
    
    [viewController.view addSubview:self.tabbar];
    viewController.extendedLayoutIncludesOpaqueBars = YES;
    [self.tabbar setValue:[NSNumber numberWithInteger:selectedIndex] forKeyPath:@"selectButtoIndex"];
}



/**
 *  Catch viewController
 */
- (UIViewController *)findViewControllerWithobject:(id)object{
    NSLog(@"2222%@",object);
    while ([object isKindOfClass:[UITabBarController class]] || [object isKindOfClass:[UINavigationController class]]){
        object = ((UITabBarController *)object).viewControllers.firstObject;
    }
    return object;
}

/**
 *  hidden tabbar and do animated
 */
- (void)setCYTabBarHidden:(BOOL)hidden animated:(BOOL)animated{
    NSTimeInterval time = animated ? 0.3 : 0.0;
    if (self.tabbar.isHidden) {
        self.tabbar.hidden = NO;
        [UIView animateWithDuration:time animations:^{
            self.tabbar.transform = CGAffineTransformIdentity;
        }];
    }else{
        CGFloat h = self.tabbar.frame.size.height;
        [UIView animateWithDuration:time-0.1 animations:^{
            self.tabbar.transform = CGAffineTransformMakeTranslation(0,h);
        }completion:^(BOOL finished) {
            self.tabbar.hidden = YES;
        }];
    }
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

@end
