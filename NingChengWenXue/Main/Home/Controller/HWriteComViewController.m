//
//  HWriteComViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HWriteComViewController.h"
#import "NCHomePageHelper.h"


@interface HWriteComViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITextView *placeholder;
@property (nonatomic, strong) UILabel *numLab;
@property (nonatomic, strong) NSString *str;
@property (strong, nonatomic) NCHomePageHelper *helper;

@end

@implementation HWriteComViewController

-(NCHomePageHelper *)helper{
    if (!_helper) {
        _helper = [NCHomePageHelper helper];
    }
    return _helper;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"写评论";
    
    [self setUpTextView];
    
    [self setUpNavButtonUI];
    
    self.numLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 215, BXScreenW - 15, 20)];
    self.numLab.textAlignment = NSTextAlignmentRight;
    self.numLab.textColor = BXColor(152, 152, 152);
    self.numLab.text = @"0/500";
    [self.view addSubview:self.numLab];
    
    
}

-(void) setUpTextView {
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 10, BXScreenW - 30, 200)];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.scrollEnabled = YES;
    _textView.editable = YES;
    _textView.delegate = self;
    _textView.textColor = BXColor(152, 152, 152);
    _textView.font = FIFFont;
    _textView.returnKeyType = UIReturnKeyNext;
    _textView.layer.borderWidth = 0.5;
    _textView.layer.borderColor = BXColor(195, 195, 195).CGColor;
    
    self.placeholder = [[UITextView alloc] initWithFrame:CGRectMake(15, 10, BXScreenW - 30, 200)];
    self.placeholder.backgroundColor = [UIColor whiteColor];
    self.placeholder.scrollEnabled = YES;
    self.placeholder.editable = YES;
    self.placeholder.delegate = self;
    self.placeholder.textColor = BXColor(152, 152, 152);
    self.placeholder.font = FIFFont;
    [self.view addSubview:self.placeholder];
    self.placeholder.returnKeyType = UIReturnKeyDone;
    self.placeholder.text = @"请输入评论内容";
    [self.view addSubview:self.textView];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    
    if ([text  isEqual: @"\n"]) {
//        [textView resignFirstResponder];
//        self.str = [text stringByReplacingOccurrencesOfString:@"\n" withString:@"好"];
        
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
    leftBtn.frame = CGRectMake(0, 0, 100, 30);
    [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = item;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 100, 30);
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:BXColor(236,105,65) forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item1;
    
}

#pragma mark - 离线作品按钮的点击事件的实现
-(void)rightNavBtnAction:(UIButton *)sender{
    
//    self.textView.text = [self.textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
//    NSLog(@"啦啦啦啦%@",self.textView.text);
    
    [self uploadNovelReview];
}


#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 上传书评功能实现
-(void) uploadNovelReview {
    [self.view showHudWithActivity:@"正在加载"];
    __weak typeof(self)weakSelf = self;
    [self.helper addShuPingWithFictionId:self.bookID UserId:kUserID SectionId:self.secID Content:self.textView.text success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            [weakSelf.view hideHubWithActivity];
            ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:response];
            if (model.StatusCode == 200) {
                [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                NSDictionary *dic = @{@"PostClass":@1,@"SectionIndex":@0,@"IsApplaud":@0,@"Content":weakSelf.textView.text,@"SectionName":@"",@"Id":model.datas,@"AuthorName":@"修车",@"UserHeadImage":@"",@"Time":@"1秒前",@"Reply":@0,@"Applaud":@0};
                ShuPingListModel *model = [ShuPingListModel mj_objectWithKeyValues:dic];
                [weakSelf.delegate addShupingModel:model];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                
                [SVProgressHUD showErrorWithStatus:model.Message];
            }
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [weakSelf.view hideHubWithActivity];
        [SVProgressHUD showErrorWithStatus:@"添加失败"];
    }];
}



@end
