//
//  HCatalogueTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/24.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HCatalogueTableViewCell.h"

@implementation HCatalogueTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont boldSystemFontOfSize:15];
    self.titleLab.textColor = BXColor(40,40,40);
    [self.contentView addSubview:self.titleLab];
    
    self.wordNumLab = [[UILabel alloc] init];
    self.wordNumLab.font = THIRDFont;
    self.wordNumLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.wordNumLab];
    
    self.imgNumlab = [[UILabel alloc] init];
    self.imgNumlab.font = THIRDFont;
    self.imgNumlab.textColor = BXColor(152,152,152);
//    [self.contentView addSubview:self.imgNumlab];
    
    self.typeLab = [[UILabel alloc] init];
    self.typeLab.font = THIRDFont;
    self.typeLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.typeLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.lineLab];
    
    
    
}

-(void)setViewModel:(MuLuListModel *)viewModel{
    
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    
    self.titleLab.text = viewModel.SectionName;
    self.titleLab.frame = CGRectMake(15, 4, BXScreenW - 30, 20);
    self.wordNumLab.frame = CGRectMake(15, CGRectGetMaxY(self.titleLab.frame)+5, 200, 15);
    self.wordNumLab.text = [NSString stringWithFormat:@"%ld字",viewModel.CharacterCount];
    [self.wordNumLab sizeToFit];
    self.imgNumlab.frame = CGRectMake(CGRectGetMaxX(self.wordNumLab.frame)+10, CGRectGetMaxY(self.titleLab.frame)+5, 80, 15);
    self.typeLab.frame = CGRectMake(BXScreenW - 50, 0, 35, 48);
//    self.imgNumlab.text = @"0图";
    if (viewModel.IsRead == 0) {
        self.typeLab.text = @"未读";
    }else{
        self.typeLab.text = @"已读";
    }
    
//    [self.imgNumlab sizeToFit];
    
    self.lineLab.frame = CGRectMake(0, 48.5, BXScreenW, 0.5);
}



@end

