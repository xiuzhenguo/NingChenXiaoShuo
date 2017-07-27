//
//  HClubMeanHeadTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/9.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HClubMeanHeadTableViewCell.h"

@implementation HClubMeanHeadTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpTableViewCellUI];
    }
    return self;
}

-(void) setUpTableViewCellUI {
    self.titleName = [[UILabel alloc] init];
    self.titleName.font = [UIFont boldSystemFontOfSize:16];
    self.titleName.textColor = BXColor(40,40,40);
    [self.contentView addSubview:self.titleName];
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.layer.cornerRadius = 25;
    self.imgView.clipsToBounds = YES;
    [self.contentView addSubview:self.imgView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleName.frame = CGRectMake(15, 0, 120, 60);
    
    self.imgView.frame = CGRectMake(BXScreenW - 65, 5, 50, 50);
    
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
