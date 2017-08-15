//
//  NBEditViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/4.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBEditViewController.h"
#import "NBEditTableViewCell.h"
#import "NBEditSecTableViewCell.h"
#import "SectionListModel.h"
#import "NBRightItemView.h"
#import "NBEditPhoneView.h"
#import "HReadPageViewController.h"
#import "NBTableViewRowView.h"
#import "NBIntruViewController.h"
#import "NBSignedViewController.h"
#import "NBAttViewController.h"
#import "NBClassfyViewController.h"
#import "NBWriteViewController.h"
#import "NewBookListModel.h"
#import "NewBookModel.h"
#import "NCWriteHelper.h"
#import "SwichTableViewCell.h"
#import "ChangeNameTableViewCell.h"
#import "BNewBookViewController.h"
#import "WriteBookViewController.h"
#import "DateTimePickerView.h"
#import "TABookViewController.h"
#import "PreviewSecViewController.h"

@interface NBEditViewController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, DateTimePickerViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *imgBtn;
@property (nonatomic, strong) NBRightItemView *rightItemView;
@property (nonatomic, strong) NBEditPhoneView *titleView;
@property (nonatomic, strong) NBTableViewRowView *rowView;
@property (nonatomic, strong) UITextField *tectfield;
@property (strong, nonatomic) NCWriteHelper *helper;
@property (nonatomic, assign) NSInteger pagenum;
@property (nonatomic, strong) NSMutableArray *messageArray;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation NBEditViewController

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
    self.pagenum = 1;
    [self getProductionMessageData];
    [self getNovelSectionListData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"编辑故事";
    
    
    [self setUpNavButtonUI];
    
    [self setUpTableViewUI];
    
    
    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pagenum = 1;
    [self getProductionMessageData];
    [self getNovelSectionListData];
    
}

#pragma mark - 上拉加载数据
-(void) loadMoreData{
    self.pagenum++;
    [self getNovelSectionListData];
    
}

#pragma mark - 创建TableView
- (void) setUpTableViewUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH - 64) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[ChangeNameTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[NBEditTableViewCell class] forCellReuseIdentifier:@"cell1"];
//    [self.tableView registerClass:[NBEditSecTableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.tableView registerClass:[SwichTableViewCell class] forCellReuseIdentifier:@"cell3"];
    
    
    self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 177)];
    [self.imgBtn setBackgroundImage:[UIImage imageNamed:@"默认图片"] forState:UIControlStateNormal];
    [self.imgBtn addTarget:self action:@selector(clickTitleButton) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = self.imgBtn;
    
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
    [self changeNovelHeadImage:imageData image:image];
    [picker dismissViewControllerAnimated:true completion:nil];
}


#pragma mark - UITableViewViewDelegate
// 每个分区cell的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 1;
    }else{
        NewBookModel *model = self.dataArray.firstObject;
        return model.SectionItem.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return 53;
    }else{
        return 44;
    }
}

