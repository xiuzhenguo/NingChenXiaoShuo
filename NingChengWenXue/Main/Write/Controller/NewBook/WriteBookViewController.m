//
//  WriteBookViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/9.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "WriteBookViewController.h"
#import "WriteBookTableViewCell.h"
#import "NBEditPhoneView.h"
#import "NBIntruViewController.h"
#import "NBClassfyViewController.h"
#import "NBWriteViewController.h"

@interface WriteBookViewController ()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) NBEditPhoneView *titleView;
@property (nonatomic, strong) UIButton *imgBtn;
@property (nonatomic, strong) NSArray *array;

@end

@implementation WriteBookViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;//不设置为黑色背景
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"新建作品";
    
    self.array = @[@"作品名称",@"作品标签",@"作品简介"];
    
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
    
    [self.tableView registerClass:[WriteBookTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 220)];
    self.tableView.tableHeaderView = self.headView;
    
    [self setUpTableHeadViewUI];
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 170)];
    self.tableView.tableFooterView = self.footView;
    
    [self setUpTableFootViewUI];
    
}

#pragma mark - tableView头视图的创建
-(void) setUpTableHeadViewUI {
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(BXScreenW/2.0 - 22.5, 75, 45, 45)];
    img.image = [UIImage imageNamed:@"添加图片"];
    [self.headView addSubview:img];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(img.frame)+20, BXScreenW, 15)];
    lab.font = FIFFont;
    lab.textColor = BXColor(195,195,195);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = @"请添加一张封面图（750x500）";
    [self.headView addSubview:lab];
    
    self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(41, 15, BXScreenW - 82, 182)];
    [self.imgBtn addTarget:self action:@selector(clickTitleButton) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.imgBtn];
    CAShapeLayer *border = [CAShapeLayer layer];
    //虚线的颜色
    border.strokeColor = BXColor(195,195,195).CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    //设置路径
    border.path = [UIBezierPath bezierPathWithRect:self.imgBtn.bounds].CGPath;
    border.frame = self.imgBtn.bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@2, @1];
    [self.imgBtn.layer addSublayer:border];
    
}

#pragma mark - 选择封面的点击事件
-(void) clickTitleButton {
    self.titleView = [[NBEditPhoneView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    [self.view.window addSubview:self.titleView];
    
    [self.titleView.camBtn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    
    [self.titleView.phoBtn addTarget:self action:@selector(getLocationPhoto) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - 调用相机
- (void)takePhoto{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = true;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:true completion:nil];
        return;
    }
    [SVProgressHUD showErrorWithStatus:@"相机不可用"];
}

#pragma mark - 调用相册
- (void)getLocationPhoto{
    [self.titleView removeFromSuperview];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = true;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:true completion:nil];
        return;
    }
    [SVProgressHUD showErrorWithStatus:@"相册不可用"];
}

#pragma mark ----UIImagePickerControllerDelegate-----
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;{
    if (![info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        return;
    }
    //裁剪后图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    //先压缩图片
    NSData *imageData = UIImageJPEGRepresentation(image,0.3);
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *imageName = [NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
    // 上传网络时用
    //    self.avatarStr = imageName;

    [ConnectModel uploadWithImageName:imageName imageData:imageData URL:nil finish:^(NSData *resultData) {
        st_dispatch_async_main(^{
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            [self.imgBtn setBackgroundImage:image forState:UIControlStateNormal];
        });
    }];
    [picker dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - UITableViewViewDelegate
// 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
// 每个分区cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark - UItableViewCell 设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 150, 43.5)];
        text.placeholder = self.array[indexPath.row];
        text.font = [UIFont systemFontOfSize:16];
        text.textColor = BXColor(152,152,152);
        [cell.contentView addSubview:text];
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 43.5, BXScreenW, 0.5)];
        lineLab.backgroundColor = BXColor(195, 195, 195);
        [cell.contentView addSubview:lineLab];
        
        return cell;
    }else{
        WriteBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLab.text = self.array[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.titleLab.textColor = BXColor(40,40,40);
        
        return cell;
    }
    
    
}

#pragma mark - tableView的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        
        NBIntruViewController *vc = [[NBIntruViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1) {
        NBClassfyViewController *vc = [[NBClassfyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - tableView尾视图的设置
- (void) setUpTableFootViewUI {
    UIButton *writeBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 70, BXScreenW - 30, 44)];
    writeBtn.backgroundColor = BXColor(236,105,65);
    [writeBtn setTitle:@"开始创作" forState:UIControlStateNormal];
    [writeBtn addTarget:self action:@selector(clickWriteButton) forControlEvents:UIControlEventTouchUpInside];
    writeBtn.titleLabel.font = FIFFont;
    writeBtn.layer.cornerRadius = 5;
    [self.footView addSubview:writeBtn];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(writeBtn.frame)+15, BXScreenW - 10, 30)];
    lable.font = THIRDFont;
    lable.numberOfLines = 0;
    lable.textColor = BXColor(152,152,152);
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"支持原创，杜绝抄袭、非法转载、色情文字图片、虚假广告等";
    [self.footView addSubview:lable];
}

#pragma mark - 创作按钮的点击事件
-(void) clickWriteButton {
    NBWriteViewController *vc = [[NBWriteViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
