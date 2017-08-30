//
//  TReaderBook.m
//  TBookReader
//
//  Created by tanyang on 16/1/21.
//  Copyright © 2016年 Tany. All rights reserved.
//

#import "TReaderBook.h"

@interface TReaderBook ()

@end

@implementation TReaderBook

- (BOOL)haveNextChapter
{
    return _totalChapter > _curChpaterIndex;
}

- (BOOL)havePreChapter
{
    return _curChpaterIndex > 1;
}

- (void)resetChapter:(TReaderChapter *)chapter
{
    _curChpaterIndex = chapter.chapterIndex;
}

- (TReaderChapter *)openBookWithChapter:(NSInteger)chapter
{
    TReaderChapter *readerChapter = [[TReaderChapter alloc]init];
    readerChapter.chapterIndex = chapter;
    _curChpaterIndex = chapter;
    NSError *error = nil;
//    NSString *chapter_num = [NSString stringWithFormat:@"Chapter%d",(int)chapter];
//    NSString *path1 = [[NSBundle mainBundle] pathForResource:chapter_num ofType:@"txt"];
//    readerChapter.chapterContent = [NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:&error];
    readerChapter.chapterTitle = @"测试";
    
    
    readerChapter.chapterContent = @" http://pic55.nipic.com/file/20141208/19462408_171130083000_2.jpg ehfuewhfuew复合物复合物鞥发货未付防护未婚夫未婚夫为副本维护费并未恢复为复合物复合物额伏虎额无法回味付宏伟䦹倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位 http://pic32.nipic.com/20130829/12906030_124355855000_2.png 富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业 http://img05.tooopen.com/images/20140604/sy_62331342149.jpg 发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物倒果为因丰功伟业发个语文发给我二月份护卫舰覅文件复合物复合物分为虎父或微发分为虎父或微符号位富比我还付额外 范围护肤和五类复合物额范围和复合物";
    
    if (error) {
        NSLog(@"open book chapter error:%@",error);
        return nil;
    }
    return readerChapter;
}

- (TReaderChapter *)openBookNextChapter
{
    return [self openBookWithChapter:_curChpaterIndex+1];
}

- (TReaderChapter *)openBookPreChapter
{
    return [self openBookWithChapter:_curChpaterIndex-1];
}

@end
