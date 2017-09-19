//
//  NBAttViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/12.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBAttViewController.h"
#import "NBAttTableViewCell.h"
#import "NCWriteHelper.h"
#import "NewBookListModel.h"

@interface NBAttViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NCWriteHelper *helper;

@end

@implementation NBAttViewController

-(NCWriteHelper *)helper{
    if (!_helper) {
        _helper = [NCWriteHelper helper];
    }
    return _helper;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;//不设置为黑色背景
    UIImage *colorImage = [NavLineImage imageWithColor:[UIColor clearColor] size:CGSizeMake(BXScreenW, 0.5)];
    [self.navigationController.navigationBar setBackgroundImage:colorImage forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[NavLineImage imageWithColor:BXColor(195, 195, 195) size:CGSizeMake(BXScreenW, 0.5)]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.typeRow == 0) {
        self.dataArray = [NSMutableArray arrayWithObjects:@"仅自己可见",@"公开", nil];
    }else{
        self.dataArray = [NSMutableArray arrayWithObjects:@"连载中",@"已完结", nil];
    }
    
    [self setUpNavButtonUI];
    
    [self setUpTableViewUI];
}

#pragma mark - 创建UItableView视图
- (void) setUpTableViewUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[NBAttTableViewCell class] forCellReuseIdentifier:@"cell"];
}


#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark - UItableViewCell 设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NBAttTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.typeLab.text = self.dataArray[indexPath.row];
    
    cell.imgBtn.tag = indexPath.row + 1000;
    if (self.typeRow == 0) {
        if (indexPath.row == 0) {
            if (self.IsPublish == false) {
                [cell.imgBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
            }else{
                [cell.imgBtn setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
            }
        }else{
            if (self.IsPublish == true) {
                [cell.imgBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
            }else{
                [cell.imgBtn setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
            }
        }
        
    }else{
        if (indexPath.row == 0) {
            if (self.IsPublish == false) {
                [cell.imgBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
            }else{
                [cell.imgBtn setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
            }
        }else{
            if (self.IsPublish == true) {
                [cell.imgBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
            }else{
                [cell.imgBtn setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
            }
        }
    }
    [cell.imgBtn addTarget:self action:@selector(cliclImgViewButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark - tableViewCell的选择图片的点击事件
-(void) cliclImgViewButton:(UIButton *)sender {
    
    NSString *type = @"";
    if (sender.tag - 1000 == 0) {
        type = @"false";
    }else{
        type = @"true";
    }
    if (self.typeRow == 0) {
        [self changeNovelShuXingData:type];
    }else{
        if (sender.tag - 1000 == 0 && self.IsPublish == false) {
            return;
        }
        [self changeNovelStatusData];
    }

}

#pragma mark - 修改属性功能的实现
-(void) changeNovelShuXingData:(NSString *)type {
    [self.helper changeNovelShuXingWithFictionId:self.bookId Q:type success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            [SVProgressHUD showSuccessWithStatus:@"属性修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"修改属性失败"];
    }];
}

#pragma mark - 修改作品状态
-(void)changeNovelStatusData {
    [self.helper changeNovelStatusWithFictionId:self.bookId success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            [SVProgressHUD showSuccessWithStatus:@"属性修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"修改属性失败"];
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
