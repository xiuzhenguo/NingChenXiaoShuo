//
//  HEssenceTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/3.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HEssenceTableViewCell.h"

@implementation HEssenceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpTableViewCellUI];
    }
    return self;
}

- (void) setUpTableViewCellUI {
    
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:16];
    self.nameLab.textColor = BXColor(40, 40, 40);
    [self.contentView addSubview:self.nameLab];
    
    self.authorLab = [[UILabel alloc] init];
    self.authorLab.font = THIRDFont;
    self.authorLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.authorLab];
    
    self.collecBtn = [[UIButton alloc] init];
    self.collecBtn.titleLabel.font = ELEFont;
    self.collecBtn.layer.cornerRadius = 5;
    self.collecBtn.borderWidth = 1;
    [self.contentView addSubview:self.collecBtn];
    
    self.numLab = [[UILabel alloc] init];
    self.numLab.font = THIRDFont;
    self.numLab.textColor = BXColor(152, 152, 152);
    [self.contentView addSubview:self.numLab];
    
    self.signLab = [[UILabel alloc] init];
//    self.signLab.font = ELEFont;
//    [self.contentView addSubview:self.signLab];
//    self.signLab.textColor = BXColor(63,90,147);
//    self.signLab.textAlignment = NSTextAlignmentCenter;
//    self.signLab.borderWidth = 1;
//    self.signLab.borderColor = BXColor(63, 90, 147);
    
    self.VIPLab = [[UILabel alloc] init];
//    self.VIPLab.font = ELEFont;
//    [self.contentView addSubview:self.VIPLab];
//    self.VIPLab.textColor = BXColor(63,90,147);
//    self.VIPLab.textAlignment = NSTextAlignmentCenter;
//    self.VIPLab.borderWidth = 1;
//    self.VIPLab.borderColor = BXColor(63, 90, 147);
    
    self.typeLab = [[UILabel alloc] init];
//    self.typeLab.font = ELEFont;
//    [self.contentView addSubview:self.typeLab];
//    self.typeLab.textColor = BXColor(191,44,36);
//    self.typeLab.textAlignment = NSTextAlignmentCenter;
//    self.typeLab.borderWidth = 1;
//    self.typeLab.borderColor = BXColor(191, 44, 36);
    
    self.typeLable = [[UILabel alloc] init];
//    self.typeLable.font = ELEFont;
//    [self.contentView addSubview:self.typeLable];
//    self.typeLable.textColor = BXColor(191,44,36);
//    self.typeLable.textAlignment = NSTextAlignmentCenter;
//    self.typeLable.borderWidth = 1;
//    self.typeLable.borderColor = BXColor(191, 44, 36);
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
}

