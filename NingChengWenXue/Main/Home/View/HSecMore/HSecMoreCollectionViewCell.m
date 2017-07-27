//
//  HSecMoreCollectionViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/2.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HSecMoreCollectionViewCell.h"

@implementation HSecMoreCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgView = [[UIImageView alloc] init];
        self.imgView.image = [UIImage imageNamed:@"九鼎记"];
        [self.contentView addSubview:self.imgView];
        
        self.nameLab = [[UILabel alloc] init];
        self.nameLab.text = @"小说名称";
        self.nameLab.textColor = BXColor(40, 40, 40);
        [self.contentView addSubview:self.nameLab];
        self.nameLab.font = FIFFont;
        
    }
    return self;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    self.imgView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 140);
    self.nameLab.frame = CGRectMake(0, 145, self.contentView.frame.size.width, 15);
    
    
}

@end
