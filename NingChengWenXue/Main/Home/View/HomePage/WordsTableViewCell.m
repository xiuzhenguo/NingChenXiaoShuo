//
//  WordsTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/20.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "WordsTableViewCell.h"

@interface WordsTableViewCell()

@property(nonatomic,strong)UIView * line;
@property(nonatomic, strong) UILabel *wordLable;

@end

@implementation WordsTableViewCell

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
    
    self.IDLab = [[UILabel alloc] init];
    self.IDLab.font = FIFFont;
    self.IDLab.textColor = BXColor(40,40,40);
    [self.contentView addSubview:self.IDLab];
    self.IDLab.textAlignment = NSTextAlignmentCenter;
    
    self.rankLab = [[UILabel alloc] init];
    self.rankLab.font = ELEFont;
    [self.contentView addSubview:self.rankLab];
    self.rankLab.textColor = BXColor(0,160,233);
    self.rankLab.textAlignment = NSTextAlignmentCenter;
    self.rankLab.borderWidth = 1;
    self.rankLab.borderColor = BXColor(0, 160, 233);
    
    self.VigorousLab = [[UILabel alloc] init];
    self.VigorousLab.font = THIRDFont;
    [self.contentView addSubview:self.VigorousLab];
    self.VigorousLab.textColor = BXColor(40,40,40);
    
    self.wordLable = [[UILabel alloc] init];
    self.wordLable.font = THIRDFont;
    [self.contentView addSubview:self.wordLable];
    self.wordLable.textColor = BXColor(40,40,40);
    
    
    self.WordsLab = [[UILabel alloc] init];
    self.WordsLab.font = THIRDFont;
    [self.contentView addSubview:self.WordsLab];
    self.WordsLab.textColor = BXColor(252,151,118);
    
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
        self.nameLab.frame = CGRectMake(15 + 75 + 10, 20, 90, 20);
        self.IDLab.frame = CGRectMake(15 + 75 + 10 + 90, 20, 130, 20);
        self.rankLab.frame = CGRectMake(15 + 75 + 10 + 100 + 130, 23, 64/2.0, 14);
        self.VigorousLab.frame = CGRectMake(15 + 75 + 10, 50, BXScreenW - 30 - 75 - 10, 15);
        self.wordLable.frame = CGRectMake(15+75 + 10, 75, 70, 15);
        self.WordsLab.frame = CGRectMake(15+75 + 10 + 78, 75, BXScreenW -30-75 - 10 - 78, 15);
        self.WordsLab.textAlignment = NSTextAlignmentLeft;
        
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.HeadImage] placeholderImage:[UIImage imageNamed:@"huli"]];
        
        self.nameLab.text = viewModel.UserName;
//        self.IDLab.text = @"(UUID:13050624)";
        self.IDLab.text = [NSString stringWithFormat:@"UUID:%@",viewModel.UUID];
        self.rankLab.text = [NSString stringWithFormat:@"Lv%ld",viewModel.Lv];
        self.VigorousLab.text = [NSString stringWithFormat:@"活力：%@",viewModel.Energy];
        self.wordLable.text = @"本周码字:";
        self.WordsLab.text = viewModel.Unit;
        
        
    }else{
        
        self.hetght = 40;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
        self.line.frame = CGRectMake(15, 0, BXScreenW - 15, 1);
        self.nameLab.frame = CGRectMake(15, 0, BXScreenW - 150, 40);
        self.WordsLab.frame = CGRectMake(BXScreenW - 135, 0, 120, 40);
        self.WordsLab.textAlignment = NSTextAlignmentRight;
        self.nameLab.text = [NSString stringWithFormat:@"%ld.%@",self.cellrow,viewModel.UserName];
        self.WordsLab.text = viewModel.Unit;
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
