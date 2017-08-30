//
//  NBWriteViewController.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/22.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBWriteViewController.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"
#import "utility.h"
#import "PictureModel.h"
#import "NBEditPhoneView.h"
#import "NBXieXieFontView.h"
#import "NCWriteHelper.h"
#import "SectionListModel.h"

//Image default max size，图片显示的最大宽度
#define IMAGE_MAX_SIZE (100)

#define DefaultFont (16)
#define MaxLength (2000)

@interface NBWriteViewController ()<UIScrollViewDelegate, UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NBEditPhoneView *titleView;
@property (nonatomic, strong) NBXieXieFontView *fontView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic,assign) NSRange pickerRange;  //记录选择图片的位置
//设置
@property (nonatomic,assign) NSRange newRange;     //记录最新内容的range
@property (nonatomic,strong) NSString * newstr;    //记录最新内容的字符串
@property (nonatomic,assign) BOOL isBold;          //是否加粗
@property (nonatomic,strong) UIColor * fontColor;  //字体颜色
@property (nonatomic,assign) CGFloat  font;        //字体大小
@property (nonatomic,assign) NSUInteger location;  //纪录变化的起始位置
//纪录变化时的内容，即是
@property (nonatomic,strong) NSMutableAttributedString * locationStr;
@property (nonatomic,assign) CGFloat lineSapce;    //行间距
@property (nonatomic,assign) BOOL isDelete;        //是否是回删
@property (assign,nonatomic) NSUInteger finishImageNum;//纪录图片下载完成数目
@property (assign,nonatomic) NSUInteger apperImageNum; //纪录图片将要下载数目

@property (nonatomic, strong) NCWriteHelper *helper;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger btnInt;
@property (nonatomic, assign) NSInteger cishu;

@end

@implementation NBWriteViewController

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
    self.navigationController.navigationBar.barTintColor = BXColor(236,105,65);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    //    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.contentSize = CGSizeMake(BXScreenW, BXScreenH - 64);
    [self.view addSubview:self.scrollView];
    
    self.font = 16;
    
    self.houtuiArray = [[NSMutableArray alloc] init];
    self.qianjinArray = [[NSMutableArray alloc] init];
    
    [self setUpNovelTitleUI];
    
    [self resetTextStyle];
    
    if (self.typeInt != 2) {
        self.content = @"编辑章节内容";
        self.textView.text = self.content;
        [self setRichTextViewContent:self.content];
    }else{
    
        [self getNovelSectionContentData];
    }
    
    [self setUpNavButtonUI];
    
}

#pragma mark - 文章标题的UI设置
-(void) setUpNovelTitleUI {
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, BXScreenW - 15, 43.5)];
    self.textField.placeholder = @"章节标题";
    self.textField.font = SIXFont;
    self.textField.textColor = BXColor(152,152,152);
    [self.scrollView addSubview:self.textField];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 43.5, BXScreenW, 0.5)];
    line.backgroundColor = BXColor(195,195,195);
    [self.scrollView addSubview:line];
}

- (void)resetTextStyle {
    //After changing text selection, should reset style.
    [self CommomInit];
    NSRange wholeRange = NSMakeRange(0, _textView.textStorage.length);
    
    
    [_textView.textStorage removeAttribute:NSFontAttributeName range:wholeRange];
    [_textView.textStorage removeAttribute:NSForegroundColorAttributeName range:wholeRange];
    
    //字体颜色
    [_textView.textStorage addAttribute:NSForegroundColorAttributeName value:self.fontColor range:wholeRange];
    
    //字体加粗
    if (self.isBold) {
        [_textView.textStorage addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:self.font] range:wholeRange];
    }
    //字体大小
    else
    {
        
        [_textView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:self.font] range:wholeRange];
    }
    
}

#pragma mark - UITextView视图的创建
-(void)CommomInit
{
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 44, BXScreenW, BXScreenH - 44 - 64)];
    self.textView.delegate=self;
    //显示链接，电话
    self.textView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.textView.font=SIXFont;
    self.fontColor=[UIColor blackColor];
    self.location=0;
    self.isBold=NO;
    self.lineSapce=5;
    // 设置textView是否可编辑
