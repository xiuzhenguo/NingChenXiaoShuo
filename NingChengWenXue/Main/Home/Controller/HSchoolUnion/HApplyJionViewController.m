//
//  HApplyJionViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HApplyJionViewController.h"
#import "NCHomePageHelper.h"

@interface HApplyJionViewController ()<UIScrollViewDelegate, UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *QQField;
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, strong) UILabel *numLab;
@property (strong, nonatomic) NCHomePageHelper *helper;

@end

@implementation HApplyJionViewController

-(NCHomePageHelper *)helper{
    if (!_helper) {
        _helper = [NCHomePageHelper helper];
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
    self.title = @"申请加入文学社";
    
    [self setUpNavButtonUI];
    
    [self setupScrollViewUI];
}

#pragma mark - 创建ScrollView
-(void) setupScrollViewUI {
    
    self.scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH-64)];
    self.scrollView.backgroundColor = BXColor(242, 242, 242);
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(BXScreenW, BXScreenH+64);
    [self.view addSubview:self.scrollView];
    
    [self setUpHeaderIntruduceUI];
    
    [self setUpTimeAndNameUI];
    
    [self setUpClubsIntroductionUI];
    
    [self setUpFootCreateButtonUI];
}

#pragma mark - 创建头部介绍
-(void) setUpHeaderIntruduceUI {
    UILabel *intrLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, BXScreenW - 30, 35)];
    intrLab.text = @"亲爱的同学，加入文学社，团长需要审核真是身份哦。您填写的资料我们会保密。";
    intrLab.numberOfLines = 0;
//    [intrLab sizeToFit];
    intrLab.font = THIRDFont;
    intrLab.textColor = BXColor(40,40,40);
    [self.scrollView addSubview:intrLab];
}

#pragma mark - 创建入学年份、姓名、QQ
-(void) setUpTimeAndNameUI {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, BXScreenW, 44*3)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:backView];
    
    NSArray *array = @[@"入学年份",@"真实姓名",@"QQ号"];
    NSArray *placeholderArr = @[@"请填写入学年份",@"请填写真实姓名",@"输入QQ号"];
    for (int i = 0; i < 3; i++) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(15, 43.5*i, 85, 43.5)];
        lable.text = array[i];
        lable.textColor = BXColor(40,40,40);
        lable.font = FIFFont;
        [backView addSubview:lable];
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 43.5+44*i, BXScreenW, 0.5)];
        lineLab.backgroundColor = BXColor(195,195,195);
        [backView addSubview:lineLab];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 43.5*i, BXScreenW - 140, 43.5)];
        textField.font = THIRDFont;
        textField.textColor = BXColor(152,152,152);
        textField.placeholder = placeholderArr[i];
        textField.tag = 1000+i;
        [backView addSubview:textField];
        if (i == 0) {
            self.textField = textField;
        }else if (i == 1){
            self.nameField = textField;
        }else{
            self.QQField = textField;
        }
    }
}

#pragma mark - 创建申请理由
-(void) setUpClubsIntroductionUI {
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 44*3+80, BXScreenW - 30, 15)];
    nameLab.textColor = BXColor(101,101,101);
    nameLab.text = @"申请理由（300字以内）";
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
    
    self.numLab = [[UILabel alloc] initWithFrame:CGRectMake(BXScreenW - 75, CGRectGetMaxY(_textView.frame)+10, 50, 15)];
    self.numLab.textAlignment = NSTextAlignmentRight;
    self.numLab.textColor = BXColor(152, 152, 152);
    self.numLab.text = @"0/300";
    self.numLab.font = ELEFont;
    [self.scrollView addSubview:self.numLab];
}

#pragma mark - 创建底部提交按钮
-(void) setUpFootCreateButtonUI {
    UIButton *createBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.textView.frame)+20, BXScreenW - 30, 44)];
    [createBtn setTitle:@"提交" forState:UIControlStateNormal];
    createBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    createBtn.backgroundColor = BXColor(236,105,65);
    createBtn.layer.cornerRadius = 5;
    [createBtn addTarget:self action:@selector(clickCreateButton) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark - 拖动scrollView 时失去第一响应者
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.textField resignFirstResponder];
    [self.textView resignFirstResponder];
    [self.view endEditing:YES];
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

#pragma mark - 申请加入请求
-(void) clickCreateButton {
    if (self.textField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写入学年份"];
        return;
    }
    if (self.nameField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写真实姓名"];
        return;
    }
    if (self.textField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写QQ号"];
        return;
    }
    if (self.textField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写申请理由"];
        return;
    }
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper applyjoinCommunityWithUserId:kUserID CommunityId:self.comId QQ:self.QQField.text Year:self.textField.text Name:self.nameField.text Reason:self.textView.text success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            [SVProgressHUD showSuccessWithStatus:@"成功"];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"失败"];
    }];
}

@end
