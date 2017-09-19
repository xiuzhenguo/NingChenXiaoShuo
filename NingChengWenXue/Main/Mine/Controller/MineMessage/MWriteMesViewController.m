//
//  MWriteMesViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/15.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "MWriteMesViewController.h"
#import "MRecPerViewController.h"
#import "BCWelcomHepler.h"

@interface MWriteMesViewController ()<UIScrollViewDelegate, UITextViewDelegate, UITextFieldDelegate, SelectPersonDelegate>

@property (nonatomic, strong) TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, strong) UITextField *nameText;
@property (nonatomic, strong) UITextField *titleText;
@property (nonatomic, strong) UITextView *conTextView;
@property (nonatomic, strong) NSString *userid;
@property (strong, nonatomic) BCWelcomHepler *helper;

@end

@implementation MWriteMesViewController

-(BCWelcomHepler *)helper{
    if (!_helper) {
        _helper = [BCWelcomHepler helper];
    }
    return _helper;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpScrollViewUI];
    
    [self setUpUITextFieldUI];
    
    [self setUpTextViewUI];
    
    [self setUpSendButtonUI];
}

-(void) setUpScrollViewUI {
    self.scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 9, BXScreenW, BXScreenH - 64 - 39)];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = true;
    self.scrollView.contentSize = CGSizeMake(BXScreenW, BXScreenH-64-39);
    [self.view addSubview:self.scrollView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 239)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:backView];
}

-(void)setUpUITextFieldUI {
    NSArray *arr = @[@"收件人",@"标   题"];
    for (int i = 0; i < 2; i++) {
        
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 44*i, BXScreenW, 0.5)];
        lineLab.backgroundColor = BXColor(195,195,195);
        [self.scrollView addSubview:lineLab];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0.5+44*i, 60, 43.5)];
        lable.font = FIFFont;
        lable.textColor = BXColor(101,101,101);
        lable.text = arr[i];
        [self.scrollView addSubview:lable];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(85, 0.5+44*i, BXScreenW - 95, 43.5)];
        textField.font = FIFFont;
        textField.textColor = BXColor(40, 40, 40);
        textField.delegate = self;
        [self.scrollView addSubview:textField];
        if (i == 0) {
            self.nameText = textField;
            self.nameText.enabled = NO;
        }else{
            self.titleText = textField;
        }
    }
    
    UIButton *nameBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, 43)];
    nameBtn.backgroundColor = [UIColor clearColor];
    [nameBtn addTarget:self action:@selector(clickNameButton) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:nameBtn];
}

-(void) setUpTextViewUI {
    
    for (int i = 0; i < 2; i++) {
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 89+150*i, BXScreenW, 0.5)];
        lineLab.backgroundColor = BXColor(195,195,195);
        [self.scrollView addSubview:lineLab];
    }
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 89.5, BXScreenW, 43.5)];
    nameLab.font = FIFFont;
    nameLab.textColor = BXColor(101,101,101);
    nameLab.text = @"内   容";
    [self.scrollView addSubview:nameLab];
    
    self.conTextView = [[UITextView alloc] initWithFrame:CGRectMake(85, 89.5, BXScreenW - 95, 149.5)];
    self.conTextView.delegate = self;
    self.conTextView.font = FIFFont;
    self.conTextView.textColor = BXColor(40, 40, 40);
    [self.scrollView addSubview:self.conTextView];
}

-(void) setUpSendButtonUI {
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 270, BXScreenW - 30, 44)];
    sendBtn.backgroundColor = BXColor(236,105,65);
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    sendBtn.layer.cornerRadius = 5;
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(clickSendButton) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:sendBtn];
}

-(void) clickNameButton {
    MRecPerViewController *vc = [[MRecPerViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 选择收件人后回调
-(void)selectPersonDelegate:(NSString *)userID Name:(NSString *)userName{
    self.nameText.text = userName;
    self.userid = userID;
}

-(void) clickSendButton{
    if (self.userid.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择收件人"];
        return;
    }
    if (self.titleText.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入标题"];
        return;
    }
    if (self.conTextView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写内容"];
        return;
    }
    [self.helper wirteMessageWithUserId:kUserID ReceiveId:self.userid ReceiveName:self.nameText.text MsgGene:@"3" Title:self.titleText.text Content:self.conTextView.text success:^(NSDictionary *response) {
        
        st_dispatch_async_main(^{
            
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        return ;
        
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
    }];
}

@end
