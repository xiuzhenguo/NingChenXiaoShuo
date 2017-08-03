//
//  NBEditSecTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/5/4.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "NBEditSecTableViewCell.h"

@implementation NBEditSecTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    
    self.imgbtn = [[UIButton alloc] init];
    [self.imgbtn setImage:[UIImage imageNamed:@"详情_1"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.imgbtn];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = FIFFont;
    self.nameLab.textColor = BXColor(40,40,40);
    [self.contentView addSubview:self.nameLab];
    
    self.statusLab = [[UILabel alloc] init];
    self.statusLab.font = THIRDFont;
    self.statusLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.statusLab];
    
    self.secLab = [[UILabel alloc] init];
    self.secLab.font = THIRDFont;
    self.secLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.secLab];
    
    self.imgLab = [[UILabel alloc] init];
    self.imgLab.font = THIRDFont;
    self.imgLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.imgLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.lineLab];
    
    
}

- (void)setViewModel:(SectionListModel *)viewModel{
    
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    
    self.imgbtn.frame = CGRectMake(BXScreenW - 90, 12, 80, 30);
    self.imgbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.imgbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.nameLab.text = viewModel.SectionName;
    CGRect rectLab = [self.nameLab.text boundingRectWithSize:CGSizeMake(BXScreenW-90, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.nameLab.font} context:nil];
    self.nameLab.frame = CGRectMake(15, 10, rectLab.size.width, 15);

    
    self.statusLab.frame = CGRectMake(CGRectGetMaxX(self.nameLab.frame)+5, 10, 40, 15);
    if (viewModel.SectionStatus == 3) {
        self.statusLab.text = @"草稿";
    }else if (viewModel.SectionStatus == 4){
        self.statusLab.text = @"待审核";
    }
    
    self.secLab.frame = CGRectMake(15, 30, BXScreenW - 140, 13);
    self.secLab.text = [NSString stringWithFormat:@"%ld字",viewModel.Character];
    [self.secLab sizeToFit];
    
    self.imgLab.frame = CGRectMake(CGRectGetMaxX(self.secLab.frame)+10, 30, 40, 13);
    self.imgLab.text = @"0图";
    

    self.lineLab.frame = CGRectMake(0, 52.5, BXScreenW, 0.5);
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
