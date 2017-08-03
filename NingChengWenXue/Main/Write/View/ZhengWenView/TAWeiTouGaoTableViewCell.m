//
//  TAWeiTouGaoTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "TAWeiTouGaoTableViewCell.h"

@implementation TAWeiTouGaoTableViewCell

- (void)setViewModel:(ZWDetailModel *)viewModel{
    self.nameLab.font = [UIFont systemFontOfSize:15];
    self.rankLab.layer.cornerRadius = 1.5;
    self.rankLab.text = [NSString stringWithFormat:@"%ld",self.row + 1];
    
    self.nameLab.text = viewModel.FictionName;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.FictionImage] placeholderImage:[UIImage imageNamed:@"书"]];
    self.writorLab.text = [NSString stringWithFormat:@"by:%@",viewModel.AuthorName];
    self.numLab.text = [NSString stringWithFormat:@"%ld",viewModel.ClickCount];
    
    if (self.row == 0) {
        self.rankLab.backgroundColor = BXColor(230,78,54);
    }else if (self.row == 1){
        self.rankLab.backgroundColor = BXColor(50,205,189);
    }else if (self.row == 2){
        self.rankLab.backgroundColor = BXColor(55,142,211);
    }else{
        self.rankLab.backgroundColor = [UIColor clearColor];
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
