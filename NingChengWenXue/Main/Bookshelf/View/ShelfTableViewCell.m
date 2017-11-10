//
//  ShelfTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/4/25.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ShelfTableViewCell.h"

@implementation ShelfTableViewCell

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
    
    self.typeImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.typeImgView];
    
    self.secNumLab = [[UILabel alloc] init];
    self.secNumLab.font = THIRDFont;
    self.secNumLab.textColor = BXColor(236,105,65);
    [self.contentView addSubview:self.secNumLab];
    
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    
    self.typeLab = [[UILabel alloc] init];
    self.typeLab.font = [UIFont boldSystemFontOfSize:14];
    self.typeLab.textColor = [UIColor whiteColor];
    self.typeLab.backgroundColor = [UIColor blackColor];
    self.typeLab.alpha = 0.4;
    self.typeLab.textAlignment = NSTextAlignmentCenter;
    [self.imgView addSubview:self.typeLab];
    
//    self.deleteBtn = [[UIButton alloc] init];
//    [self.deleteBtn setTitleColor:BXColor(152,152,152) forState:UIControlStateNormal];
//    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//    self.deleteBtn.titleLabel.font = THIRDFont;
//    self.deleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    self.deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    [self.contentView addSubview:self.deleteBtn];
    
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
    
    
    self.writerLab = [[UILabel alloc] init];
    self.writerLab.font = FIFFont;
    self.writerLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.writerLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.lineLab];
    
    
}

- (void)setViewModel:(BookShelfModel *)viewModel{
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    
    // 书的图片
    self.imgView.frame = CGRectMake(15, 15, 139, 88);
//    self.imgView.image = [UIImage imageNamed:@"卡片"];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.FictionImage] placeholderImage:[UIImage imageNamed:@"默认图片"]];
    
    // 类型
    self.typeLab.frame = CGRectMake(0, 68, 139, 20);
    self.typeLab.text = viewModel.ClassName;
    
    // 书名字
    self.nameLab.text = viewModel.FictionName;
    CGRect nameWith = [self.nameLab.text boundingRectWithSize:CGSizeMake(BXScreenW - 200, 50) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:(self.nameLab.font)} context:nil];
    self.nameLab.frame = CGRectMake(164, 15, nameWith.size.width, 15);
    
    self.typeImgView.frame = CGRectMake(CGRectGetMaxX(self.nameLab.frame)+5, 15, 20, 15);
    if (viewModel.BookStatus == 1) {
        self.typeImgView.image = [UIImage imageNamed:@"连载"];
    }else{
        self.typeImgView.image = [UIImage imageNamed:@"完结"];
    }
    
    // 作者名字
    self.writerLab.frame = CGRectMake(164, 40, BXScreenW - 179, 15);
    self.writerLab.text = [NSString stringWithFormat:@"作者:%@",viewModel.AuthorName];
    // 观看人数
    [self.kanNumBtn setTitle:viewModel.ReadCount forState:UIControlStateNormal];
    CGRect btnWith = [self.kanNumBtn.titleLabel.text boundingRectWithSize:CGSizeMake((BXScreenW - 209)/3.0, 13) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:(self.kanNumBtn.titleLabel.font)} context:nil];
    self.kanNumBtn.frame = CGRectMake(164, 65, btnWith.size.width+15, 13);
    [self.kanNumBtn setImage:[UIImage imageNamed:@"liulan"] forState:UIControlStateNormal];
    
    // 收藏人数
    [self.collectNumbtn setTitle:viewModel.CollectCount forState:UIControlStateNormal];
    CGRect colWith = [self.collectNumbtn.titleLabel.text boundingRectWithSize:CGSizeMake((BXScreenW - 209)/3.0, 13) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:(self.collectNumbtn.titleLabel.font)} context:nil];
    self.collectNumbtn.frame = CGRectMake(CGRectGetMaxX(self.kanNumBtn.frame)+15, 65, colWith.size.width+15, 13);
    [self.collectNumbtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    // 评论人数
    [self.plNumBtn setTitle:viewModel.PostCount forState:UIControlStateNormal];
    CGRect plwith = [self.plNumBtn.titleLabel.text boundingRectWithSize:CGSizeMake((BXScreenW - 209)/3.0, 13) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:(self.plNumBtn.titleLabel.font)} context:nil];
    self.plNumBtn.frame = CGRectMake(CGRectGetMaxX(self.collectNumbtn.frame)+15, 65, plwith.size.width+15, 15);
    [self.plNumBtn setImage:[UIImage imageNamed:@"liuyan"] forState:UIControlStateNormal];
    
    // 当前张数
    self.secNumLab.frame = CGRectMake(164, 90, BXScreenW - 160, 15);
    self.secNumLab.text = [NSString stringWithFormat:@"您看到了:%ld/%ld",viewModel.SectionIndex,viewModel.SectionTotalCount];;
//    self.secNumLab.text = @"您看到了:88/787878778章";
    
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
