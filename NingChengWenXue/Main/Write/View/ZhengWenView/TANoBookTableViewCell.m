//
//  TANoBookTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/11.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "TANoBookTableViewCell.h"

@implementation TANoBookTableViewCell

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
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    self.nameLab.textColor = BXColor(152,152,152);
    self.nameLab.text = @"暂无可投稿作品";
    [self.contentView addSubview:self.nameLab];
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.image = [UIImage imageNamed:@"暂无投稿作品"];
    [self.contentView addSubview:self.imgView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imgView.frame = CGRectMake(BXScreenW/2.0 - 37.5, 0, 75, 75);
    self.nameLab.frame = CGRectMake(0, 82, BXScreenW, 15);
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
