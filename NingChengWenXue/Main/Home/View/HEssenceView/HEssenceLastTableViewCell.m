//
//  HEssenceLastTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/3.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HEssenceLastTableViewCell.h"

@implementation HEssenceLastTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpTableViewCellUI];
    }
    return self;
}

- (void) setUpTableViewCellUI{
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = FIFFont;
    self.nameLab.textColor = BXColor(40, 40, 40);
    [self.contentView addSubview:self.nameLab];
    
    self.numLab = [[UILabel alloc] init];
    self.numLab.font = THIRDFont;
    self.numLab.textColor = BXColor(152,152,152);
    self.numLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.numLab];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
}

- (void)setViewModel:(ExceedListModel *)viewModel{
    
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    
    self.nameLab.frame = CGRectMake(15, 0, 180, 43.5);
    self.numLab.frame = CGRectMake(200, 0, BXScreenW-215, 43.5);
    self.lineLab.frame = CGRectMake(0, 43.5, 65, 0.5);
    
//    self.nameLab.text = [self.nameLab.text stringByAppendingFormat:@"%ld.重生之大设计师",self.row];
    self.nameLab.text = @"啦啦啦啦";
    self.numLab.text = @"88.88万字/88.88万点击";
}

- (void) cellForModel:(ExceedListModel *)viewModel Row:(NSInteger)row {
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    
    self.nameLab.frame = CGRectMake(15, 0, 180, 43.5);
    self.numLab.frame = CGRectMake(200, 0, BXScreenW-215, 43.5);
    self.lineLab.frame = CGRectMake(0, 43.5, 65, 0.5);
    
        self.nameLab.text = [NSString stringWithFormat:@"%ld.%@",row+1,viewModel.FictionName];
//    self.nameLab.text = @"啦啦啦啦";
    self.numLab.text = [NSString stringWithFormat:@"%@字/%@点击",viewModel.CharacterCount,viewModel.ClickCount];
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
