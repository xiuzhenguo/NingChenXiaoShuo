//
//  HAFourImgTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/23.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HAFourImgTableViewCell.h"

@implementation HAFourImgTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    // 作者头像
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    self.imgView.layer.cornerRadius = 25;
    self.imgView.clipsToBounds = YES;
    // 作者名字
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = THIRDFont;
    self.nameLab.textColor = BXColor(35, 35, 35);
    [self.contentView addSubview:self.nameLab];
    // 评论的名字
    self.conNameLab = [[UILabel alloc] init];
    self.conNameLab.font = THIRDFont;
    self.conNameLab.textColor = BXColor(101,101,101);
    [self.contentView addSubview:self.conNameLab];
    // 评论的内容
    self.contentLab = [[UILabel alloc] init];
    self.contentLab.font = FIFFont;
    self.contentLab.textColor = BXColor(35, 35, 35);;
    [self.contentView addSubview:self.contentLab];

    // 灰色的背景
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.backView];
    // 小说的封面图片
    self.novelImg = [[UIImageView alloc] init];
    [self.backView addSubview:self.novelImg];
    // 章节的名字
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont boldSystemFontOfSize:15];
    self.titleLab.textColor = BXColor(35, 35, 35);
    [self.backView addSubview:self.titleLab];
    // 章节内容
    self.writorLab = [[UILabel alloc] init];
    self.writorLab.font = THIRDFont;
    self.writorLab.textColor = BXColor(101,101,101);
    [self.backView addSubview:self.writorLab];
    // 时间
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.font = ELEFont;
    self.timeLab.textColor = BXColor(101,101,101);
    [self.contentView addSubview:self.timeLab];
    // 分割线
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.lineLab];
}

- (void)setViewModel:(WriterDynModel *)viewModel{
    
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
   
    self.imgView.frame = CGRectMake(15, 10, 50, 50);
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.UserImage] placeholderImage:[UIImage imageNamed:@"作者头像"]];
    
    self.nameLab.frame = CGRectMake(75, 15, BXScreenW - 90, 20);
    self.nameLab.text = viewModel.AuthorName;
    
    self.conNameLab.frame = CGRectMake(75, 40, BXScreenW - 90, 15);
    self.conNameLab.text = viewModel.Title;
    
    self.contentLab.frame = CGRectMake(15, CGRectGetMaxY(self.imgView.frame)+10, BXScreenW - 30, 2000);
    self.contentLab.text = viewModel.Content;
    self.contentLab.numberOfLines = 0;
    [self.contentLab sizeToFit];
    
    self.backView.frame = CGRectMake(10, CGRectGetMaxY(self.contentLab.frame) + 15, BXScreenW - 20, 79);
    
    self.novelImg.frame = CGRectMake(10, 10, 93, 59);
    [self.novelImg sd_setImageWithURL:[NSURL URLWithString:viewModel.Fiction.FictiomImage] placeholderImage:[UIImage imageNamed:@"书"]];
    
    self.titleLab.frame = CGRectMake(113, 10, BXScreenW - 143, 20);
    self.titleLab.text = viewModel.Fiction.SectionName;
    
    self.writorLab.frame = CGRectMake(113, CGRectGetMaxY(self.titleLab.frame)+5, BXScreenW - 143, 40);
    self.writorLab.text = viewModel.Fiction.SectionContent;
    self.writorLab.numberOfLines = 0;
    
    self.timeLab.frame = CGRectMake(10, CGRectGetMaxY(self.backView.frame)+ 10, BXScreenW - 20, 15);
    self.timeLab.text = viewModel.AddTime;
    
    self.lineLab.frame = CGRectMake(0, CGRectGetMaxY(self.timeLab.frame)+15, BXScreenW, 0.5);
    
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

