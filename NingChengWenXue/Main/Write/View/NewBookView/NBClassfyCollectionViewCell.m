//
//  NBClassfyCollectionViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/17.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBClassfyCollectionViewCell.h"

@implementation NBClassfyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.nameLab = [[UILabel alloc] init];
        
        _nameLab.layer.cornerRadius = 5;
        _nameLab.layer.borderColor = BXColor(101,101,101).CGColor;
        _nameLab.layer.borderWidth = 0.5;
        _nameLab.font = FIFFont;
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.textColor = BXColor(101,101,101);
        [self.contentView addSubview:_nameLab];

        
        
    }
    return self;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    self.nameLab.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 29);
    
    
}

@end
