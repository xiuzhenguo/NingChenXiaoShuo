//
//  HClubPersonTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/9.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HClubPersonTableViewCell.h"

@implementation HClubPersonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpTableViewCellUI];
    }
    return self;
}

-(void) setUpTableViewCellUI {
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.layer.cornerRadius = 22.5;
    self.imgView.clipsToBounds = YES;
    [self.contentView addSubview:self.imgView];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = [UIFont boldSystemFontOfSize:16];
    self.nameLab.textColor = BXColor(35,35,35);
    [self.contentView addSubview:self.nameLab];
    
    self.jobLab = [[UILabel alloc] init];
    self.jobLab.font = THIRDFont;
    self.jobLab.textAlignment = NSTextAlignmentCenter;
    self.jobLab.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.jobLab];
    
    self.bookLab = [[UILabel alloc] init];
    self.bookLab.font = THIRDFont;
    self.bookLab.textColor = BXColor(152,152,152);
    [self.contentView addSubview:self.bookLab];
    
    self.btn = [[UIButton alloc] init];
    self.btn.titleLabel.font = THIRDFont;
    self.btn.layer.cornerRadius = 3;
    self.btn.borderWidth = 0.5;
    [self.contentView addSubview:self.btn];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    [self.contentView addSubview:self.lineLab];
}

- (void)setViewModel:(UserItemModel *)viewModel{
    for (UIView *view in self.contentView.subviews) {
        view.frame = CGRectZero;
    }
    
    self.lineLab.frame = CGRectMake(0, 0, BXScreenW, 0.5);
    
    self.imgView.frame = CGRectMake(15, 10, 45, 45);
//    self.imgView.image = [UIImage imageNamed:@"打赏头像"];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:viewModel.AuthorImage] placeholderImage:[UIImage imageNamed:@"打赏头像"]];
    
    self.nameLab.text = viewModel.AuthorName;
    CGRect width = [self.nameLab.text boundingRectWithSize:CGSizeMake(BXScreenW - 195, 16) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.nameLab.font} context:nil];
    self.nameLab.frame = CGRectMake(70, 15, width.size.width, 16);
    
    // 测试
    if (viewModel.UserRole == 1) {
        
        self.jobLab.text = @"社长";
        self.jobLab.frame = CGRectMake(CGRectGetMaxX(self.nameLab.frame)+5, 15, 30, 16);
        self.jobLab.backgroundColor = BXColor(251,202,24);
    }else if (viewModel.UserRole == 2) {
        self.jobLab.text = @"管理员";
        self.jobLab.frame = CGRectMake(CGRectGetMaxX(self.nameLab.frame)+5, 15, 40, 16);
        self.jobLab.backgroundColor = BXColor(154,224,76);
    }
    
    self.bookLab.text = viewModel.FictionName;
    self.bookLab.frame = CGRectMake(70, CGRectGetMaxY(self.nameLab.frame)+5, BXScreenW - 155, 14);
    
    self.btn.frame = CGRectMake(BXScreenW - 75, 19, 60, 26);
    
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
