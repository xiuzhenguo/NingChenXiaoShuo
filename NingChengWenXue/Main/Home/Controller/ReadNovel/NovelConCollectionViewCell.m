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
        
        self.label = [[TYAttributedLabel alloc] init];
        self.label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.label];
        
//        self.titleLab = [[UILabel alloc] init];
//        self.titleLab.font = [UIFont boldSystemFontOfSize:18];
//        self.titleLab.textColor = [UIColor blackColor];
//        //        headLab.textAlignment = NSTextAlignmentCenter;
//        [self.contentView addSubview:self.titleLab];
    }
    return self;
}

//- (void)getNovelRow:(NSInteger)row Title:(NSString *)title Content:(NSAttributedString *)content{
//    for (UIView *view in self.contentView.subviews) {
//        view.frame = CGRectZero;
//    }
//    if (row == 0) {
//        self.titleLab.frame = CGRectMake(15, 0, BXScreenW - 30, 40);
//        self.label.frame = CGRectMake(15, 40, BXScreenW - 30, self.contentView.frame.size.height-40);
//        
//    }else{
//        self.titleLab.frame = CGRectMake(15, 0, BXScreenW - 30, 0);
//        self.label.frame = CGRectMake(15, 0, BXScreenW - 30, self.contentView.frame.size.height);
//    }
//    self.titleLab.text = title;
//    self.label.attributedText = content;
//}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
//    self.titleLab.frame = CGRectMake(15, 0, BXScreenW - 30, 40);
    self.label.frame = CGRectMake(15, 0, BXScreenW - 30, self.contentView.frame.size.height);
    
}

@end
