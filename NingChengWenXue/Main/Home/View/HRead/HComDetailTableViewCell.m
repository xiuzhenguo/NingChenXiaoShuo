//
//  HComDetailTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/2/27.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HComDetailTableViewCell.h"

@implementation HComDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadView];
    }
    return self;
}

- (void) loadView{
    
    self.comLable = [[UILabel alloc] init];
    self.comLable.font = ELEFont;
    self.comLable.textColor = [UIColor blueColor];
    [self.contentView addSubview:self.comLable];
    
    
}

- (void)setViewModel:(SPDetailModel *)viewModel{
    for (UIView *view in self.subviews) {
        view.frame = CGRectZero;
    }
    
    self.comLable.frame = CGRectMake(15, 10, BXScreenW - 30, 300);
    
    NSString  *strStaus = viewModel.ReplyName;
    NSString *strStau = viewModel.AuthorName;
    NSString *strr = @"";
    if ([viewModel.ReplyId isEqualToString:@"00000000-0000-0000-0000-000000000000"] || [viewModel.ReplyName isEqualToString:@""] || viewModel.ReplyName == nil) {
        
        strr = [NSString stringWithFormat:@"%@: %@",strStau,viewModel.Content];
    }else{
        strr = [NSString stringWithFormat:@"%@回复%@: %@",strStau,strStaus,viewModel.Content];
    }
    NSMutableAttributedString *attrDescribeStr = [[NSMutableAttributedString alloc] initWithString:strr];
    
    if (strStaus != nil && strStaus.length > 0) {
        [attrDescribeStr addAttribute:NSForegroundColorAttributeName
         
                                value:BXColor(35, 35, 35)
         
                                range:[strr rangeOfString:@"回复"]];
    }
    
    
    [attrDescribeStr addAttribute:NSForegroundColorAttributeName
     
                            value:BXColor(35, 35, 35)
     
                            range:[strr rangeOfString:viewModel.Content]];

    
    
    self.comLable.attributedText = attrDescribeStr;
    
    self.comLable.numberOfLines = 0;
    [self.comLable sizeToFit];
    self.height = CGRectGetMaxY(self.comLable.frame);
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