- (void)setViewModel:(ExceedListModel *)viewModel {
    
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    
    // 图片
    self.imgView.frame = CGRectMake(15, 15, 150, 95);
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.FictionImage] placeholderImage:[UIImage imageNamed:@"书"]];
    // 小说名
    self.nameLab.frame = CGRectMake(175, 15, BXScreenW - 190, 15);
    self.nameLab.text = viewModel.FictionName;
    // 作者
    self.authorLab.frame = CGRectMake(175, CGRectGetMaxY(self.nameLab.frame)+5, BXScreenW - 190, 14);
    self.authorLab.text = [NSString stringWithFormat:@"by：%@",viewModel.AuthorName];
    // 按钮
    self.collecBtn.frame = CGRectMake(175, CGRectGetMaxY(self.authorLab.frame)+5, 50, 18);
    if ([viewModel.IsCollect isEqualToString:@"0"]) {
        self.collecBtn.selected = NO;
        [self.collecBtn setTitle:@"点击收藏" forState:UIControlStateNormal];
        [self.collecBtn setTitleColor:BXColor(236, 105, 65) forState:UIControlStateNormal];
        self.collecBtn.borderColor = BXColor(236,105,65);
    }else{
        self.collecBtn.selected = YES;
        [self.collecBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
        [self.collecBtn setTitleColor:BXColor(152, 152, 152) forState:UIControlStateNormal];
        self.collecBtn.borderColor = BXColor(152, 152, 152);
    }
    // 阅读人数
    self.numLab.frame = CGRectMake(175, CGRectGetMaxY(self.collecBtn.frame)+5, BXScreenW-190, 14);
    self.numLab.text = [NSString stringWithFormat:@"%@字/%@点击",viewModel.CharacterCount,viewModel.ClickCount];
    
    self.signLab.text = @"";
    self.VIPLab.text = @"";
    self.typeLab.text = @"";
    self.typeLable.text = @"";
    
    for (int i = 0; i < viewModel.Keys.count; i++) {
        BookKeysModel *model = viewModel.Keys[i];
        UILabel *lab = [[UILabel alloc] init];
        lab.font = ELEFont;
        [self.contentView addSubview:lab];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.borderWidth = 1;
        
        if (model.type == 1) {
            lab.textColor = BXColor(63,90,147);
            lab.borderColor = BXColor(63,90,147);
        }else{
            lab.textColor = BXColor(191,44,36);
            lab.borderColor = BXColor(191, 44, 36);
        }
        if (i == 0) {
            BookKeysModel *model = viewModel.Keys[i];
            lab.text = model.name;
    
        }else if (i == 1){
            BookKeysModel *model = viewModel.Keys[i];
            lab.text = model.name;
            self.signLab = lab;
        }else if (i == 2){
            BookKeysModel *model = viewModel.Keys[i];
            lab.text = model.name;
            self.typeLab = lab;
        }else if (i == 3){
            BookKeysModel *model = viewModel.Keys[i];
            lab.text = model.name;
            self.typeLable = lab;
        }
        
    }
    
    // 签约
//    self.signLab.text = @"签约";
    CGRect sign = Adaptive_Width(self.signLab.text, self.signLab.font);
    self.signLab.frame = CGRectMake(175, CGRectGetMaxY(self.numLab.frame)+5, sign.size.width+10, 14);
    if (self.signLab.text.length == 0) {
        self.signLab.frame = CGRectMake(175, CGRectGetMaxY(self.numLab.frame)+5, 0, 14);
    }
    // VIP
//    self.VIPLab.text = @"VIP";
    CGRect vip = Adaptive_Width(self.VIPLab.text, self.VIPLab.font);
    self.VIPLab.frame = CGRectMake(CGRectGetMaxX(self.signLab.frame)+5, CGRectGetMaxY(self.numLab.frame)+5, vip.size.width+10, 14);
    if (self.VIPLab.text.length == 0) {
        self.VIPLab.frame = CGRectMake(CGRectGetMaxX(self.signLab.frame), CGRectGetMaxY(self.numLab.frame)+5, 0, 14);
    }
    // 仙侠
//    self.typeLab.text = @"仙侠";
    CGRect onetype = Adaptive_Width(self.typeLab.text, self.typeLab.font);
    self.typeLab.frame = CGRectMake(CGRectGetMaxX(self.VIPLab.frame)+5, CGRectGetMaxY(self.numLab.frame)+5, onetype.size.width+10, 14);
    if (self.typeLab.text.length == 0) {
        self.typeLab.frame = CGRectMake(CGRectGetMaxX(self.VIPLab.frame), CGRectGetMaxY(self.numLab.frame)+5, 0, 14);
    }
    
    // 幻想仙侠
//    self.typeLable.text = @"幻想仙侠";
    CGRect twoType = Adaptive_Width(self.typeLable.text, self.typeLable.font);
    self.typeLable.frame = CGRectMake(CGRectGetMaxX(self.typeLab.frame)+5, CGRectGetMaxY(self.numLab.frame)+5, twoType.size.width+10, 14);
    if (self.typeLable.text.length == 0) {
        self.typeLable.frame = CGRectMake(CGRectGetMaxX(self.typeLab.frame), CGRectGetMaxY(self.numLab.frame)+5, 0, 14);
    }
    
    // 分割线
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
