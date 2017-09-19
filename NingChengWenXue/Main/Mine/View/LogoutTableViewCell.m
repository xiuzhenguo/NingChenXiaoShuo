//
//  LogoutTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/14.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "LogoutTableViewCell.h"

@implementation LogoutTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpTableViewCellUI];
    }
    return self;
}

- (void) setUpTableViewCellUI {
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.layer.cornerRadius = 26.5;
    self.imgView.layer.masksToBounds = YES;
    self.imgView.image = [UIImage imageNamed:@"头像"];
    [self.contentView addSubview:self.imgView];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.textColor = BXColor(40,40,40);
    self.nameLab.font = FIFFont;
    self.nameLab.text = @"点击登录";
    [self.contentView addSubview:self.nameLab];
    
    self.lab = [[UILabel alloc] init];
    self.lab.textColor = BXColor(152,152,152);
    self.lab.font = THIRDFont;
    self.lab.text = @"登陆后可发现更多精彩内容";
    [self.contentView addSubview:self.lab];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.imgView.frame = CGRectMake(15, 15, 53, 53);
    self.nameLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+15, 20, BXScreenW - 120, 25);
    self.lab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+15, 45, BXScreenW-120, 20);
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
