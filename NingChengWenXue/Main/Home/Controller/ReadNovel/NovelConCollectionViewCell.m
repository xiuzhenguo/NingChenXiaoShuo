//
//  NovelConCollectionViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/8/24.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NovelConCollectionViewCell.h"

@implementation NovelConCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentLab = [[TYAttributedLabel alloc] init];
        self.contentLab.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.contentLab];
        
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.font = [UIFont boldSystemFontOfSize:18];
        self.titleLab.textColor = [UIColor blackColor];
        //        headLab.textAlignment = NSTextAlignmentCenter;
//        [self.contentView addSubview:self.titleLab];
    }
    return self;
}

//- (void)getNovelRow:(NSInteger)row Title:(NSString *)title Content:(NSAttributedString *)content{
//    for (UIView *view in self.contentView.subviews) {
//        view.frame = CGRectZero;
//    }
//  
//    self.contentLab.attributedText = content;
//    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
//    NSUInteger fontsize = [TReaderManager fontSize];
//    paraStyle01.headIndent = 0.0f;//行首缩进
//    CGFloat emptylen = fontsize * 2;
//    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
//    paraStyle01.lineSpacing = 5;
//    paraStyle01.tailIndent = 0.0f;
//    
//    NSDictionary *attributeDic = @{
//                                   NSFontAttributeName : [UIFont systemFontOfSize:fontsize],
//                                   
//                                   NSParagraphStyleAttributeName : paraStyle01,
//                                   
//                                   NSForegroundColorAttributeName : BXColor(92,66,69)
//                                   
//                                   };
//    
//    self.contentLab.attributedText = [[NSAttributedString alloc] initWithString:self.contentLab.text attributes:attributeDic];
//    self.contentLab.numberOfLines = 0;
//    
//    
//    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontsize], NSParagraphStyleAttributeName:paraStyle01, NSKernAttributeName:@1.0f};
//    CGSize size = [self.contentLab.text boundingRectWithSize:CGSizeMake(BXScreenW - 20, BXScreenH - 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
//
//    self.contentLab.frame = CGRectMake(15, 0, BXScreenW-20, size.height);
//    
//}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    self.contentLab.frame = CGRectMake(15, 0, BXScreenW - 20, self.contentView.frame.size.height);
    
}

@end
