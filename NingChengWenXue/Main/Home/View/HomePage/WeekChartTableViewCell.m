//
//  WeekChartTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/17.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "WeekChartTableViewCell.h"

@interface WeekChartTableViewCell()

@property(nonatomic,strong)UIView * line;
@end

@implementation WeekChartTableViewCell

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
    
    self.nameLable = [[UILabel alloc] init];
    self.nameLable.font = FIFFont;
    self.nameLable.textColor = BXColor(40, 40, 40);
    [self.contentView addSubview:self.nameLable];
    
    self.priceLab = [[UILabel alloc] init];
    self.priceLab.font = THIRDFont;
    self.priceLab.textColor = BXColor(252,151,118);
    [self.contentView addSubview:self.priceLab];
    
    self.formLab = [[UILabel alloc] init];
//    self.formLab.font = ELEFont;
//    [self.contentView addSubview:self.formLab];
//    self.formLab.textColor = BXColor(63,90,147);
//    self.formLab.textAlignment = NSTextAlignmentCenter;
//    self.formLab.borderWidth = 1;
//    self.formLab.borderColor = BXColor(63, 90, 147);
//    
    self.signLab = [[UILabel alloc] init];
//    self.signLab.font = ELEFont;
//    [self.contentView addSubview:self.signLab];
//    self.signLab.textColor = BXColor(63,90,147);
//    self.signLab.textAlignment = NSTextAlignmentCenter;
//    self.signLab.borderWidth = 1;
//    self.signLab.borderColor = BXColor(63, 90, 147);
//    
    self.VIPLab = [[UILabel alloc] init];
//    self.VIPLab.font = ELEFont;
//    [self.contentView addSubview:self.VIPLab];
//    self.VIPLab.textColor = BXColor(63,90,147);
//    self.VIPLab.textAlignment = NSTextAlignmentCenter;
//    self.VIPLab.borderWidth = 1;
//    self.VIPLab.borderColor = BXColor(63, 90, 147);
//    
    self.typeLab = [[UILabel alloc] init];
//    self.typeLab.font = ELEFont;
//    [self.contentView addSubview:self.typeLab];
//    self.typeLab.textColor = BXColor(191,44,36);
//    self.typeLab.textAlignment = NSTextAlignmentCenter;
//    self.typeLab.borderWidth = 1;
//    self.typeLab.borderColor = BXColor(191, 44, 36);
//    
    self.typeLable = [[UILabel alloc] initWithFrame:CGRectMake(15+120+10+(32+5)*4, 65, 64, 14)];
//    self.typeLable.font = ELEFont;
//    [self.contentView addSubview:self.typeLable];
//    self.typeLable.textColor = BXColor(191,44,36);
//    self.typeLable.textAlignment = NSTextAlignmentCenter;
//    
//    self.typeLable.borderWidth = 1;
//    self.typeLable.borderColor = BXColor(191, 44, 36);
    
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
    NSLog(@"%@",viewModel);
    if (viewModel.isShowBig) {
       
        self.hetght = 96;
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.HeadImage] placeholderImage:[UIImage imageNamed:@"书"]];
        self.nameLab.text = viewModel.FictionName;
        self.priceLab.text = viewModel.Unity;
        self.formLab.text = @"";
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
                self.formLab = lab;
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
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 140);
        self.line.frame = CGRectMake(15, 0, BXScreenW - 15, 1);
        self.imgView.frame = CGRectMake(15, 10, 120, 152/2);
        self.nameLab.frame = CGRectMake(15+120+10, 18, BXScreenW - 30-120-10, 20);
        self.priceLab.frame = CGRectMake(15+120+10, 48, BXScreenW - 30-120-10, 12);
        self.priceLab.textAlignment = NSTextAlignmentLeft;
        
        CGRect rectLab = Adaptive_Width(self.formLab.text, self.formLab.font);
        self.formLab.frame = CGRectMake(15+120+10, 65, rectLab.size.width+10, 14);
        if (self.formLab.text.length == 0) {
            self.formLab.frame = CGRectMake(15+120+10, 65, 0, 14);
        }
        
        CGRect sign = Adaptive_Width(self.signLab.text, self.signLab.font);
        self.signLab.frame = CGRectMake(CGRectGetMaxX(self.formLab.frame)+5, 65, sign.size.width+10, 14);
        if (self.signLab.text.length == 0) {
            self.signLab.frame = CGRectMake(CGRectGetMaxX(self.formLab.frame), 65, 0, 14);
        }
        
//        CGRect VIP = Adaptive_Width(self.VIPLab.text, self.VIPLab.font);
//        self.VIPLab.frame = CGRectMake(CGRectGetMaxX(self.signLab.frame)+5, 65, VIP.size.width+5, 14);
//        if (self.VIPLab.text.length == 0) {
//            self.VIPLab.frame = CGRectMake(CGRectGetMaxX(self.signLab.frame), 65, 0, 14);
//        }
        
        CGRect onetype = Adaptive_Width(self.typeLab.text, self.typeLab.font);
        self.typeLab.frame = CGRectMake(CGRectGetMaxX(self.signLab.frame)+5, 65, onetype.size.width+10, 14);
        if (self.typeLab.text.length == 0) {
            self.typeLab.frame = CGRectMake(CGRectGetMaxX(self.signLab.frame), 65, 0, 14);
        }
        
        CGRect twoType = Adaptive_Width(self.typeLable.text, self.typeLable.font);
        self.typeLable.frame = CGRectMake(CGRectGetMaxX(self.typeLab.frame)+5, 65, twoType.size.width+10, 14);
        if (self.typeLable.text.length == 0) {
            self.typeLable.frame = CGRectMake(CGRectGetMaxX(self.typeLab.frame), 65, 0, 14);
        }
        
    }else{
        
        self.hetght = 40;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
        self.line.frame = CGRectMake(15, 0, BXScreenW - 15, 1);
        self.nameLab.frame = CGRectMake(15, 0, BXScreenW - 150, 40);
        self.priceLab.frame = CGRectMake(BXScreenW - 135, 0, 120, 40);
        self.priceLab.textAlignment = NSTextAlignmentRight;
        self.nameLab.text = [NSString stringWithFormat:@"%ld.%@",(long)self.row,viewModel.FictionName];
        self.priceLab.text = viewModel.Unity;
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
