//
//  NBEditTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/4.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBEditTableViewCell.h"

@implementation NBEditTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = FIFFont;
    self.titleLab.textColor = BXColor(40,40,40);
    [self.contentView addSubview:self.titleLab];
    
    self.conLab = [[UILabel alloc] init];
    self.conLab.font = FIFFont;
    self.conLab.textColor = BXColor(152,152,152);
    self.conLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.conLab];
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.image = [UIImage imageNamed:@"下一级"];
    [self.contentView addSubview:self.imgView];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.lineLab];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLab.frame = CGRectMake(15, 0, 135, 43.5);
    self.conLab.frame = CGRectMake(155, 0, BXScreenW - 185, 43.5);
    self.imgView.frame = CGRectMake(BXScreenW - 25, 15, 10, 14);
    self.lineLab.frame = CGRectMake(0, 43.5, BXScreenW, 0.5);
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