//    self.textView.editable = NO;
    [self.scrollView addSubview:self.textView];
    
    [self setInitLocation];
}

//把最新内容都赋给self.locationStr
-(void)setInitLocation
{
    self.locationStr=nil;
    self.locationStr=[[NSMutableAttributedString alloc]initWithAttributedString:self.textView.attributedText];
}

#pragma mark  设置内容，二次编辑
-(void)setRichTextViewContent:(id)content
{
    if ([content isKindOfClass:[NSString class]]) {
        if (self.content!=nil) {
            
            NSMutableArray * modelArr=[NSMutableArray array];
            NSArray * imageOfWH=[content RXToArray];
            
            if (modelArr!=nil) {
                [modelArr removeAllObjects];
            }   
            //获取字符串中的图片
            for (NSDictionary * dict in imageOfWH) {
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    
                    PictureModel * model=[[PictureModel alloc]init];
                    model.imageurl=dict[@"src"];
                    model.width=[dict[@"width"] floatValue];;
                    model.height=[dict[@"height"] floatValue];
                    [modelArr addObject:model];
                }
            }
            
            [self setContentStr:[content RXToString] withImageArr:modelArr];
        }
    }
    else
    {
//        NSAssert(NO, @"需要传入字符串");
        
    }
}

-(void)setContentStr:(NSString *)contentStr withImageArr:(NSArray *)imageArr
{
    
    //1.显示文字内容
    NSMutableString * mutableStr=[[NSMutableString alloc]initWithString:contentStr];
    
    NSString * plainStr=[mutableStr stringByReplacingOccurrencesOfString:RICHTEXT_IMAGE withString:@"\n"];
    NSMutableAttributedString * attrubuteStr=[[NSMutableAttributedString alloc]initWithString:plainStr];
    //设置初始内容
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = self.lineSapce;// 字体的行间距
     paragraphStyle.firstLineHeadIndent = 30.f;    /**首行缩进宽度*/
    UIColor *textColor;
    if (self.typeInt != 2 && [self.textView.text isEqualToString:@"编辑章节内容"]) {
        textColor = [UIColor whiteColor];
    }else{
        textColor = self.fontColor;
    }
    NSDictionary *attributes =[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:self.font],NSFontAttributeName,textColor,NSForegroundColorAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil ];
    [attrubuteStr addAttributes:attributes range:NSMakeRange(0, attrubuteStr.length)];
    self.textView.attributedText =attrubuteStr;
    
    if (imageArr.count==0) {
        return;
    }
    
    self.apperImageNum=imageArr.count;
    self.finishImageNum=0;
    
    //2.这里是把字符串分割成数组，
    NSArray * strArr=[contentStr  componentsSeparatedByString:RICHTEXT_IMAGE];
    NSUInteger locLength=0;
    //替换带有图片标签的,设置图片
    for (int i=0; i<imageArr.count; i++) {
        
        NSString * locStr=[strArr objectAtIndex:i];
        
        
        locLength+=locStr.length;
        id image=[imageArr objectAtIndex:i];
        if ([image isKindOfClass:[UIImage class]]) {
            
            [self setImageText:image withRange:NSMakeRange(locLength+i, 1) appenReturn:NO];
        }
        else if([image isKindOfClass:[PictureModel class]])
        {
            PictureModel * model=(PictureModel *)image;
            [self downLoadImageWithUrl:model.imageurl                                                                                                                                                    WithRange:NSMakeRange(locLength+i, 1)];
        }
        else if([image isKindOfClass:[NSString class]])
        {
            [self downLoadImageWithUrl:(NSString *)image                                                                                                                                                    WithRange:NSMakeRange(locLength+i, 1)];
        }
        
    }
    
    //设置光标到末尾
    self.textView.selectedRange=NSMakeRange(self.textView.attributedText.length, 0);
    
}

