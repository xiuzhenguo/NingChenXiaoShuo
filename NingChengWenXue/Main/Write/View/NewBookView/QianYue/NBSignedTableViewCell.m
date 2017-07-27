//
//  NBSignedTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/8.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBSignedTableViewCell.h"

@implementation NBSignedTableViewCell

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
    
    self.typeLab = [[UILabel alloc] init];
    self.typeLab.font = FIFFont;
    self.typeLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.typeLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.lineLab];
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLab.frame = CGRectMake(15, 0, BXScreenW - 135, 43.5);
    self.typeLab.frame = CGRectMake(BXScreenW - 115, 0, 100, 43.5);
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
