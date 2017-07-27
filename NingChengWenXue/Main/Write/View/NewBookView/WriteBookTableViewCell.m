//
//  WriteBookTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/9.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "WriteBookTableViewCell.h"

@implementation WriteBookTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLab];

    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.lineLab];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLab.frame = CGRectMake(15, 0, 150, 43.5);
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
