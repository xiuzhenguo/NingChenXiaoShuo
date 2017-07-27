//
//  TyrantTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/20.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "TyrantTableViewCell.h"

@interface TyrantTableViewCell()

@property(nonatomic,strong)UIView * line;
@property(nonatomic, strong) UILabel *contLab;

@end

@implementation TyrantTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView{
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.line];
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.imgView];
    
    self.nameLab = [[UILabel alloc] init];
//    self.nameLab.font = FIFFont;
    self.nameLab.font = [UIFont boldSystemFontOfSize:15];
    self.nameLab.textColor = BXColor(40, 40, 40);
    [self.contentView addSubview:self.nameLab];
    
    self.SignatureLab = [[UILabel alloc] init];
    self.SignatureLab.font = THIRDFont;
    self.SignatureLab.textColor = BXColor(40,40,40);
    [self.contentView addSubview:self.SignatureLab];
    
    self.contLab = [[UILabel alloc] init];
    self.contLab.font = THIRDFont;
    [self.contentView addSubview:self.contLab];
    self.contLab.textColor = BXColor(40,40,40);
    
    self.contributeLab = [[UILabel alloc] init];
    self.contributeLab.font = THIRDFont;
    [self.contentView addSubview:self.contributeLab];
    self.contributeLab.textColor = BXColor(252,151,118);


    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
/**
 在此方法中判断显示哪一种布局和显示哪一种数据
 现只是更改布局大小模拟显示
 */
-(void)setViewModel:(BookListModel *)viewModel{
    
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    
    if (viewModel.isShowBig) {
        
        self.hetght = 100;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 140);
        self.line.frame = CGRectMake(15, 0, BXScreenW - 15, 1);
        self.imgView.frame = CGRectMake(15, 10, 75, 75);
        self.imgView.layer.cornerRadius = 75/2.0;
        self.imgView.clipsToBounds = YES;
        self.nameLab.frame = CGRectMake(15 + 75 + 10, 20, BXScreenW - 100, 20);
        self.SignatureLab.frame = CGRectMake(15 + 75 + 10, 50, BXScreenW - 100, 15);
        self.contLab.frame = CGRectMake(15+75 + 10, 75, 90, 15);
        self.contributeLab.frame = CGRectMake(15+75 + 10 + 98, 75, BXScreenW -30-75 - 10 - 98, 15);
        self.contributeLab.textAlignment = NSTextAlignmentLeft;
        
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.HeadImage] placeholderImage:[UIImage imageNamed:@"huli"]];
        
        self.nameLab.text = viewModel.UserName;
        self.SignatureLab.text = @"个性签名: 我的小鬼咕噜咕噜咕噜咕噜";
        self.SignatureLab.text = [NSString stringWithFormat:@"个性签名: %@",viewModel.Signature];
        self.contLab.text = @"本周土豪贡献:";
        self.contributeLab.text = viewModel.Unit;
        
        
    }else{
        
        self.hetght = 40;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
        self.line.frame = CGRectMake(15, 0, BXScreenW - 15, 1);
        self.nameLab.frame = CGRectMake(15, 0, BXScreenW - 150, 40);
        self.contributeLab.frame = CGRectMake(BXScreenW - 135, 0, 120, 40);
        self.contributeLab.textAlignment = NSTextAlignmentRight;
        self.nameLab.text = [NSString stringWithFormat:@"%ld.%@",self.row,viewModel.UserName];
        self.contributeLab.text = viewModel.Unit;
    }
    
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
