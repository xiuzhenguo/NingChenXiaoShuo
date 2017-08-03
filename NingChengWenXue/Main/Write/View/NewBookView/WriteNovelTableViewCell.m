//
//  WriteNovelTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 2017/7/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "WriteNovelTableViewCell.h"

@interface WriteNovelTableViewCell() <UITextFieldDelegate>

@end

@implementation WriteNovelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void) loadView {
    
    self.text = [[UITextField alloc] init];
    self.text.font = [UIFont systemFontOfSize:16];
    self.text.textColor = BXColor(152,152,152);
    self.text.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:self.text];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195, 195, 195);
    [self.contentView addSubview:self.lineLab];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.text.frame = CGRectMake(15, 0, BXScreenW - 60, 43.5);
    self.lineLab.frame = CGRectMake(0, 43.5, BXScreenW, 0.5);
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
