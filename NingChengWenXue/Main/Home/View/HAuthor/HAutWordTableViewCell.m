//
//  HAutWordTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/3/30.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAutWordTableViewCell.h"

@implementation HAutWordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:15];
    self.nameLab.textColor = BXColor(40,40,40);
    [self.contentView addSubview:self.nameLab];
    
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.font = ELEFont;
    self.timeLab.textColor = BXColor(101,101,101);
    self.timeLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.timeLab];
    
    self.contentLab = [[UILabel alloc] init];
    self.contentLab.font = THIRDFont;
    self.contentLab.textColor = BXColor(40,40,40);
    [self.contentView addSubview:self.contentLab];
    
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    
    self.comBtn = [[UIButton alloc] init];
    [self.comBtn setTitleColor:BXColor(101, 101, 101) forState:UIControlStateNormal];
    self.comBtn.titleLabel.font = ELEFont;
    [self.contentView addSubview:self.comBtn];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.lineLab];
    
    
}

- (void)setViewModel:(LeaveMessageModel *)viewModel{
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    
    self.imgView.frame = CGRectMake(15, 15, 112/2.0, 112/2.0);
    self.imgView.layer.cornerRadius = 112/4.0;
    self.imgView.clipsToBounds = YES;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.UserImage] placeholderImage:[UIImage imageNamed:@"作者头像"]];
    
    self.nameLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, 15, BXScreenW - 150, 20);
    self.nameLab.text = viewModel.AuthorName;
    
    self.timeLab.frame = CGRectMake(BXScreenW - 65, 20, 50, 15);
    self.timeLab.text = viewModel.LeaveTime;
    
    self.contentLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, CGRectGetMaxY(self.nameLab.frame)+10, BXScreenW - 96, 2000);
    self.contentLab.text = viewModel.Content;
    self.contentLab.numberOfLines = 0;
    [self.contentLab sizeToFit];
    
    self.comBtn.frame = CGRectMake(BXScreenW - 75, CGRectGetMaxY(self.contentLab.frame)+15, 60, 20);
    [self.comBtn setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    [self.comBtn setTitle:[NSString stringWithFormat:@"%ld",viewModel.ReplyCount] forState:UIControlStateNormal];
    self.comBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.comBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.lineLab.frame = CGRectMake(0, CGRectGetMaxY(self.comBtn.frame)+9.5, BXScreenW, 0.5);
    
    self.height = CGRectGetMaxY(self.comBtn.frame)+10;
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
