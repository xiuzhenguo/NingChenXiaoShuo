//
//  HBRTyrantTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/1.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HBRTyrantTableViewCell.h"

@implementation HBRTyrantTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 小说名
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.nameLab = [[UILabel alloc] init];
        self.nameLab.font = SIXFont;
        self.nameLab.textColor = BXColor(101,101,101);
        [self.contentView addSubview:self.nameLab];

        // 打赏
        self.glowLab = [[UILabel alloc] init];
        self.glowLab.font = THIRDFont;
        self.glowLab.textColor = BXColor(40,40,40);
        [self.contentView addSubview:self.glowLab];
        
        self.moneyLab = [[UILabel alloc] init];
        self.moneyLab.font = THIRDFont;
        self.moneyLab.textColor = BXColor(236,105,65);
        [self.contentView addSubview:self.moneyLab];
        
        // 图片
        self.imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imgView];
        self.imgView.layer.cornerRadius = 22.5;
        self.imgView.clipsToBounds = YES;
        
        self.lineLab = [[UILabel alloc] init];
        self.lineLab.backgroundColor = BXColor(195,195,195);
        [self.contentView addSubview:self.lineLab];
        
        
    }
    return self;
}

- (void)setViewModel:(BillboardModel *)viewModel{
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    CGFloat width = self.contentView.frame.size.width;
    self.imgView.frame = CGRectMake(10, 10, 45, 45);
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.FictionImage] placeholderImage:[UIImage imageNamed:@"打赏头像"]];
    
    self.nameLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, 15, width-70, 15);
    self.nameLab.text = viewModel.AuthorName;
    
    self.glowLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, CGRectGetMaxY(self.nameLab.frame)+5, 100, 15);
    self.glowLab.text = @"打赏了";
    [self.glowLab sizeToFit];
    
    self.moneyLab.frame = CGRectMake(CGRectGetMaxX(self.glowLab.frame), CGRectGetMaxY(self.nameLab.frame)+5, width-CGRectGetMaxX(self.glowLab.frame)-5, 15);
    self.moneyLab.text = viewModel.Unit;
    
    self.lineLab.frame = CGRectMake(10, CGRectGetMaxY(self.imgView.frame)+9.5, width - 10, 0.5);

}

- (void)setModel:(BillboardModel *)model{
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    CGFloat width = self.contentView.frame.size.width;
    self.imgView.frame = CGRectMake(10, 10, 45, 45);
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.HeadImage] placeholderImage:[UIImage imageNamed:@"打赏头像"]];
    
    self.nameLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, 15, width-70, 15);
    self.nameLab.text = model.UserName;
    
    self.glowLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, CGRectGetMaxY(self.nameLab.frame)+5, 100, 15);
    self.glowLab.text = @"共码了";
    [self.glowLab sizeToFit];
    
    self.moneyLab.frame = CGRectMake(CGRectGetMaxX(self.glowLab.frame), CGRectGetMaxY(self.nameLab.frame)+5, width-CGRectGetMaxX(self.glowLab.frame)-5, 15);
    self.moneyLab.text = model.Unit;
    
    self.lineLab.frame = CGRectMake(10, CGRectGetMaxY(self.imgView.frame)+9.5, width - 10, 0.5);
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
