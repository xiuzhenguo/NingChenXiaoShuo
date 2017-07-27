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

@end

@implementation NBWriteViewController

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
    
    self.content = @"解放军诶房间诶发房间诶反而<http://pic32.nipic.com/20130829/12906030_124355855000_2.png>解股东权益为广大一千万供大于求刀光枪影为广大一千万dwdewfwefwe放军诶房间诶发房间诶反而<http://pic32.nipic.com/20130829/12906030_124355855000_2.png>";
    [self setUpNavButtonUI];
    
    [self setUpNovelTitleUI];
    
    [self resetTextStyle];
    
    NSString *str3 = [self.content stringByReplacingOccurrencesOfString:@"<" withString:@"\n<"];
    NSString *str = [str3 stringByReplacingOccurrencesOfString:@">" withString:@">\n"];
    
    if (self.content!=nil) {
        [self setRichTextViewContent:str];
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
//    if (self.textView.textStorage.length>0) {
//        self.placeholderLabel.hidden=YES;
//    }
    
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
        NSAssert(NO, @"需要传入字符串");
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
     paragraphStyle.firstLineHeadIndent = 10.f;    /**首行缩进宽度*/
    NSDictionary *attributes =[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:self.font],NSFontAttributeName,self.fontColor,NSForegroundColorAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil ];
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

#pragma mark - 选择图片按钮事件
-(void) clickTitleButton {
    self.titleView = [[NBEditPhoneView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
    [self.view.window addSubview:self.titleView];
    // 记录图片位置
    self.pickerRange=self.textView.selectedRange;
    
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
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    //    // 保存图片至本地，方法见下文
    //    NSLog(@"img = %@",image);
    
    
    
    //图片添加后 自动换行
    [self setImageText:image withRange:self.pickerRange appenReturn:YES];
}



#pragma mark - 设置导航栏按钮
-(void) setUpNavButtonUI {
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = CGRectMake(0, 0, 80, 30);
    [self.leftBtn setImage:[UIImage imageNamed:@"返回-1"] forState:UIControlStateNormal];
    NSString *string = _textView.text;
    NSString *subString = @"\n";
    NSArray *array = [string componentsSeparatedByString:subString];
    NSInteger count = [array count] - 1;
    NSString *str3 = [_textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    NSLog(@"%@",str3);
//    NSString *str = [str3 stringByReplacingOccurrencesOfString:@">" withString:@">\n"];
    NSString *strlengh = [NSString stringWithFormat:@"%lu字",(unsigned long)str3.length - count];
    [self.leftBtn setTitle:strlengh forState:UIControlStateNormal];
    NSLog(@"%@",self.textView.text);
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
    [rightBtn2 addTarget:self action:@selector(clickEditRightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn2.tag = 1001;
    
    UIButton *rightbtn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightbtn3 setImage:[UIImage imageNamed:@"后退"] forState:UIControlStateNormal];
    [rightbtn3 addTarget:self action:@selector(clickEditRightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightbtn3.tag = 1002;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn1];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:rightBtn2];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:rightbtn3];
    self.navigationItem.rightBarButtonItems = @[item1,item2,item3];
}

-(void) clickEditRightButton:(UIButton *)btn {
    NSLog(@"%@",self.locationStr);
}


#pragma mark - 右侧完成按钮的点击事件
-(void) clickRightButton:(UIButton *)btn {
    if (btn.tag == 1001) {
//        [self clickTitleButton];
        self.textView.text = @"fwehehfuwehfuwheufwe";
    }else if (btn.tag == 1002){
        self.fontView = [[NBXieXieFontView alloc] initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH)];
        [self.view addSubview:self.fontView];
        [self.fontView.addFontBtn addTarget:self action:@selector(clickAddFontButton) forControlEvents:UIControlEventTouchUpInside];
        [self.fontView.subFontBtn addTarget:self action:@selector(clickSubFontButton) forControlEvents:UIControlEventTouchUpInside];
    }else{
        self.textView.font = [UIFont systemFontOfSize:21];
        
        [self uploadData:[_textView.attributedText getPlainString] withImageArray:[_textView.attributedText getImgaeArray]];

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
    //这是选择完图片一次性上传，可能会慢,.另一种就是在用户选择图片的时候就上传，这种方法大家可以考虑
    //1.先上传图片
    
    //2.模拟上传
    /*
     
     这个时候重新组装数据，吧image替换成url
     
     来代替的图片地址
     http://pic32.nipic.com/20130829/12906030_124355855000_2.png
     http://pic55.nipic.com/file/20141208/19462408_171130083000_2.jpg
     http://pic36.nipic.com/20131217/6704106_233034463381_2.jpg
     http://img05.tooopen.com/images/20140604/sy_62331342149.jpg
     http://img05.tooopen.com/images/20150531/tooopen_sy_127457023651.jpg
     http://pic44.nipic.com/20140721/11624852_001107119409_2.jpg
     
     */
    
    
    //比如这是服务器返回的数据
    NSArray * urlarr=@[@"<http://pic32.nipic.com/20130829/12906030_124355855000_2.png>",
                       @"<http://pic32.nipic.com/20130829/12906030_124355855000_2.png>",
                       @"<http://pic32.nipic.com/20130829/12906030_124355855000_2.png>",
                       @"<http://pic32.nipic.com/20130829/12906030_124355855000_2.png>",
                       @"<http://pic32.nipic.com/20130829/12906030_124355855000_2.png>",
                       @"<http://pic32.nipic.com/20130829/12906030_124355855000_2.png>"
                       ];
    
    
    //这里是把字符串分割成数组，
    NSArray * strArr=[contentData  componentsSeparatedByString:RICHTEXT_IMAGE];
    
    NSString * newContent=@"";
    for (int i=0; i<strArr.count; i++) {
        
        NSString * imgTag=@"";
        if (i<strArr.count-1) {
            //这是用url 地址替换 图片标示 imgTag=urlarr[i];
            imgTag=urlarr[i%6];
            NSLog(@"图片顺序比对地址－－－%@",urlarr[i%6]);
        }
        
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
    self.textView.font = [UIFont systemFontOfSize:self.font];
    [self setEditNavButton];
    return textView;
}

#pragma mark - 编辑完成事的点击事件
- (void)textViewDidEndEditing:(UITextView *)textView{
    [self setUpNavButtonUI];
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    
}


#pragma mark - 返回按钮的实现方法
-(void)leftNavBtnAction:(UIButton *)btn{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
