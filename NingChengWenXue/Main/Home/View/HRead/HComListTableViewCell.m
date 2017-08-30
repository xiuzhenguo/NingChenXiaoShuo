//
//  HComListTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HComListTableViewCell.h"

@implementation HComListTableViewCell


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
    
    self.fromLab = [[UILabel alloc] init];
    self.fromLab.font = ELEFont;
    self.fromLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.fromLab];
    
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    
    self.comBtn = [[UIButton alloc] init];
    [self.comBtn setTitleColor:BXColor(101, 101, 101) forState:UIControlStateNormal];
    self.comBtn.titleLabel.font = ELEFont;
    [self.contentView addSubview:self.comBtn];
    
    self.zanBtn = [[UIButton alloc] init];
    [self.zanBtn setTitleColor:BXColor(101, 101, 101) forState:UIControlStateNormal];
    self.zanBtn.titleLabel.font = ELEFont;
    [self.contentView addSubview:self.zanBtn];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.lineLab];
    
    
}

- (void)setViewModel:(ShuPingListModel *)viewModel{
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    
    self.imgView.frame = CGRectMake(15, 15, 112/2.0, 112/2.0);
    self.imgView.layer.cornerRadius = 112/4.0;
    self.imgView.clipsToBounds = YES;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.UserHeadImage] placeholderImage:[UIImage imageNamed:@"打赏头像"]];
    
    self.nameLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, 15, BXScreenW - 150, 20);
    self.nameLab.text = viewModel.AuthorName;
    
    self.timeLab.frame = CGRectMake(BXScreenW - 65, 20, 50, 15);
    self.timeLab.text = viewModel.Time;
    
    self.contentLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, CGRectGetMaxY(self.nameLab.frame)+10, BXScreenW - 96, 2000);
    self.contentLab.text = viewModel.Content;
    self.contentLab.numberOfLines = 0;
    [self.contentLab sizeToFit];
    
    self.fromLab.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame)+10, CGRectGetMaxY(self.contentLab.frame)+15, BXScreenW - 96, 15);
    self.fromLab.text = [NSString stringWithFormat:@"来自%@",viewModel.SectionName];
    
    self.zanBtn.frame = CGRectMake(BXScreenW - 200, CGRectGetMaxY(self.fromLab.frame)+10, 125, 20);
    if (viewModel.IsApplaud == 1) {
        self.zanBtn.selected = YES;
        [self.zanBtn setImage:[UIImage imageNamed:@"点赞_click"] forState:UIControlStateNormal];
    }else{
        self.zanBtn.selected = NO;
        [self.zanBtn setImage:[UIImage imageNamed:@"赞"] forState:UIControlStateNormal];
    }

    self.zanBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.zanBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.comBtn.frame = CGRectMake(BXScreenW - 60, CGRectGetMaxY(self.fromLab.frame)+10, 60, 20);
    [self.comBtn setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    self.comBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.comBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.lineLab.frame = CGRectMake(0, CGRectGetMaxY(self.zanBtn.frame)+9.5, BXScreenW, 0.5);
    
    self.height = CGRectGetMaxY(self.zanBtn.frame)+10;
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
