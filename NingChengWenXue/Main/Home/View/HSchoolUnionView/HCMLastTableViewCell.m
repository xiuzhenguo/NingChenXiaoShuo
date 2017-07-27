//
//  HCMLastTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/9.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HCMLastTableViewCell.h"

@implementation HCMLastTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpTableViewCellUI];
    }
    return self;
}

-(void) setUpTableViewCellUI {
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = FIFFont;
    self.titleLab.textColor = BXColor(40,40,40);
//    [self.contentView addSubview:self.titleLab];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = FIFFont;
    self.nameLab.textColor = BXColor(152,152,152);
    self.nameLab.numberOfLines = 0;
//    [self.contentView addSubview:self.nameLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
//    [self.contentView addSubview:self.lineLab];
}


-(void) setWithViewModel:(UnionHomeModel *)viewModel Row:(NSInteger)row {
    
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.lineLab];
    
    NSArray *arr = @[@"社团名称",@"所属学校",@"创建时间",@"社团简介"];
    self.titleLab.text = arr[row];
    CGRect width = Adaptive_Width(self.titleLab.text, self.titleLab.font)
    self.titleLab.frame = CGRectMake(15, 0, width.size.width, 43.5);
    
    if (row < 3) {
        self.nameLab.frame = CGRectMake(CGRectGetMaxX(self.titleLab.frame)+20, 0, BXScreenH - 20 - CGRectGetMaxX(self.titleLab.frame), 43.5);
        if (row == 0) {
            self.nameLab.text = viewModel.CommunityName;
        }else if (row == 1){
            self.nameLab.text = viewModel.SchoolName;
        }else if (row == 2){
            self.nameLab.text = viewModel.AddTime;
        }
        self.lineLab.frame = CGRectMake(0, 43.5, BXScreenH, 0.5);
        self.height = 44;
    }else{
        self.nameLab.frame =CGRectMake(CGRectGetMaxX(self.titleLab.frame)+20, 15, BXScreenW - 20 - CGRectGetMaxX(self.titleLab.frame)-45, 1000);
        self.nameLab.text = viewModel.CommunitIntro;
        [self.nameLab sizeToFit];
        self.height = CGRectGetMaxY(self.nameLab.frame)+15;
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
