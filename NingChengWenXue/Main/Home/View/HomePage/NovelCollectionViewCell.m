//
//  NovelCollectionViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/20.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NovelCollectionViewCell.h"

@implementation NovelCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgView = [[UIImageView alloc] init];
        self.imgView.image = [UIImage imageNamed:@"上首页_5"];
        [self.contentView addSubview:self.imgView];
        self.imgView.borderColor = BXColor(195, 195, 195);
        self.imgView.borderWidth = 0.5;
        
        
        self.writorLab = [[UILabel alloc] init];
        self.writorLab.text = @"著: 作者";
        self.writorLab.textColor = BXColor(153, 153, 153);
        [self.contentView addSubview:self.writorLab];
        self.writorLab.font = ELEFont;
        
        self.typeLab = [[UILabel alloc] init];
        self.typeLab.text = @"连载";
        self.typeLab.textColor = BXColor(153, 153, 153);
        [self.contentView addSubview:self.typeLab];
        self.typeLab.font = ELEFont;
        self.typeLab.borderWidth = 1;
        self.typeLab.borderColor = BXColor(153, 153, 153);
        self.typeLab.textAlignment = NSTextAlignmentCenter;
        
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
    self.imgView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 60);
    self.nameLab.frame = CGRectMake(0, 65, self.contentView.frame.size.width, 20);
    self.writorLab.frame = CGRectMake(0, 90, self.contentView.frame.size.width, 15);
    self.typeLab.frame = CGRectMake(0, 110, 32, 15);
    
    
}

@end