#pragma mark - tableViewCell设置
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewBookListModel *model = self.messageArray.firstObject;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ChangeNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.tectfield.text = model.FictionName;
            self.tectfield = cell.tectfield;
            [cell.btn addTarget:self action:@selector(clickChangeNameButton) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }else{
            NBEditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *arr = @[@"",@"作品标签",@"作品简介"];
            cell.titleLab.text = arr[indexPath.row];
            if (indexPath.row == 1) {
                cell.conLab.text = [NSString stringWithFormat:@"%@,%@",model.CategoryName,model.FictionKey];
            }else{
                cell.conLab.text = model.Intro;
                cell.conLab.font = ELEFont;
            }
            return cell;
        }
    }else if (indexPath.section == 1){
        NBEditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = @[@"作品属性",@"作品状态"];
        cell.titleLab.text = arr[indexPath.row];
        if (indexPath.row == 1) {
            cell.conLab.text = model.FictionStatusName;
        }else{
            cell.conLab.text = model.PublishName;
        }
        return cell;
    }else if (indexPath.section == 2){
        SwichTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (model.Authentiction == true) {
            [cell.swi setOn:YES animated:YES];
        }else{
            [cell.swi setOn:NO animated:YES];
        }
        [cell.swi addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 43.5, BXScreenW, 0.5)];
        lineLab.backgroundColor = BXColor(195, 195, 195);
        [cell addSubview:lineLab];
        return cell;
        
    }else if (indexPath.section == 3) {
        
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
         NBEditSecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[NBEditSecTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NewBookModel *list = self.dataArray.firstObject;
        SectionListModel *model = list.SectionItem[indexPath.row];
        cell.viewModel = model;
        
        cell.imgbtn.tag = 1000 + indexPath.row;
        [cell.imgbtn addTarget:self action:@selector(cilckImageButton:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    return nil;
}

#pragma mark - tabeViewCell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewBookListModel *listModel = self.messageArray.firstObject;
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        NBClassfyViewController *vc = [[NBClassfyViewController alloc] init];
        vc.typeID = listModel.Category;
        if (listModel.FictionKey.length == 0) {
            vc.ortherArray = [[NSMutableArray alloc] init];
        }else{
            vc.ortherArray =  [NSMutableArray arrayWithArray:[listModel.FictionKey componentsSeparatedByString:@","]];
        }
        vc.bookId = self.bookID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    //作品简介跳转
    if (indexPath.section == 0 && indexPath.row == 2) {
        NBIntruViewController *vc = [[NBIntruViewController alloc] init];
        vc.introduceStr = listModel.Intro;
        vc.bookId = self.bookID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        NBAttViewController *vc  = [[NBAttViewController alloc] init];
        vc.title = @"作品属性";
        vc.typeRow = 0;
        vc.IsPublish = listModel.IsPublish;
        vc.bookId = self.bookID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 1){
        NBAttViewController *vc = [[NBAttViewController alloc] init];
        vc.title = @"作品状态";
        vc.typeRow = 1;
        if (listModel.FictionStatus == 1) {
            vc.IsPublish = false;
        }else{
            vc.IsPublish = true;
        }
        vc.bookId = self.bookID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 3) {
        NBWriteViewController *vc = [[NBWriteViewController alloc] init];
        NewBookModel *list = self.dataArray.firstObject;
        SectionListModel *model = list.SectionItem[indexPath.row];
        vc.sectionID = model.SectionId;
        vc.ficID = self.bookID;
        vc.typeInt = 2;
        if (model.SectionStatus == 3) {
            [self.navigationController pushViewController:vc animated:YES];
        }else if (model.SectionStatus == 2){
            [SVProgressHUD showErrorWithStatus:@"此章节已发布,不能修改章节内容"];
            return;
        }else if (model.SectionStatus == 4){
            [SVProgressHUD showErrorWithStatus:@"此章节处于待审核状态,不能修改章节内容"];
            return;
        }
    }
}

#pragma mark - tableView最后一个分区右侧按钮的点击事件
-(void) cilckImageButton:(UIButton *)sender {
    self.rowView = [[NBTableViewRowView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    [self.view.window addSubview:self.rowView];
    NewBookModel *list = self.dataArray.firstObject;
    SectionListModel *model = list.SectionItem[sender.tag - 1000];
    __weak typeof(self)weakSelf = self;
    [weakSelf.rowView setFinishButtonTitle:^(NSString *title){
        
        if ([title isEqualToString:@"1000"]) {
            NSLog(@"%@",model.SectionId);
            [weakSelf pushNovelSectionData:model.SectionId Model:model];
        }else if ([title isEqualToString:@"1003"]){
            [weakSelf removeNovelSection:model.SectionId Index:sender.tag - 1000];
        }else if ([title isEqualToString:@"1001"]){
            DateTimePickerView *pickerView = [[DateTimePickerView alloc] init];
            pickerView.delegate = self;
            pickerView.model = model;
            pickerView.secID = model.SectionId;
            pickerView.pickerViewMode = DatePickerViewDateTimeMode;
            [self.view.window addSubview:pickerView];
            [pickerView showDateTimePickerView];
        }
    }];
}

#pragma mark - switchIsChanged 方法，用于监听UISwitch控件的值改变
-(void)switchIsChanged:(UISwitch *)swith
{
    UISwitch *swi = (UISwitch *)swith;
    NSString *type = @"";
    if (swi.isOn){
        type = @"true";
    } else {
        type = @"false";
    }
    [self.helper daiBiaoZuoWithFictionId:self.bookID UserId:kUserID Q:type success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:response];
            if (model.StatusCode == 200) {
                [SVProgressHUD showSuccessWithStatus:@"更改成功"];
            }else{
                
                [SVProgressHUD showErrorWithStatus:model.Message];
            }
            
            [self getProductionMessageData];
        });
        
        return ;
        
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"失败"];
    }];
    
}

