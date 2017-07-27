//
//  HLitDetMidTableViewCell.m
//  NingChengWenXue
//
//  Created by 云彩 on 17/3/8.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "HLitDetMidTableViewCell.h"

@implementation HLitDetMidTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpTableViewCellUI];
    }
    return self;
}

- (void) setUpTableViewCellUI {
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = FIFFont;
    self.nameLab.textColor = BXColor(40,40,40);
    
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.image = [UIImage imageNamed:@"箭头"];
    
    
    self.numLab = [[UILabel alloc] init];
    self.numLab.font = THIRDFont;
    self.numLab.textColor = BXColor(152, 152, 152);
    
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = BXColor(195,195,195);
    
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = BXColor(242,242,242);
    
}

- (void)setViewModel:(NSArray *)viewModel{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    self.lineLab.frame = CGRectMake(0, 0, BXScreenW, 0.5);
    [self.contentView addSubview:self.lineLab];
    
    self.nameLab.frame = CGRectMake(15, 15, 70, 14);
    self.nameLab.text = @"社团成员";
    [self.contentView addSubview:self.nameLab];
    
    self.numLab.frame = CGRectMake(CGRectGetMaxX(self.nameLab.frame)+5, 15, 100, 14);
//    self.numLab.text = [NSString stringWithFormat:@"(%ld)",viewModel.];
    [self.contentView addSubview:self.numLab];
    
    self.imgView.frame = CGRectMake(BXScreenW - 30, 12, 15, 20);
    [self.contentView addSubview:self.imgView];
    
    for (int i = 0; i < self.count; i++) {
        UserItemModel *model = viewModel[i];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(15+71*i, CGRectGetMaxY(self.nameLab.frame)+15, 56, 56)];
        [img sd_setImageWithURL:[NSURL URLWithString:model.AuthorImage] placeholderImage:[UIImage imageNamed:@"打赏头像"]];
//        img.image = [UIImage imageNamed:@"作者头像"];
        [self.contentView addSubview:img];
        
        UILabel *author = [[UILabel alloc] init];
        if (model.UserRole == 1) {
            author.text = @"社长";
            author.backgroundColor = BXColor(251,202,24);
        }else if (model.UserRole == 2){
            author.text = @"管理员";
            author.backgroundColor = BXColor(154,224,76);
        }else{
            author.text = @"";
            author.backgroundColor = [UIColor whiteColor];
        }
        author.font = ELEFont;
        author.textColor = [UIColor whiteColor];
        author.textAlignment = NSTextAlignmentCenter;
        CGRect wid = Adaptive_Width(author.text, author.font);
        CGFloat width = wid.size.width;
        author.frame = CGRectMake(CGRectGetMidX(img.frame)-width/2-10, CGRectGetMaxY(img.frame)+5, width+20, 16);
        [self.contentView addSubview:author];
    }
    
    self.lineView.frame = CGRectMake(0, 131, BXScreenW, 10);
    [self.contentView addSubview:self.lineView];
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
