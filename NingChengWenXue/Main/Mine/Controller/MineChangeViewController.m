//
//  MineChangeViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/10/13.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "MineChangeViewController.h"
#import "MineInforTableViewCell.h"
#import "InforImageTableViewCell.h"
#import "BCWelcomHepler.h"
#import "MineInforModel.h"
#import "ChangeViewController.h"
#import "ChangeSexViewController.h"

@interface MineChangeViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate,LDImagePickerDelegate,ChangeMineInformationDelegate, ChangeMineSexDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (strong, nonatomic) BCWelcomHepler *helper;
@property (nonatomic, strong) NSString *imageStr;
@property (nonatomic, strong) NSString *signStr;
@property (strong, nonatomic) UIAlertController *alertController;

@end

@implementation MineChangeViewController

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
    
    self.title = @"我的";
    [self setUpNavButtonUI];
    self.nameArray = @[@[@"签名"],@[@"昵称",@"性别",@"出生日期"]];
    
    [self setUpTableViewUI];
    
    [self getMineFirstData:kUserID];
    
    WEAKSELF
    self.alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [self.alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        st_dispatch_async_main(^{
            [weakSelf takePhoto];
        });
    }]];
    [self.alertController addAction:[UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        st_dispatch_async_main(^{
            [weakSelf getLocationPhoto];
        });
    }]];
    [self.alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    [self getMineFirstData:kUserID];
    
}

#pragma mark - tableView视图的创建
-(void)setUpTableViewUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[MineInforTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[InforImageTableViewCell class] forCellReuseIdentifier:@"ImageCell"];
    
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }
    else{
        return 3;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 55;
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

#pragma mark - 分区尾设置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 10)];
    backView.backgroundColor = BXColor(242, 242, 242);
    
    return backView;
}

#pragma mark - TableViewCell的设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        InforImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.nameLab.text = @"头像";
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.imageStr] placeholderImage:[UIImage imageNamed:@"打赏头像"]];
        
        return cell;
    }else if (indexPath.section ==1){
        MineInforTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        cell.nameLab.text = self.nameArray[indexPath.section - 1][indexPath.row];
        cell.conLab.text = self.signStr;
        return cell;
    }else{
        MineInforTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        cell.nameLab.text = self.nameArray[indexPath.section - 1][indexPath.row];
        cell.conLab.text = self.dataArray[indexPath.row];
        
        return cell;
    }
}

#pragma mark - tableViewCell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self presentViewController:self.alertController animated:true completion:nil];
    }else if (indexPath.section == 1){
        ChangeViewController *vc = [[ChangeViewController alloc] init];
        vc.row = 1;
        vc.textStr = self.signStr;
        vc.title = @"修改签名";
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if (indexPath.row == 0) {
            ChangeViewController *vc = [[ChangeViewController alloc] init];
            vc.row = 2;
            vc.textStr = self.dataArray.firstObject;
            vc.title = @"修改昵称";
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            ChangeSexViewController *vc = [[ChangeSexViewController alloc] init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            ChangeViewController *vc = [[ChangeViewController alloc] init];
            vc.row = 3;
            vc.textStr = self.dataArray.lastObject;
            vc.title = @"修改出生日期";
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - 修改签名、昵称、出生日期后回调
- (void)changeMineInformationDelegate:(NSInteger)row Content:(NSString *)content{
    if (row == 1) {//签名
        self.signStr = content;
    }else if (row == 2){
        self.dataArray[0] = content;
    }else{
        self.dataArray[2] = content;
    }
    [self.tableView reloadData];
}

#pragma mark - 修改性别后回调
-(void)changeMineSexDelegate:(NSString *)content{
    if ([content isEqualToString:@"1"]) {
        self.dataArray[1] = @"男";
    }else{
        self.dataArray[1] = @"女";
    }
    [self.tableView reloadData];
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
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //单例工具
        LDImagePicker *imagePicker = [LDImagePicker sharedInstance];
        imagePicker.delegate = self;
        //设置宽高比scale来设置剪切框大小，剪切框宽度固定为屏幕宽度
        [imagePicker showImagePickerWithType:ImagePickerPhoto   InViewController:self Scale:1.0];
        return;
    }
    [SVProgressHUD showErrorWithStatus:@"相册不可用"];
}

- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker{
}
- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage{
    NSData *imageData = UIImageJPEGRepresentation(editedImage,1.0);
    [self changeNovelHeadImage:imageData image:editedImage];
    
}

#pragma mark - 修改头像
-(void)changeNovelHeadImage:(NSData *)imageData image:(UIImage *)image {
    NSDictionary *dicDat = @{@"userId":kUserID};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//初始化请求对象
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置服务器允许的请求格式内容
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json", @"text/javascript,multipart/form-data", nil];
    //上传图片/文字，只能同POST
    [self.view showHudWithActivity:@""];
    [manager POST:@"http://www.cpu123.com/api/mine/home/image" parameters:dicDat constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 注意：这个name（我的后台给的字段是file）一定要和后台的参数字段一样 否则不成功
        [formData appendPartWithFileData:imageData name:@"FileImage" fileName:@"aaa.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress = %@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.view hideHubWithActivity];
        NSLog(@"responseObject = %@, task = %@",responseObject,task);
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"obj = %@",obj);
        if ([obj[@"StatusCode"] intValue] == 200 ) {
            [SVProgressHUD showSuccessWithStatus:@"成功"];
            [self getMineFirstData:kUserID];
        }else{
            [SVProgressHUD showErrorWithStatus:obj[@"Message"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.view hideHubWithActivity];
        [SVProgressHUD showErrorWithStatus:@"失败"];
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

#pragma mark - 我的首页数据获取
-(void)getMineFirstData:(NSString *)userid{
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper mineHomeInfoWithUserId:userid success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            self.dataArray = [[NSMutableArray alloc] init];
            MineInforModel *model = [MineInforModel mj_objectWithKeyValues:response];
            
            self.imageStr = model.UserImage;
            self.signStr = model.UserSign;
            [self.dataArray addObject:model.UserName];
            if ([model.UserSex isEqualToString:@"1"]) {
                [self.dataArray addObject:@"男"];
            }else{
                [self.dataArray addObject:@"女"];
            }
            
            [self.dataArray addObject:model.UserBirthday];
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.view showFailedViewReloadBlock:^{
            
            [self getMineFirstData:userid];
        
        }];
    }];
}


@end
