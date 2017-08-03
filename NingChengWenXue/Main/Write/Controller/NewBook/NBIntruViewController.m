//
//  NBIntruViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/8.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBIntruViewController.h"
#import "NCWriteHelper.h"

@interface NBIntruViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITextView *placeholder;
@property (nonatomic, strong) UILabel *numLab;
@property (strong, nonatomic) NCWriteHelper *helper;

@end

@implementation NBIntruViewController

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"作品简介";
    
    [self setUpTextView];
    
    [self setUpNavButtonUI];
    
    self.numLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 195, BXScreenW - 15, 20)];
    self.numLab.textAlignment = NSTextAlignmentRight;
    self.numLab.textColor = BXColor(152, 152, 152);
    self.numLab.text = @"0/500";
    [self.view addSubview:self.numLab];
    
}

-(void) setUpTextView {
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 10, BXScreenW - 30, 178)];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.scrollEnabled = YES;
    _textView.editable = YES;
    _textView.delegate = self;
    _textView.textColor = BXColor(152, 152, 152);
    _textView.font = FIFFont;
    _textView.text = self.introduceStr;
    _textView.returnKeyType = UIReturnKeyNext;
    _textView.layer.borderWidth = 0.5;
    _textView.layer.borderColor = BXColor(195, 195, 195).CGColor;
    
    self.placeholder = [[UITextView alloc] initWithFrame:CGRectMake(15, 10, BXScreenW - 30, 178)];
    self.placeholder.backgroundColor = [UIColor whiteColor];
    self.placeholder.scrollEnabled = YES;
    self.placeholder.editable = YES;
    self.placeholder.delegate = self;
    self.placeholder.textColor = BXColor(152, 152, 152);
    self.placeholder.font = FIFFont;
    [self.view addSubview:self.placeholder];
    self.placeholder.returnKeyType = UIReturnKeyDone;
    self.placeholder.text = @"作品简介500字以内哦！";
    [self.view addSubview:self.textView];
    if (self.introduceStr.length == 0) {
        self.placeholder.hidden = NO;
    }else{
        self.placeholder.hidden = YES;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text  isEqual: @"\n"]) {
//        [textView resignFirstResponder];
        return YES;
    }
    if (![text  isEqual: @""]) {
        self.placeholder.hidden = YES;
        return YES;
    }
    if ([text  isEqual: @""] && range.location == 0 && range.length == 1) {
        self.placeholder.hidden = NO;
        return YES;
    }
    
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
    self.numLab.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,existTextNum),500];
    
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
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    if (self.newType == 1) {
        [rightBtn addTarget:self action:@selector(clickRightButtonOne) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [rightBtn addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
}

#pragma mark - 右侧完成按钮的点击事件
-(void) clickRightButton {
    [self.view showHudWithActivity:@"正在加载"];
    [self.helper novelIntroWithFictionId:self.bookId Intro:self.textView.text success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            [self.view hideHubWithActivity];
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [SVProgressHUD showErrorWithStatus:@"失败"];
    }];
}

#pragma mark - 新建作品简介
-(void) clickRightButtonOne {
    if (self.textView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写简介"];
        return;
    }
    [self.delegate writeIntro:self.textView.text];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