#pragma mark - tableView 分区头设置
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        return 0;
    }else if (3 == section){
        return 45;
    }else{
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        NewBookModel *model = self.dataArray.firstObject;
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 45)];
        backView.backgroundColor = BXColor(242, 242, 242);
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, BXScreenW - 110, 44.5)];
        lab.textColor = BXColor(101,101,101);
        lab.font = FIFFont;
        lab.text = [NSString stringWithFormat:@"目录（%ld已发布章节）",model.Count];
        [backView addSubview:lab];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(BXScreenW - 100, 8, 90, 28)];
        btn.titleLabel.font = THIRDFont;
        [btn setTitle:@"添加新章节" forState:UIControlStateNormal];
        btn.backgroundColor = BXColor(236,105,65);
        btn.layer.cornerRadius = 5;
        [btn addTarget:self action:@selector(clickNewSectionButton) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 44.5, BXScreenW, 0.5)];
        lineLab.backgroundColor = BXColor(195, 195, 195);
        [backView addSubview:lineLab];
        return  backView;
    }else{
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 10)];
        backView.backgroundColor = BXColor(242, 242, 242);
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 9.5, BXScreenW, 0.5)];
        lineLab.backgroundColor = BXColor(195, 195, 195);
        [backView addSubview:lineLab];
        return backView;
    }
}

#pragma mark - 添加新章节按钮的点击事件
-(void) clickNewSectionButton {
    NewBookListModel *listModel = self.messageArray.firstObject;
    if (listModel.FictionStatus == 2) {
        [SVProgressHUD showErrorWithStatus:@"作品已完结,不能添加新章节"];
        return;
    }
    NBWriteViewController *vc = [[NBWriteViewController alloc] init];
    vc.ficID = self.bookID;
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
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 30);
    [rightBtn setImage:[UIImage imageNamed:@"详情"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [rightBtn addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark - 右侧分享按钮的点击事件
-(void) clickRightButton {
    self.rightItemView = [[NBRightItemView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    [self.view.window addSubview:self.rightItemView];
    for (int i = 0; i<self.rightItemView.BtnArray.count; i++) {
        
        [self.rightItemView.BtnArray[i] addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}


#pragma mark - 导航右侧按钮显示页面的点击方法
-(void) clickButton:(UIButton *)sender {
    [self.rightItemView removeFromSuperview];
    if (sender.tag == 1000) {
        HReadPageViewController *vc = [[HReadPageViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1001){
        // 签约
        NBSignedViewController *vc = [[NBSignedViewController alloc] init];
        vc.bookId = self.bookID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1002){
        // 是否删除作品
        [self clickDeleteButton];
    }
}

#pragma mark - 删除作品按钮的点击事件
-(void) clickDeleteButton {
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"" message:@"是否删除作品" preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(alertControl) wAlert = alertControl;
    [wAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        // 点击确定按钮的时候, 会调用这个block
        [self deleteNovelData];
        
    }]];
    
    [wAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:wAlert animated:YES completion:nil];
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{

    if (self.newtype == 1) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[TABookViewController class]]) {
                TABookViewController *A =(TABookViewController *)controller;
                [self.navigationController popToViewController:A animated:YES];
            }
        }
    }else{
        //直接返回到第一个视图
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - 作品信息的获取
-(void) getProductionMessageData {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper productionMessageWithFictionId:self.bookID success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            self.messageArray = [[NSMutableArray alloc] init];
            
            NewBookListModel *model = [NewBookListModel mj_objectWithKeyValues:response];
            [self.messageArray addObject:model];
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            [self.imgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.FictionImage] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"默认图片"]];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
    }];
}

#pragma mark - 章节列表的获取
-(void)getNovelSectionListData {
    [self.helper novelSectionListWithFictionId:self.bookID pageIndex:[NSString stringWithFormat:@"%ld",self.pagenum] success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            if (self.pagenum == 1) {
                self.dataArray = [[NSMutableArray alloc] init];
            }
            NewBookModel *model = [NewBookModel mj_objectWithKeyValues:response];
            [self.dataArray addObject:model];
            
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
            
            [self getProductionMessageData];
            [self getNovelSectionListData];
        }];
    }];
}