#pragma mark - 设置图片
-(void)setImageText:(UIImage *)img withRange:(NSRange)range appenReturn:(BOOL)appen
{
    UIImage * image=img;
    
    if (image == nil)
    {
        return;
    }
    
    if (![image isKindOfClass:[UIImage class]])           // UIImage资源
    {
        
        return;
    }
    
    CGFloat ImgeHeight=image.size.height*(BXScreenW - 10)/image.size.width;
    
    ImageTextAttachment *imageTextAttachment = [ImageTextAttachment new];
    
    //Set tag and image
    imageTextAttachment.imageTag = RICHTEXT_IMAGE;
    imageTextAttachment.image =image;
    
    //Set image size
    imageTextAttachment.imageSize = CGSizeMake(BXScreenW - 10, ImgeHeight);
    
    
    if (appen) {
        NSAttributedString * imageAtt=[self appenReturn:[NSAttributedString attributedStringWithAttachment:imageTextAttachment]];
        //Insert image image-
        [_textView.textStorage insertAttributedString:imageAtt
                                              atIndex:range.location];
    }
    else
    {
        if (_textView.textStorage.length>0) {
            
            //replace image image-二次编辑
            [_textView.textStorage replaceCharactersInRange:range withAttributedString:[NSAttributedString attributedStringWithAttachment:imageTextAttachment]];
        }
        
    }
    
    //Move selection location
    _textView.selectedRange = NSMakeRange(range.location + 1, range.length);
    
    //设置locationStr的设置
    [self setInitLocation];
    
}

-(void)downLoadImageWithUrl:(NSString *)url WithRange:(NSRange)range
{
    
    if ([[SDImageCache sharedImageCache] diskImageExistsWithKey:url]==NO) {
        __weak typeof(self) weakSelf=self;
        SDWebImageDownloader *manager = [SDWebImageDownloader sharedDownloader];
        
        [manager downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if(finished)
            {
                self.finishImageNum++;
                
                if (self.finishImageNum==self.apperImageNum) {
                    
                }
                
                [[SDWebImageManager sharedManager] saveImageToCache:image forURL:[NSURL URLWithString:url]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [weakSelf setImageText:image withRange:range appenReturn:NO];
                });
            }
            else
            {
                
            }
        }];
    }
    else
    {
        UIImage * image=[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
        [self setImageText:image withRange:range appenReturn:NO];
    }
}

#pragma mark - 添加图片的时候前后自动换行
-(NSAttributedString *)appenReturn:(NSAttributedString*)imageStr
{
    NSAttributedString * returnStr=[[NSAttributedString alloc]initWithString:@"\n"];
    NSMutableAttributedString * att=[[NSMutableAttributedString alloc]initWithAttributedString:imageStr];
    [att appendAttributedString:returnStr];
    [att insertAttributedString:returnStr atIndex:0];
    
    return att;
}

