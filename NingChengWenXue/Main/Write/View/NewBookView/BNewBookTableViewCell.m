//
//  BNewBookTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/26.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "BNewBookTableViewCell.h"

@implementation BNewBookTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:16];
    self.nameLab.textColor = BXColor(40,40,40);
    [self.contentView addSubview:self.nameLab];
    
    self.pageNumLab = [[UILabel alloc] init];
    self.pageNumLab.font = [UIFont systemFontOfSize:14];
    self.pageNumLab.textColor = BXColor(101,101,101);
    [self.contentView addSubview:self.pageNumLab];
    
    self.secNumLab = [[UILabel alloc] init];
    self.secNumLab.font = [UIFont systemFontOfSize:14];
    self.secNumLab.textColor = BXColor(101,101,101);
    [self.contentView addSubview:self.secNumLab];
    
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    
    self.typeLab = [[UILabel alloc] init];
    self.typeLab.font = [UIFont boldSystemFontOfSize:14];
    self.typeLab.textColor = [UIColor whiteColor];
    self.typeLab.backgroundColor = [UIColor blackColor];
    self.typeLab.alpha = 0.5;
    self.typeLab.textAlignment = NSTextAlignmentCenter;
    [self.imgView addSubview:self.typeLab];
    
    self.kanNumBtn = [[UIButton alloc] init];
    [self.kanNumBtn setTitleColor:BXColor(152,152,152) forState:UIControlStateNormal];
    self.kanNumBtn.titleLabel.font = THIRDFont;
    [self.contentView addSubview:self.kanNumBtn];
    
    self.collectNumbtn = [[UIButton alloc] init];
    [self.collectNumbtn setTitleColor:BXColor(152,152,152) forState:UIControlStateNormal];
    self.collectNumbtn.titleLabel.font = THIRDFont;
    [self.contentView addSubview:self.collectNumbtn];
    
    self.plNumBtn = [[UIButton alloc] init];
    [self.plNumBtn setTitleColor:BXColor(152,152,152) forState:UIControlStateNormal];
    self.plNumBtn.titleLabel.font = THIRDFont;
    [self.contentView addSubview:self.plNumBtn];
    
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.lineLab];
    
    
}

- (void)setViewModel:(NewBookListModel *)viewModel{
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    
    // 书的图片
    self.imgView.frame = CGRectMake(15, 15, 139, 88);
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.FictionImage] placeholderImage:[UIImage imageNamed:@"卡片"]];
    
    // 书名字
    self.nameLab.text = viewModel.FictionName;
    self.nameLab.frame = CGRectMake(164, 15, BXScreenW - 174, 15);
    // 类型
    self.typeLab.frame = CGRectMake(0, 68, 139, 20);
    self.typeLab.text = viewModel.CategoryName;
    // 观看人数
    [self.kanNumBtn setTitle:viewModel.Reader forState:UIControlStateNormal];
    CGRect btnWith = [self.kanNumBtn.titleLabel.text boundingRectWithSize:CGSizeMake((BXScreenW - 209)/3.0, 15) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:(self.kanNumBtn.titleLabel.font)} context:nil];
    self.kanNumBtn.frame = CGRectMake(164, 45, btnWith.size.width+15, 15);
    [self.kanNumBtn setImage:[UIImage imageNamed:@"liulan"] forState:UIControlStateNormal];
    
    // 收藏人数
    [self.collectNumbtn setTitle:viewModel.Collect forState:UIControlStateNormal];
    CGRect colWith = [self.collectNumbtn.titleLabel.text boundingRectWithSize:CGSizeMake((BXScreenW - 224)/3.0, 15) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:(self.collectNumbtn.titleLabel.font)} context:nil];
    self.collectNumbtn.frame = CGRectMake(CGRectGetMaxX(self.kanNumBtn.frame)+15, 45, colWith.size.width+15, 15);
    [self.collectNumbtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    // 记录人数
    [self.plNumBtn setTitle:viewModel.Character forState:UIControlStateNormal];
    CGRect plwith = [self.plNumBtn.titleLabel.text boundingRectWithSize:CGSizeMake((BXScreenW - 224)/3.0, 10) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:(self.plNumBtn.titleLabel.font)} context:nil];
    self.plNumBtn.frame = CGRectMake(CGRectGetMaxX(self.collectNumbtn.frame)+15, 45, plwith.size.width+15, 15);
    [self.plNumBtn setImage:[UIImage imageNamed:@"记录"] forState:UIControlStateNormal];
    
    
    // 已发表章节
    self.pageNumLab.frame = CGRectMake(164, 70, BXScreenW - 174, 15);
//    self.pageNumLab.text = @"8个章节已发表";
    self.pageNumLab.text = [NSString stringWithFormat:@"%ld个章节已发表",viewModel.Publish];
    // 草稿
    self.secNumLab.frame = CGRectMake(164, 92, BXScreenW - 174, 15);
//    self.secNumLab.text = @"88章节保存为草稿";
    self.secNumLab.text = [NSString stringWithFormat:@"%ld个章节已保存为草稿",viewModel.NotPublish];
    
    self.lineLab.frame = CGRectMake(0, CGRectGetMaxY(self.imgView.frame)+14.5, BXScreenW, 0.5);
    
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
