//
//  HMoreBtnCollectionViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/20.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HMoreBtnCollectionViewCell.h"

@implementation HMoreBtnCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.btn = [[UIButton alloc] init];
        
        [self.contentView addSubview:self.btn];
        [self.btn setTitleColor:BXColor(101, 101, 101) forState:UIControlStateNormal];
        self.btn.titleLabel.font = THIRDFont;

        
    }
    return self;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    self.btn.frame = CGRectMake(15, 0, self.contentView.frame.size.width-30, 55);
    
}

@end
