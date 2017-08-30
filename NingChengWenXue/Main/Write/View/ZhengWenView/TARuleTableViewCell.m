//
//  TARuleTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/28.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "TARuleTableViewCell.h"

@implementation TARuleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    
    }
    return self;
}

-(void) loadView {
    
    self.shuLab = [[UILabel alloc] init];
    self.shuLab.backgroundColor = BXColor(236,105,65);
    [self.contentView addSubview:self.shuLab];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:16];
    self.nameLab.textColor = BXColor(40, 40, 40);
    [self.contentView addSubview:self.nameLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(242, 242, 242);
    [self.contentView addSubview:self.lineLab];
    
    self.contentLab = [[UILabel alloc] init];
    self.contentLab.font = THIRDFont;
    self.contentLab.textColor = BXColor(40, 40, 40);
    self.contentLab.numberOfLines = 0;
    [self.contentView addSubview:self.contentLab];
    
    self.lineView = [[UILabel alloc] init];
    self.lineView.backgroundColor = BXColor(242, 242, 242);
    [self.contentView addSubview:self.lineView];
    
}

- (void)setViewModel:(AwardsZhengWenModel *)viewModel{
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    
    self.shuLab.frame = CGRectMake(15, 14, 3, 16);
    
    self.nameLab.frame = CGRectMake(CGRectGetMaxX(self.shuLab.frame)+5, 0, 200, 43.5);
    self.nameLab.text = viewModel.ConfigName;
    
    self.lineLab.frame = CGRectMake(0, 43.5, BXScreenW, 0.5);
    
    self.contentLab.text = viewModel.ConfigContent;
    CGRect nameWith = [self.contentLab.text boundingRectWithSize:CGSizeMake(BXScreenW - 30, 600) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:(self.contentLab.font)} context:nil];
    self.contentLab.frame = CGRectMake(15, CGRectGetMaxY(self.lineLab.frame)+10, BXScreenW - 30, nameWith.size.height);
    
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.contentLab.frame)+10, BXScreenW, 15);
    self.height = CGRectGetMaxY(self.lineView.frame);
    
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
