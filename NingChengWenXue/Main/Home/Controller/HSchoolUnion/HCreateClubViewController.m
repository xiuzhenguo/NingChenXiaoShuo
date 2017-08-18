//
//  HCreateClubViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/9.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HCreateClubViewController.h"
#import "AFNetworking.h"

@interface HCreateClubViewController ()<UIScrollViewDelegate, UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *numLab;
@property (nonatomic, strong) UIButton *imgBtn;
@property (nonatomic, strong) UIImageView *img;
@property (strong, nonatomic) UIAlertController *alertController;

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *placeholderArr;
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) NSString *strImg;

@property (nonatomic, strong) UITextField *communityName;
@property (nonatomic, strong) UITextField *schoolName;
@property (nonatomic, strong) UITextField *email;
@property (nonatomic, strong) UITextField *address;
@property (nonatomic, strong) UITextField *wechat;
@property (nonatomic, strong) UITextField *quantity;
@property (nonatomic, strong) UITextField *introduceName;
@property (nonatomic, strong) UITextField *presidentName;
@property (nonatomic, strong) UITextField *phone;
@property (nonatomic, strong) UITextField *qq;
@property (nonatomic, strong) UITextField *teacher;


@end

@implementation HCreateClubViewController

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
    self.title = @"创建社团";
    self.titleArr = @[@"社团名称",@"所属学校",@"指导老师",@"社团头像",@"社长姓名",@"联系电话",@"Email",@"联系地址",@"联系QQ",@"联系微信",@"预计入驻人数",@"介绍人"];
    self.placeholderArr = @[@"请输入社团名称（必填）",@"请输入您的学校 (必填)",@"请填写指导老师",@"请上传社团头像",@"请填写您的真实姓名 (必填)",@"请填写您的联系电话 (必填)",@"请填写您的EMail（必填）",@"请填写您的联系地址（必填）",@"请填写您的联系QQ（必填）",@"请填写您的联系微信（必填）",@"请填写您的入住人数（必填）",@"请填写您的介绍人"];
    
    // 添加导航栏
    [self setUpNavButtonUI];
    // 添加scrollView
    [self setUpScrollViewUI];
    
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
}

#pragma maek - 创建底视图ScrollView
-(void) setUpScrollViewUI {
    
    self.scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH-64)];
    self.scrollView.backgroundColor = BXColor(242, 242, 242);
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(BXScreenW, BXScreenH+64+44);
    [self.view addSubview:self.scrollView];

    [self setUpTitleLableUI];
    [self setUpClubsIntroductionUI];
    [self setUpFootCreateButtonUI];
}

#pragma mark - 创建UILab了及UITextFiled;
-(void) setUpTitleLableUI {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, BXScreenW, 44*12)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:backView];
    
    for (int i = 0; i < 12; i++) {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 44*i, 105, 43.5)];
        titleLab.text = self.titleArr[i];
        titleLab.font = FIFFont;
        titleLab.textColor = BXColor(40,40,40);
        [backView addSubview:titleLab];
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 43.5+44*i, BXScreenW, 0.5)];
        lineLab.backgroundColor = BXColor(195,195,195);
        [backView addSubview:lineLab];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(120, 44*i, BXScreenW - 150, 43.5)];
        self.textField.font = THIRDFont;
        self.textField.textColor = BXColor(152,152,152);
        self.textField.placeholder = self.placeholderArr[i];
        [backView addSubview:self.textField];
        if (i == 3) {
            [self.textField removeFromSuperview];
            self.img = [[UIImageView alloc] initWithFrame:CGRectMake(BXScreenW - 30, 144, 15, 20)];
            self.img.image = [UIImage imageNamed:@"箭头-1"];
            [backView addSubview:self.img];
            
            self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(120, 44*3, BXScreenW - 150, 43.5)];
            [backView addSubview:_imgBtn];
            [_imgBtn setTitle:self.placeholderArr[3] forState:UIControlStateNormal];
            [_imgBtn setTitleColor:BXColor(152,152,152) forState:UIControlStateNormal];
            _imgBtn.titleLabel.font = THIRDFont;
            _imgBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            _imgBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            [_imgBtn addTarget:self action:@selector(clickImgButton) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            self.textField.enabled = YES;
        }
        switch (i) {
            case 0:
                _communityName = self.textField;
                break;
            case 1:
                _schoolName = self.textField;
                break;
            case 2:
                _teacher = self.textField;
                break;
            case 4:
                _presidentName = self.textField;
                break;
            case 5:
                _phone = self.textField;
                break;
            case 6:
                _email = self.textField;
                break;
            case 7:
                _address = self.textField;
                break;
            case 8:
                _qq = self.textField;
                break;
            case 9:
                _wechat = self.textField;
                break;
            case 10:
                _quantity = self.textField;
                break;
            case 11:
                _introduceName = self.textField;
                break;
            
            default:
                break;
        }
        
    }
}

