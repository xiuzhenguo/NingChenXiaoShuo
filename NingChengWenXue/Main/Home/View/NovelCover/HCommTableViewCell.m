//
//  HCommTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/21.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HCommTableViewCell.h"

@implementation HCommTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    
    self.commentLab = [[UILabel alloc] init];
    self.commentLab.font = [UIFont boldSystemFontOfSize:15];
    self.commentLab.textColor = BXColor(35, 35, 35);
    self.commentLab.text = @"评论";
    [self.contentView addSubview:self.commentLab];
    
    self.comNumLab = [[UILabel alloc] init];
    self.comNumLab.font = THIRDFont;
    self.comNumLab.textColor = BXColor(35, 35, 35);
    [self.contentView addSubview:self.comNumLab];
    
    self.moreImg = [[UIImageView alloc] init];
    self.moreImg.image = [UIImage imageNamed:@"箭头-1"];
    [self.contentView addSubview:self.moreImg];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = BXColor(242, 242, 242);
    [self.contentView addSubview:self.lineView];
}

-(void) layoutSubviews {
    [super layoutSubviews];
    self.commentLab.frame = CGRectMake(15, 15, 40, 15);
    self.comNumLab.frame = CGRectMake(CGRectGetMaxX(self.commentLab.frame), 15, 200, 15);
    self.moreImg.frame = CGRectMake(BXScreenW - 25, 15, 10, 15);
    self.lineView.frame = CGRectMake(0, 44, BXScreenW, 10);
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
