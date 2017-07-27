//
//  HAutMedalCollectionViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAutMedalCollectionViewCell.h"

@implementation HAutMedalCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgView = [[UIImageView alloc] init];
        self.imgView.image = [UIImage imageNamed:@"打赏头像"];
        [self.contentView addSubview:self.imgView];
        self.imgView.layer.cornerRadius = self.contentView.frame.size.width/2.0;
        
        self.nameLab = [[UILabel alloc] init];
        self.nameLab.text = @"生肖猪勋章x2";
        self.nameLab.textColor = BXColor(40, 40, 40);
        [self.contentView addSubview:self.nameLab];
        self.nameLab.font = THIRDFont;
        self.nameLab.textAlignment = NSTextAlignmentCenter;
        NSRange range = [self.nameLab.text rangeOfString:@"x2"];
        [self setTextColor:self.nameLab FontNumber:THIRDFont AndRange:range AndColor:BXColor(236,105,65)];
        
        
    }
    return self;
}


-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    self.imgView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.width);
    self.nameLab.frame = CGRectMake(0, self.contentView.frame.size.width+5, self.contentView.frame.size.width, 13);
    
}

//设置不同字体颜色
-(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    label.attributedText = str;
}

@end