#pragma mark - 上传头像按钮点击事件
-(void) clickImgButton {
    [self presentViewController:self.alertController animated:true completion:nil];
}

#pragma mark - 创建社团简介
-(void) setUpClubsIntroductionUI {
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 44*12+25, BXScreenW - 30, 15)];
    nameLab.textColor = BXColor(101,101,101);
    nameLab.text = @"社团简介（300字以内）";
    nameLab.font = THIRDFont;
    [self.scrollView addSubview:nameLab];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(nameLab.frame)+10, BXScreenW - 30, 105)];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.scrollEnabled = YES;
    _textView.editable = YES;
    _textView.delegate = self;
    _textView.textColor = BXColor(152, 152, 152);
    _textView.font = FIFFont;
    _textView.returnKeyType = UIReturnKeyDone;
    [self.scrollView addSubview:_textView];
    
    self.numLab = [[UILabel alloc] initWithFrame:CGRectMake(BXScreenW - 75, CGRectGetMaxY(_textView.frame)-20, 50, 15)];
    self.numLab.textAlignment = NSTextAlignmentRight;
    self.numLab.textColor = BXColor(152, 152, 152);
    self.numLab.text = @"0/300";
    self.numLab.font = ELEFont;
    [self.scrollView addSubview:self.numLab];
}

#pragma mark - 创建底部创建按钮
-(void) setUpFootCreateButtonUI {
    UIButton *createBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.textView.frame)+15, BXScreenW - 30, 44)];
    [createBtn setTitle:@"创建" forState:UIControlStateNormal];
    createBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    createBtn.backgroundColor = BXColor(236,105,65);
    createBtn.layer.cornerRadius = 5;
    [createBtn addTarget:self action:@selector(ClickCreateButton) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:createBtn];
}

#pragma mark - 判断输入字符串的长度
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = 500 - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > 500)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:500];
        
        [textView setText:s];
    }
    
    //不让显示负数
    self.numLab.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,existTextNum),300];
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
    
    // 给按钮传值
    [self.imgBtn setImage:image forState:UIControlStateNormal];
    _imgBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _imgBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [_imgBtn setTitle:@"" forState:UIControlStateNormal];
    _imgBtn.frame = CGRectMake(130, 134, 40, 40);
    _imgBtn.layer.cornerRadius = 20;
    _imgBtn.clipsToBounds = YES;
    [self.img removeFromSuperview];
    
    //先压缩图片
    NSData *imageData = UIImageJPEGRepresentation(image,1);
    self.imageData = imageData;
    
    [picker dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - 拖动scrollView 时失去第一响应者
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.textField resignFirstResponder];
    [self.textView resignFirstResponder];
    [self.view endEditing:YES];
    
    NSLog(@"%@",self.teacher.text);
    
}

#pragma mark - 设置导航栏按钮
-(void) setUpNavButtonUI {
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 100, 30);
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

-(void) ClickCreateButton {
    
    if (self.communityName.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写社团名称"];
        return;
    }
    if (self.schoolName.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写学校名称"];
        return;
    }
    if (self.teacher.text.length == 0) {
        self.teacher.text = @"";

    }
    if (self.presidentName.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写社长姓名"];
        return;
    }
    if (self.phone.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写联系电话"];
        return;
    }
    if (self.email.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写E-mail"];
        return;
    }
    if (self.address.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写联系地址"];
        return;
    }
    if (self.qq.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写QQ号"];
        return;
    }
    if (self.wechat.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写微信"];
        return;
    }
    if (self.quantity.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写入住人数"];
        return;
    }
    if (self.introduceName.text.length == 0) {
        self.introduceName.text = @"";
    
    }
    if (self.textView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写社团简介"];
        return;
    }
    if (self.imageData.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择社团头像"];
        return;
    }
    
    NSDictionary *dicDat = [[NSDictionary alloc] init];
    dicDat = @{@"userId":kUserID,@"schoolName":_schoolName.text,@"communitIntro":_textView.text,@"email":_email.text,@"address":_address.text,@"wechat":_wechat.text,@"quantity":_quantity.text,@"introduceName":_introduceName.text,@"presidentName":_presidentName.text,@"phone":_phone.text,@"qq":_qq.text,@"teacher":_teacher.text,@"communityName":_communityName.text};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//初始化请求对象
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置服务器允许的请求格式内容
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json", @"text/javascript,multipart/form-data", nil];
    //上传图片/文字，只能同POST
    [manager POST:@"http://118.190.60.67:8100/api/community/new?" parameters:dicDat constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 注意：这个name（我的后台给的字段是file）一定要和后台的参数字段一样 否则不成功
        [formData appendPartWithFileData:self.imageData name:@"FileImage" fileName:@"aaa.png" mimeType:@"image/png"];
  
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress = %@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject = %@, task = %@",responseObject,task);
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"obj = %@",obj);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];    
    

}


@end
