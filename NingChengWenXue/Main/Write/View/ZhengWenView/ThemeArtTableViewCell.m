//
//  ThemeArtTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ThemeArtTableViewCell.h"

@implementation ThemeArtTableViewCell

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
    self.titleLab.numberOfLines = 0;
    self.titleLab.textColor = BXColor(40,40,40);
    [self.contentView addSubview:self.titleLab];
    
    self.typeImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.typeImgView];
    
    self.typeLab = [[UILabel alloc] init];
    self.typeLab.font = ELEFont;
    self.typeLab.textColor = BXColor(152,152,152);
    self.typeLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.typeLab];
    
    
    self.introLab = [[UILabel alloc] init];
    self.introLab.font = THIRDFont;
    self.introLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.introLab];
    
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    
    self.numLab = [[UILabel alloc] init];
    self.numLab.font = THIRDFont;
    self.numLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.numLab];
    
    
    self.hotNumBtn = [[UIButton alloc] init];
    [self.hotNumBtn setTitleColor:BXColor(152,152,152) forState:UIControlStateNormal];
    self.hotNumBtn.titleLabel.font = ELEFont;
    [self.contentView addSubview:self.hotNumBtn];
    
    
    self.backView = [[UIView alloc] init];
    self.backView.layer.borderColor = BXColor(242, 242, 242).CGColor;
    self.backView.layer.borderWidth = 0.5;
    [self.contentView addSubview:self.backView];
    
    
}

- (void)setViewModel:(ZhengWenListModel *)viewModel{
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    // 图片
    self.imgView.frame = CGRectMake(15, 15, BXScreenW - 30, 130);
//    self.imgView.image = [UIImage imageNamed:@"上首页_3"];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.FileImage] placeholderImage:[UIImage imageNamed:@"默认图片"]];
    // 标题
    self.titleLab.text = viewModel.Title;
    CGRect nameWith = [self.titleLab.text boundingRectWithSize:CGSizeMake(BXScreenW - 120, 50) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:(self.titleLab.font)} context:nil];
    self.titleLab.frame = CGRectMake(25, 155, nameWith.size.width, nameWith.size.height);
    // 进度
    self.typeLab.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame)+6, 152.5, 73, 20);
    self.typeLab.text = viewModel.StatusName;
    
    self.typeImgView.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame)+6, 152.5, 73, 20);
    self.typeImgView.image = [UIImage imageNamed:@"标签"];
    // 简介
    self.introLab.frame = CGRectMake(25, CGRectGetMaxY(self.titleLab.frame)+10, BXScreenW - 30, 15);
    self.introLab.text = viewModel.Intro;
    // 作品数
    self.numLab.frame = CGRectMake(25, CGRectGetMaxY(self.introLab.frame)+10, BXScreenW/2 - 30, 15);
    self.numLab.text = viewModel.FictionCount;
    // 热度
    self.hotNumBtn.frame = CGRectMake(BXScreenW/2 +5, CGRectGetMaxY(self.introLab.frame)+10, BXScreenW/2 - 30, 15);
    [self.hotNumBtn setImage:[UIImage imageNamed:@"热门"] forState:UIControlStateNormal];
    [self.hotNumBtn setTitle:[NSString stringWithFormat:@"%ld",viewModel.ClickCount] forState:UIControlStateNormal];
    self.hotNumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.hotNumBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.backView.frame = CGRectMake(15, CGRectGetMaxY(self.imgView.frame), BXScreenW - 30, CGRectGetMaxY(self.hotNumBtn.frame) + 20 - 155);
    
    self.height = CGRectGetMaxY(self.backView.frame);
    
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
