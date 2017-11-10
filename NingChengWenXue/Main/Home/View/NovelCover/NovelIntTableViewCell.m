//
//  NovelIntTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/21.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NovelIntTableViewCell.h"

@implementation NovelIntTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
   // 简介
    self.introLab = [[UILabel alloc] init];
    self.introLab.font = [UIFont boldSystemFontOfSize:13];
    self.introLab.textColor = BXColor(35, 35, 35);
    [self.contentView addSubview:self.introLab];
   //横线
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.lineLab];
  // 内容
    self.contentLab = [[UILabel alloc] init];
    self.contentLab.font = THIRDFont;
    self.contentLab.textColor = BXColor(35, 35, 35);
    [self.contentView addSubview:self.contentLab];
    
    self.moreImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.moreImg];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = BXColor(242, 242, 242);
    [self.contentView addSubview:self.lineView];
    
    self.array = @[@"小米",@"小米",@"小米回家吃饭",@"小米",@"小米回",@"小米回家淡淡的",@"小米家不会不会不会还不会吧",@"小米回和版本会不会不好不好不好不会不会不会吧好不不好家你你你您",@"小米家",@"小米",@"小米回家",];
    
}



-(void)setViewModel:(NovelDatailModel *)viewModel{
    
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    // 有问题
    self.introLab.frame = CGRectMake(15, 25, 100, 20);
    self.moreImg.frame = CGRectMake(BXScreenW - 25, 25, 10, 15);
    self.lineLab.frame = CGRectMake(15, 50, BXScreenW - 15, 1);
    self.contentLab.frame = CGRectMake(15, CGRectGetMaxY(self.lineLab.frame)+15, BXScreenW - 30, 2000);
    self.introLab.text = @"简介";
    self.moreImg.image = [UIImage imageNamed:@"箭头-1"];
    self.contentLab.text = viewModel.Intro;
    self.contentLab.numberOfLines = 0;
    [self.contentLab sizeToFit];
    
    NSArray *keyArr = [viewModel.KeyWord componentsSeparatedByString:@","];
    [self.pwView removeFromSuperview];
    self.pwView = [[PWContentView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.contentLab.frame)+15, BXScreenW - 30,450) dataArr:keyArr height:CGRectGetMaxY(self.contentLab.frame)+15];
    [self.pwView btnClickBlock:^(NSInteger index) {
        
        NSLog(@"%ld",(long)index);
        
    }];
    [self.contentView addSubview:self.pwView];
    
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.pwView.frame)+15, BXScreenW, 10);
    
    self.height = CGRectGetMaxY(self.lineView.frame);
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
