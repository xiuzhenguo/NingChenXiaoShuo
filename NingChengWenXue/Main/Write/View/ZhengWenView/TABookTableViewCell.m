//
//  TABookTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/11.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "TABookTableViewCell.h"

@implementation TABookTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = FIFFont;
    self.nameLab.textColor = BXColor(40,40,40);
    [self.contentView addSubview:self.nameLab];
    
    self.imgView = [[UIButton alloc] init];
    [self.imgView setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    self.imgView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.imgView.imageEdgeInsets = UIEdgeInsetsMake(12, 0, 11, 15);
    [self.contentView addSubview:self.imgView];
    
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.lineLab.frame = CGRectMake(0, 0, BXScreenW, 0.5);
    self.nameLab.frame = CGRectMake(15, 0.5, BXScreenW - 60, 43.5);
    self.imgView.frame = CGRectMake(0, 0, BXScreenW, 43.5);
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