#pragma mark - 更改书名
-(void) clickChangeNameButton{
    [self.view showHudWithActivity:@"正在加载"];
    NewBookListModel *model = self.messageArray.firstObject;
    [self.helper changeNovelNameWithFictionId:self.bookID FictionName:self.tectfield.text success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];
            model.FictionName = self.tectfield.text;
            [SVProgressHUD showSuccessWithStatus:@"更改成功"];
            [self.tableView reloadData];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [SVProgressHUD showErrorWithStatus:@"失败"];
    }];
}

#pragma mark - 修改小说封面
-(void)changeNovelHeadImage:(NSData *)imageData image:(UIImage *)image {
    NSDictionary *dicDat = @{@"fictionId":self.bookID};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//初始化请求对象
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置服务器允许的请求格式内容
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json", @"text/javascript,multipart/form-data", nil];
    //上传图片/文字，只能同POST
    [manager POST:@"http://192.168.199.177:8100/api/writing/fiction/image" parameters:dicDat constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 注意：这个name（我的后台给的字段是file）一定要和后台的参数字段一样 否则不成功
        [formData appendPartWithFileData:imageData name:@"FileImage" fileName:@"aaa.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress = %@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.imgBtn setBackgroundImage:image forState:UIControlStateNormal];
        NSLog(@"responseObject = %@, task = %@",responseObject,task);
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"obj = %@",obj);
        if ([obj[@"StatusCode"] intValue] == 200 ) {
            [SVProgressHUD showSuccessWithStatus:@"成功"];
        }else{
            [SVProgressHUD showErrorWithStatus:obj[@"Message"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"失败"];
    }];
}

#pragma mark - 章节发布功能
-(void)pushNovelSectionData:(NSString *)secId Model:(SectionListModel *)model {
    [self.helper publishNovelSectionWithSectionId:secId success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [SVProgressHUD showSuccessWithStatus:@"发布成功"];
            model.SectionStatus = 4;
            [self.tableView reloadData];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"发布失败"];
    }];
}

#pragma mark - 删除作品
-(void)deleteNovelData{
    [self.helper deleteNovelWithFictionId:self.bookID AuthorId:kUserID success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            if (self.newtype == 1) {
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[TABookViewController class]]) {
                        TABookViewController *A =(TABookViewController *)controller;
                        [self.navigationController popToViewController:A animated:YES];
                    }
                }
            }else{
                //直接返回到第一个视图
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"删除失败"];
    }];
}

#pragma mark - 删除章节
-(void)removeNovelSection:(NSString *)secID Index:(NSInteger )index {
    NewBookModel *model = self.dataArray.firstObject;
    SectionListModel *list = model.SectionItem[index];
    [self.helper removeNovelSectionWithFictionId:self.bookID SectionId:secID success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            arr = [model.SectionItem mutableCopy];
            [arr removeObjectAtIndex:index];
            model.SectionItem = [arr copy];
            if (list.SectionStatus == 2) {
                model.Count = model.Count - 1;
            }
            [self.tableView reloadData];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"删除失败"];
    }];
}

#pragma mark - delegate 定时发布功能的实现
- (void)didClickFinishDateTimePickerView:(NSString *)date SecID:(NSString *)secId Model:(SectionListModel *)model{
    
    [self.helper dingShiPublishSectionWithSectionId:secId FictionId:self.bookID UserId:kUserID PublishTime:[NSString stringWithFormat:@"%@:00",date] success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            [SVProgressHUD showSuccessWithStatus:@"成功"];
            model.SectionStatus = 4;
            [self.tableView reloadData];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"失败"];
    }];
}


@end
