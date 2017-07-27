//
//  HSchUniTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/7.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HSchUniTableViewCell.h"

@implementation HSchUniTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpTableViewCellUI];
    }
    return self;
}

- (void) setUpTableViewCellUI {
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.layer.cornerRadius = 25;
    self.imgView.clipsToBounds = YES;
    [self.contentView addSubview:self.imgView];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = FIFFont;
    self.nameLab.textColor = BXColor(35,35,35);
    [self.contentView addSubview:self.nameLab];
    
    self.schNameLab = [[UILabel alloc] init];
    self.schNameLab.font = THIRDFont;
    self.schNameLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.schNameLab];
    
    
    self.numLab = [[UILabel alloc] init];
    self.numLab.font = THIRDFont;
    self.numLab.textColor = BXColor(152, 152, 152);
    [self.contentView addSubview:self.numLab];
    
    self.perNumLab = [[UILabel alloc] init];
    self.perNumLab.font = ELEFont;
    self.perNumLab.textColor = BXColor(152, 152, 152);
    self.perNumLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.perNumLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
}

- (void)setViewModel:(UnionHomeModel *)viewModel {
    
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }

    self.lineLab.frame = CGRectMake(0, 0, BXScreenW, 0.5);
    // 图片
    self.imgView.frame = CGRectMake(15, 12.5, 50, 50);
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.CommunitImage] placeholderImage:[UIImage imageNamed:@"评论_头像"]];
//    self.imgView.image = [UIImage imageNamed:@"评论_头像"];
    // 名字
    self.nameLab.frame = CGRectMake(75, 12.5, BXScreenW - 90, 15);
    self.nameLab.text = viewModel.CommunityName;
    // 大学
    self.schNameLab.frame = CGRectMake(75, CGRectGetMaxY(self.nameLab.frame)+5, 150, 13);
    self.schNameLab.text = viewModel.SchoolName;
    // 作品数
    self.numLab.frame = CGRectMake(75, CGRectGetMaxY(self.schNameLab.frame)+5, 150, 13);
    self.numLab.text = [NSString stringWithFormat:@"%ld部作品",viewModel.FictionCount];
    // 人数
    self.perNumLab.frame = CGRectMake(225, 27.5, BXScreenW - 240, 25);
    self.perNumLab.text = [NSString stringWithFormat:@"%ld人",viewModel.UserCount];
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