#pragma mark - 设置导航栏按钮
-(void) setUpNavButtonUI {
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 80, 30);
    [self.leftBtn setImage:[UIImage imageNamed:@"返回-1"] forState:UIControlStateNormal];
    
    NSString *str3 = [_textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSString *strlengh = @"";
    if (self.typeInt != 2 && [self.textView.text isEqualToString:@"编辑章节内容"]) {
        strlengh = [NSString stringWithFormat:@"0字"];
    }else{
        strlengh = [NSString stringWithFormat:@"%lu字",(unsigned long)str3.length];
        
    }
    
    [self.leftBtn setTitle:strlengh forState:UIControlStateNormal];
    
    [self.leftBtn addTarget:self action:@selector(leftNavBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    self.navigationItem.leftBarButtonItem = item;
    
    UIButton *rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.frame = CGRectMake(0, 0, 40, 30);
    [rightBtn1 setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn1 addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn1.tag = 1000;
    
    UIButton *rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn2.frame = CGRectMake(0, 0, 40, 30);
    [rightBtn2 setImage:[UIImage imageNamed:@"预览"] forState:UIControlStateNormal];
    [rightBtn2 addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn2.tag = 1001;
    
    UIButton *rightbtn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightbtn3 setTitle:@"Aa" forState:UIControlStateNormal];
    [rightbtn3 addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightbtn3.tag = 1002;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn1];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn2];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:rightbtn3];
    self.navigationItem.rightBarButtonItems = @[item1,item2,item3];
    
}

#pragma mark - 编辑时导航栏按钮的设置
-(void) setEditNavButton {
    UIButton *rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn1.frame = CGRectMake(0, 0, 40, 30);
    [rightBtn1 setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn1 addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn1.tag = 1000;
    
    UIButton *rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn2.frame = CGRectMake(0, 0, 40, 30);
    [rightBtn2 setImage:[UIImage imageNamed:@"前进"] forState:UIControlStateNormal];
    [rightBtn2 addTarget:self action:@selector(clickEditRight:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn2.tag = 1001;
    self.btnInt = 1;
    
    UIButton *rightbtn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightbtn3 setImage:[UIImage imageNamed:@"后退"] forState:UIControlStateNormal];
    [rightbtn3 addTarget:self action:@selector(clickEditRightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightbtn3.tag = 1002;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn1];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn2];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:rightbtn3];
    self.navigationItem.rightBarButtonItems = @[item1,item2,item3];
}

#pragma mark - 后退按钮的点击事件
-(void) clickEditRightButton:(UIButton *)btn {
    if ((self.btnInt - self.cishu == 1 || self.btnInt - self.cishu == 2) && self.textView.text.length != 0) {
        NSString *str = self.textView.text;
        
        if (![self.textView.text isEqualToString:@""]) {
            [self.houtuiArray addObject:str];
        }
        if (self.houtuiArray.count > 1) {
            if (self.btnInt - self.cishu == 1) {
                self.textView.text = self.houtuiArray[self.houtuiArray.count - 2];
            }else if (self.btnInt - self.cishu == 2){
                self.textView.text = self.houtuiArray[self.houtuiArray.count - 3];
            }
            
        }else{
            if (self.typeInt == 2) {
                SectionListModel *model = self.dataArray.firstObject;
                self.textView.text = model.SectionContent;
            }else{
                self.textView.text = @"";
            }
        }
        self.btnInt = self.btnInt + 1;
        NSString *str3 = [_textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        NSString *strlengh = [NSString stringWithFormat:@"%lu字",(unsigned long)str3.length];
        [self.leftBtn setTitle:strlengh forState:UIControlStateNormal];
        
    }
    
}

#pragma mark - 前进按钮的点击事件
-(void) clickEditRight:(UIButton *)btn {
    if (self.btnInt != 1 && (self.btnInt - self.cishu == 2 || self.btnInt - self.cishu == 3)) {
        if (self.btnInt - self.cishu == 2) {
            self.textView.text = self.houtuiArray.lastObject;
        }else if (self.btnInt - self.cishu == 1 && self.btnInt != 2){
            self.textView.text = self.houtuiArray[self.houtuiArray.count - 2];
        }else if(self.btnInt == 2){
            return;
        }
        
        NSString *str3 = [_textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        NSString *strlengh = [NSString stringWithFormat:@"%lu字",(unsigned long)str3.length];
        self.cishu = self.cishu + 1;
        [self.leftBtn setTitle:strlengh forState:UIControlStateNormal];
    }
}


#pragma mark - 右侧完成按钮的点击事件
-(void) clickRightButton:(UIButton *)btn {
    if (btn.tag == 1001) {
        self.textView.text = @"fwehehfuwehfuwheufwe";
    }else if (btn.tag == 1002){
        self.fontView = [[NBXieXieFontView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
        [self.view addSubview:self.fontView];
        [self.fontView.addFontBtn addTarget:self action:@selector(clickAddFontButton) forControlEvents:UIControlEventTouchUpInside];
        [self.fontView.subFontBtn addTarget:self action:@selector(clickSubFontButton) forControlEvents:UIControlEventTouchUpInside];
    }else{
//        [self uploadData:[_textView.attributedText getPlainString] withImageArray:[_textView.attributedText getImgaeArray]];
        if (self.typeInt != 2) {
            [self createNovelSectionContent];
        }else{
            [self changeNovelSectionData];
        }

    }
}                                                                                                                              

#pragma mark - 增大字体按钮的点击事件
-(void) clickAddFontButton {
    self.font ++;
    self.textView.font = [UIFont systemFontOfSize:self.font];
}

#pragma mark - 缩小字体按钮的点击事件
-(void) clickSubFontButton {
    self.font --;
    self.textView.font = [UIFont systemFontOfSize:self.font];
}

#pragma mark uploadData 上传服务器
- (void)uploadData:(id )contentData withImageArray:(NSArray *)imageArr
{
        //这里是把字符串分割成数组，
    NSArray * strArr=[contentData  componentsSeparatedByString:RICHTEXT_IMAGE];
    
    NSString * newContent=@"";
    for (int i=0; i<strArr.count; i++) {
        
        NSString * imgTag=@"";
        
        //因为cutstr 可能是null
        NSString * cutStr=[strArr objectAtIndex:i];
        newContent=[NSString stringWithFormat:@"%@%@%@",newContent,cutStr,imgTag];
        
    }
    
    
    //上传服务器
    _jsonString=newContent;
    
    NSLog(@"jsonString--%@",_jsonString);
    
}

#pragma mark - 开始编辑的时候的点击事件
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([self.textView.text isEqualToString:@"编辑章节内容"]) {
        self.textView.text = @"";
    }
    self.textView.textColor = [UIColor blackColor];
    self.textView.font = [UIFont systemFontOfSize:self.font];
    [self setEditNavButton];
    return YES;
}

#pragma mark - 编辑完成事的点击事件
- (void)textViewDidEndEditing:(UITextView *)textView{
    [self setUpNavButtonUI];
}


#pragma mark - textView的代理方法
- (void)textViewDidChange:(UITextView *)textView
{
    NSString *str3 = [textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSString *strlengh = [NSString stringWithFormat:@"%lu字",(unsigned long)str3.length];
    [self.leftBtn setTitle:strlengh forState:UIControlStateNormal];
}


#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 获取章节内容
-(void) getNovelSectionContentData {
    [self.helper PreviewNovelSectionWithSectionid:self.sectionID success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            self.dataArray = [[NSMutableArray alloc] init];
            
            SectionListModel *model = [SectionListModel mj_objectWithKeyValues:response];
            [self.dataArray addObject:model];
            
            [self.view hideHubWithActivity];
            [self.view hidEmptyDataView];
            [self.view hidFailedView];

            self.textField.text = model.SectionName;
            self.content = model.SectionContent;
            [self setRichTextViewContent:self.content];
            [self.houtuiArray addObject:model.SectionContent];
            
            NSString *str3 = [_textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSString *strlengh = [NSString stringWithFormat:@"%lu字",(unsigned long)str3.length];
            [self.leftBtn setTitle:strlengh forState:UIControlStateNormal];
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [self.view hideHubWithActivity];
        [self.view showFailedViewReloadBlock:^{
            [self getNovelSectionContentData];
        }];
    }];
}

#pragma mark - 新建章节功能的实现
-(void) createNovelSectionContent {
    if (self.textField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写标题"];
        return;
    }
    if ([self.textView.text isEqualToString:@"编辑章节内容"]) {
        [SVProgressHUD showErrorWithStatus:@"请填写章节内容"];
        return;
    }
    
    [self.helper createNewNovelSectionWithFictionId:self.ficID Title:self.textField.text Content:self.textView.text Remark:@"" success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:response];
            if (model.StatusCode == 200) {
                [SVProgressHUD showSuccessWithStatus:@"章节创建成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:model.Message];
            }
            
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"章节创建失败"];
    }];
}

#pragma mark - 修改章节
-(void)changeNovelSectionData {
    if (self.textField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写章节标题"];
        return;
    }
    if (self.textView.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写章节内容"];
        return;
    }
    
    [self.helper changeNovelSectionContentWithFictionId:self.ficID SectionId:self.sectionID Title:self.textField.text Content:self.textView.text Remark:@"" success:^(NSDictionary *response) {
        st_dispatch_async_main(^{
            
            ETHttpModel *model = [ETHttpModel mj_objectWithKeyValues:response];
            if (model.StatusCode == 200) {
                [SVProgressHUD showSuccessWithStatus:@"章节修改成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD showErrorWithStatus:model.Message];
            }
            
        });
        
        return ;
    } faild:^(NSString *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"章节修改失败"];
    }];
}

@end
