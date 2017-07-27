//
//  NBAttTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/12.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBAttTableViewCell.h"

@implementation NBAttTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    
    self.typeLab = [[UILabel alloc] init];
    self.typeLab.font = FIFFont;
    self.typeLab.textColor = BXColor(40,40,40);
    [self.contentView addSubview:self.typeLab];
    
    self.imgBtn = [[UIButton alloc] init];
    self.imgBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.imgBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 11, 15);
    [self.contentView addSubview:self.imgBtn];
    
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.lineLab.frame = CGRectMake(0, 43.5, BXScreenW, 0.5);
    self.typeLab.frame = CGRectMake(15, 0, BXScreenW - 60, 43.5);
    self.imgBtn.frame = CGRectMake(0, 0, BXScreenW, 43.5);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
