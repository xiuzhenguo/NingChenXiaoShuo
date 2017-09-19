//
//  MSenddetailTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/9/18.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "MSenddetailTableViewCell.h"

@implementation MSenddetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self setUpTableViewCellUI];
        
    }
    return self;
}

- (void) setUpTableViewCellUI {
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = FIFFont;
    self.titleLab.textColor = BXColor(101,101,101);
    [self.contentView addSubview:self.titleLab];
    
    self.conLab = [[UILabel alloc] init];
    self.conLab.font = FIFFont;
    self.conLab.textColor = BXColor(40,40,40);
    self.conLab.numberOfLines = 0;
    [self.contentView addSubview:self.conLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
}

- (void)setViewModel:(NSString *)viewModel{
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    self.titleLab.text = self.nameStr;
    CGRect type = Adaptive_Width(self.titleLab.text, self.titleLab.font);
    self.titleLab.frame = CGRectMake(15, 12, 60, type.size.height);
    
    self.conLab.text = viewModel;
    CGRect size = [self.conLab.text boundingRectWithSize:CGSizeMake(BXScreenW - 95, 5000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.conLab.font} context:nil];
    self.conLab.frame = CGRectMake(85, 12, BXScreenW - 95, size.size.height);
    self.lineLab.frame = CGRectMake(0, CGRectGetMaxY(self.conLab.frame)+12, BXScreenW, 0.5);
    
    self.height = CGRectGetMaxY(self.lineLab.frame);
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
