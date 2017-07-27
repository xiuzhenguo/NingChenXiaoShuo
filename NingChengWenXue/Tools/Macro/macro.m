//
//  macro.m
//
//  Created by yls on 14-5-4.
//  Copyright (c) 2014年 yls. All rights reserved.
//
//  iOS 相关宏定义
//

/** 全局线程执行方法 */
void st_dispatch_async_global(dispatch_block_t block)
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

/** 主线程执行方法 */
void st_dispatch_async_main(dispatch_block_t block)
{
    dispatch_async(dispatch_get_main_queue(), block);
}

/** 主线程延时执行方法 */
void st_dispatch_async_main_after(NSTimeInterval ti, dispatch_block_t block)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ti * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

/** 根据给定字体计算单位高度 */
CGFloat UnitHeightOfFont(UIFont*font)
{
    CGSize maxSize = CGSizeMake(100, 100);
    CGSize unitSize =  CGSizeOfString(@"单位",maxSize,font);
    return unitSize.height;
}

/** 根据字符串、最大尺寸、字体计算字符串最合适尺寸 */
CGSize CGSizeOfString(NSString * text, CGSize maxSize, UIFont * font)
{
    CGSize fitSize;
    if (text.length==0 || !text) {
        fitSize = CGSizeMake(0, 0);
    }else{
        fitSize = [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
    }
    return fitSize;
}

/** 设置视图大小，原点不变 */
void SetViewSize(UIView *view, CGSize size)
{
    CGRect frame = view.frame;
    frame.size = size;
    view.frame = frame;
}

/** 设置视图宽度，其他不变 */
void SetViewSizeWidth(UIView *view, CGFloat width)
{
    CGRect frame = view.frame;
    frame.size.width = width;
    view.frame = frame;
}

/** 设置视图高度，其他不变 */
void SetViewSizeHeight(UIView *view, CGFloat height)
{
    CGRect frame = view.frame;
    frame.size.height = height;
    view.frame = frame;
}

/** 设置视图原点，大小不变 */
void SetViewOrigin(UIView *view, CGPoint pt)
{
    CGRect frame = view.frame;
    frame.origin = pt;
    view.frame = frame;
}

/** 设置视图原点x坐标，大小不变 */
void SetViewOriginX(UIView *view, CGFloat x)
{
    CGRect frame = view.frame;
    frame.origin.x = x;
    view.frame = frame;
}

/** 设置视图原点y坐标，大小不变 */
void SetViewOriginY(UIView *view, CGFloat y)
{
    CGRect frame = view.frame;
    frame.origin.y = y;
    view.frame = frame;
}

void setSubviewDelaysContentTouchesNO(UIView * v)
{
    if ([v isKindOfClass:[UIScrollView class]] || [NSStringFromClass([v class]) isEqualToString:@"UITableViewCellScrollView"]) {
        if ([v respondsToSelector:@selector(setDelaysContentTouches:)]) {
            ((UIScrollView *)v).delaysContentTouches = NO;
        }
    }
    for (UIView *obj in v.subviews)
    {
        setSubviewDelaysContentTouchesNO(obj);
    }
}

UIImage * CreateImageWithColor(UIColor *color)
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

UIImage* FileImageWithFileType(NSString *type)
{
    UIImage *image ;
    
    // mp3
    if ([type isEqualToString:@".mp3"] ||
        [type isEqualToString:@"mp3"]) {
        image = [UIImage imageNamed:@"audio_play"];
    }
    
    // mp4
    else if ([type isEqualToString:@".mp4"] ||
             [type isEqualToString:@"mp4"] ||
             [type isEqualToString:@".mov"] ||
             [type isEqualToString:@"mov"]) {
        image = [UIImage imageNamed:@"chat_more_video"];
    }
    
    // Word
    else if ([type isEqualToString:@".docx"] ||
             [type isEqualToString:@"docx"]  ||
             [type isEqualToString:@".doc"]  ||
             [type isEqualToString:@"doc"]) {
        image = [UIImage imageNamed:@"word"];
    }
    
    // Excel
    else if ([type isEqualToString:@".xlsx"] ||
             [type isEqualToString:@"xlsx"]  ||
             [type isEqualToString:@".xls"]  ||
             [type isEqualToString:@"xls"]) {
        image = [UIImage imageNamed:@"xls"];
    }
    
    // PPT
    else if ([type isEqualToString:@".pptx"] ||
             [type isEqualToString:@"pptx"]  ||
             [type isEqualToString:@".ppt"]  ||
             [type isEqualToString:@"ppt"]) {
        image = [UIImage imageNamed:@"ppt"];
    }
    
    // pdf
    else if ([type isEqualToString:@".pdf"] ||
             [type isEqualToString:@"pdf"] ) {
        image = [UIImage imageNamed:@"pdf"];
    }
    
    // txt
    else if ([type isEqualToString:@".txt"] ||
             [type isEqualToString:@"txt"]){
        image = [UIImage imageNamed:@"txt"];
    }
    
    // png/jpg
    else if([type isEqualToString:@".png"] ||
            [type isEqualToString:@"png"]  ||
            [type isEqualToString:@".jpg"] ||
            [type isEqualToString:@"jpg"] ||
            [type isEqualToString:@".jpeg"] ||
            [type isEqualToString:@"jpeg"]){
        image = [UIImage imageNamed:@"image"];
    }
    
    // 问号
    else{
        image = [UIImage imageNamed:@"wenhao"];
    }
    
    return image;
}


#pragma mark - 可变参数格式化
NSString* StringWithFormat(NSString*format,...)
{
    if (!format || format.length==0) {
        return nil;
    }
    //指向变参的指针
    va_list list;
    //使用第一个参数来初使化list指针
    va_start(list, format);
    NSString *str = [[NSString alloc] initWithFormat:format arguments:list];
    //结束可变参数的获取
    va_end(list);
    return str;
}
